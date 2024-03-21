/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable @typescript-eslint/no-unused-vars */
import React, { useEffect, useState } from "react";
import "../styles/invitationDetails.css";
import {
  FaDollarSign,
  FaEye,
  FaMapMarked,
  FaMapMarkedAlt,
  FaSearchLocation,
  FaTruck,
} from "react-icons/fa";
import { IoMdCalendar, IoMdTime } from "react-icons/io";
import LigneInfoInCard from "../components/LignInfoCard/lignInfoIncard";
import TitleCard from "../components/TitleCard/titleCard";
import { useSelector } from "react-redux";
import { RootState, useAppDispatch } from "../state/store";
import {
  getDeliveryTypeTitle,
  getFormatDate,
  getFormatPrice,
  getFullFormatDate,
  getTimeAgo,
} from "../helper/constant";
import { useNavigate, useParams } from "react-router-dom";
import Alert from "../components/Alert/alert";
import { Carousel } from "rsuite";
import { ModifyTransactionDetails } from "../state/actions/transactionDetailsAction";
import HeaderPage from "../components/headerPage/headerPage";
import Status from "../components/TransactionStatus/status";
import InvitationActions from "../components/invitationAction/InvitationAction";
import ActionConfirmation from "../components/ActionConfirmation/ActionConfirmation";
import {
  rejectInvitationAPI,
  validateInvitationAPI,
} from "../helper/callsApi";
import { Client } from "../helper/types";
import Page404 from "../components/404/page404";
import BuyerOrSellerCard from "../components/Client/buyerOrSellerCard";
import {
  ModifyInvitationDetails,
  fetchInvitationDetails,
} from "../state/actions/invitationDetailsAction";
import DelivryType from "../components/DelivryType/delivryType";

const InvitationDetails: React.FC = () => {
  const dispatch = useAppDispatch();
  const { uuid } = useParams();

  const transaction = useSelector(
    (state: RootState) => state.transaction
  ).transaction;
  const invitations = useSelector(
    (state: RootState) => state.invitations
  ).invitations;

  const navigate = useNavigate();

  const invitationState = useSelector((state: RootState) => state.invitation);

  const [rejectInvModal, setrejectInvModal] = useState(false);
  const [validateInvModal, setvalidateInvModal] = useState(false);

  /* start Invitation function */

  const onRejectInvitation = () => {
    setrejectInvModal(true);
  };

  const handleCancelRejectInvitation = () => {
    setrejectInvModal(false);
  };

  const handleSubmitRejectInvitation = async () => {
    setrejectInvModal(false);
    const res = await rejectInvitationAPI(
      invitationState.invitation?.uuid ? invitationState.invitation?.uuid : "k"
    );
    if (!res.invitation) {
      onAlert(false, res.error ? res.error : "an error has occured !", true);
    } else {
      onAlert(true, "", true);
      if (invitationState.invitation) {
        dispatch(
          ModifyInvitationDetails({
            ...res.invitation,
            Seller: invitationState.invitation.Seller,
            InvitationTransactions : invitationState.invitation.InvitationTransactions
          })
        );
        if (transaction != undefined && transaction?.Invitation.uuid == uuid) {
          dispatch(
            ModifyTransactionDetails({
              ...transaction,
              Invitation: {
                ...res.invitation,
                Seller: invitationState.invitation.Seller,
              },
            })
          );
        }
      }
    }
  };

  const onValidateInvitation = () => {
    setvalidateInvModal(true);
  };

  const handleCancelValidateInvitation = () => {
    setvalidateInvModal(false);
  };

  const handleSubmitValidateInvitation = async () => {
    setvalidateInvModal(false);
    const res = await validateInvitationAPI(
      invitationState.invitation?.uuid ? invitationState.invitation.uuid : ""
    );
    if (!res.invitation) {
      onAlert(false, res.error ? res.error : "an error has occured !", true);
    } else {
      onAlert(true, "", true);
      if (invitationState.invitation) {
        dispatch(
          ModifyInvitationDetails({
            ...res.invitation,
            Seller: invitationState.invitation.Seller,
            InvitationTransactions : invitationState.invitation.InvitationTransactions
          })
        );
        if (transaction != undefined && transaction?.Invitation.uuid == uuid) {
          dispatch(
            ModifyTransactionDetails({
              ...transaction,
              Invitation: {
                ...res.invitation,
                Seller: invitationState.invitation.Seller,
              },
            })
          );
        }
      }
    }
  };

  /* End Invitation function */

  /* start alert function */

  const [alert, setAlert] = React.useState({
    isSucess: false,
    message: "",
    show: false,
  });

  const onAlert = (isSucess: boolean, message: string, show: boolean) => {
    setAlert({
      isSucess,
      message,
      show,
    });
  };

  /* End alert function */

  const getInvitation = async (uuid: string) => {
    dispatch(fetchInvitationDetails(uuid));
  };

  useEffect(() => {
    getInvitation(uuid ? uuid : "");
  }, []);

  const handleNavigateToTransactionDetails = (uuid: string) => {
    navigate("/details/" + uuid);
  };

  if (!invitationState.error && invitationState.invitation) {
    return (
      <div key={uuid} className="invitation-details-page">
        <InvitationActions
          handleRejectInvitation={onRejectInvitation}
          handleValidateInvitation={onValidateInvitation}
        />
        <div className="invitation-section">
          <HeaderPage
            title={"Invitation : " + uuid}
            descr={
              "All information about invitation " +
              invitationState.invitation.uuid
            }
          />
          <div className="invitation-section-content">
            <div className="invitation-gallery inv-card">
              <Carousel
                placement={"bottom"}
                shape={"dot"}
                autoplay
                className="custom-slider"
              >
                {invitationState.invitation.images?.map((img, i) => (
                  <img key={i} src={img} className="img-inv" />
                ))}
              </Carousel>
              <div className="client-transactions-content ">
                {invitationState.invitation.InvitationTransactions &&
                  invitationState.invitation.InvitationTransactions.map(
                    (transaction, index) => (
                      <div
                        key={transaction.uuid}
                        className="client-transaction-content "
                      >
                        <div
                          onClick={() =>
                            handleNavigateToTransactionDetails(
                              transaction!.uuid
                            )
                          }
                          className="navigate-icon"
                        >
                          <FaEye />
                        </div>
                        <div className="title">
                          Transaction N {transaction!.uuid}
                        </div>
                        <div className="informations">
                          <LigneInfoInCard
                            title="Creation date"
                            value={getTimeAgo(transaction!.createdAt)}
                            icon={<IoMdTime />}
                          />
                          <LigneInfoInCard
                            title="Delivery date"
                            value={getFullFormatDate(transaction!.deliveryDate)}
                            icon={<IoMdCalendar />}
                          />
                          <LigneInfoInCard
                            title="Delivery place"
                            value={transaction!.deliveryPlace}
                            icon={<FaMapMarkedAlt />}
                          />
                          <LigneInfoInCard
                            title="Price"
                            value={getFormatPrice(transaction!.deliveryPrice)}
                            icon={<FaDollarSign />}
                          />
                          {transaction!.paymentDate && (
                            <LigneInfoInCard
                              title="payment date"
                              value={getFormatDate(transaction!.paymentDate)}
                              icon={<IoMdCalendar />}
                            />
                          )}
                          <div className="state-information">
                            <div className="title">status</div>
                            <Status status={transaction!.state} />
                          </div>
                        </div>
                      </div>
                    )
                  )}
              </div>
            </div>
            <div className="invitation-info inv-card">
              <TitleCard title="Invitation" />
              <div className="card-content">
                <div className="title">
                  {invitationState.invitation?.product}
                </div>
                <div className="descr">
                  {invitationState.invitation?.description}
                </div>
                <div className="card-information">
                  <div className="information-title">active</div>
                  <Status status={invitationState.invitation?.active} />
                </div>
                <LigneInfoInCard
                  title="Price"
                  value={invitationState.invitation.price.toString()}
                  icon={<FaDollarSign />}
                />
                <LigneInfoInCard
                  title="Date"
                  value={getFormatDate(invitationState.invitation.date)}
                  icon={<IoMdCalendar />}
                />
                <LigneInfoInCard
                  title="Store Wilaya"
                  value={invitationState.invitation.storeWilaya}
                  icon={<FaMapMarked />}
                />
                <LigneInfoInCard
                  title="Store Location"
                  value={invitationState.invitation.storeLocation}
                  icon={<FaSearchLocation />}
                />
                <div className="card-information">
                  <div className="information-title">Delivery Type</div>
                  <DelivryType
                    deliveryType={getDeliveryTypeTitle(
                      invitationState.invitation.deliveryType
                    )}
                  />
                </div>

                <LigneInfoInCard
                  title="Delivery Time"
                  value={
                    invitationState.invitation.deliveryDelayHours.toString() +
                    " H"
                  }
                  icon={<IoMdTime />}
                />
                <LigneInfoInCard
                  title="Local Delivery Price"
                  value={invitationState.invitation.localDeliveryPrice.toString()}
                  icon={<FaDollarSign />}
                />
              </div>
              <div className="seller">
                <BuyerOrSellerCard
                  onNavigate
                  client={{
                    ...invitationState.invitation.Seller,
                    client: Client.SELLER,
                    address: null,
                    birthDay: null,
                    businessName:
                      invitationState.invitation.Seller.businessName,
                    description: null,
                    email: invitationState.invitation.Seller.email,
                    firstName: invitationState.invitation.Seller.firstName,
                    gender: null,
                    location: invitationState.invitation.Seller.location,
                    phoneNumber: invitationState.invitation.Seller.phoneNumber,
                    status: invitationState.invitation.Seller.status,
                    wilaya: invitationState.invitation.Seller.wilaya,
                    createdAt: invitationState.invitation.Seller.createdAt,
                    rib: invitationState.invitation.Seller.rib,
                    official: invitationState.invitation.Seller.official,
                  }}
                />
              </div>
            </div>
          </div>
        </div>
        <ActionConfirmation
          confirmationText=" Are you sure that you want to reject this invitation ?"
          handleCanceled={handleCancelRejectInvitation}
          isOpen={rejectInvModal}
          handleSubmit={handleSubmitRejectInvitation}
        />

        <ActionConfirmation
          confirmationText=" Are you sure that you want to validate this invitation ?"
          handleCanceled={handleCancelValidateInvitation}
          isOpen={validateInvModal}
          handleSubmit={handleSubmitValidateInvitation}
        />
        <Alert alert={alert} onAlert={onAlert} />
      </div>
    );
  } else {
    return <Page404 />;
  }
};

export default InvitationDetails;
