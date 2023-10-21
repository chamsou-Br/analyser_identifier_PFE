/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable @typescript-eslint/no-unused-vars */
import React, { useEffect, useState } from "react";
import "../styles/invitationDetails.css";
import {
  FaDollarSign,
  FaMapMarked,
  FaSearchLocation,
  FaTruck,
} from "react-icons/fa";
import { IoMdCalendar, IoMdTime } from "react-icons/io";
import LigneInfoInCard from "../components/LignInfoCard/lignInfoIncard";
import TitleCard from "../components/TitleCard/titleCard";
import { useSelector } from "react-redux";
import { RootState, useAppDispatch } from "../state/store";
import { getDeliveryTypeTitle, getFormatDate } from "../helper/constant";
import { useParams } from "react-router-dom";
import Alert from "../components/Alert/alert";
import { Carousel } from "rsuite";
import {
  ModifyTransactionDetails,
  fetchTransactionDetails,
} from "../state/actions/transactionDetailsAction";
import HeaderPage from "../components/headerPage/headerPage";
import Status from "../components/TransactionStatus/status";
import InvitationActions from "../components/invitationAction/InvitationAction";
import ActionConfirmation from "../components/ActionConfirmation/ActionConfirmation";
import { fetchInvitationDetailsAPI, rejectInvitationAPI, validateInvitationAPI } from "../helper/callsApi";
import { Client, IInvitationComplete } from "../helper/types";
import Page404 from "../components/404/page404";
import BuyerOrSellerCard from "../components/Client/buyerOrSellerCard";

const InvitationDetails: React.FC = () => {
  const dispatch = useAppDispatch();
  const { uuid } = useParams();

  const transaction =  useSelector((state: RootState) => state.transaction).transaction;

  const [invitation,setInvitation] = useState<IInvitationComplete>() ;

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
    setrejectInvModal(false)
    const res = await rejectInvitationAPI(
      invitation?.uuid ? invitation.uuid : "k"
    );
    if (!res.invitation) {
      onAlert(false, res.error ? res.error : "an error has occured !", true);
    } else {
      onAlert(true,"",true)
      if (invitation) {
        setInvitation({
          ...res.invitation,
          Seller : invitation.Seller
        })

        if ( transaction != undefined &&  transaction?.Invitation.uuid == uuid ) {
          dispatch(
            ModifyTransactionDetails({
              ...transaction,
              Invitation: {
                ...res.invitation,
                Seller: invitation.Seller,
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
    setvalidateInvModal(false)
    const res = await validateInvitationAPI(
        invitation?.uuid ? invitation.uuid : ""
      );
      if (!res.invitation) {
        onAlert(false, res.error ? res.error : "an error has occured !", true);
      } else {
        onAlert(true,"",true)
        if (invitation) {
          setInvitation({
            ...res.invitation,
            Seller : invitation.Seller
          })

          if ( transaction != undefined &&  transaction?.Invitation.uuid == uuid ) {
            dispatch(
              ModifyTransactionDetails({
                ...transaction,
                Invitation: {
                  ...res.invitation,
                  Seller: invitation.Seller,
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
    if (uuid == transaction?.Invitation.uuid) {
      setInvitation(transaction.Invitation)
    }else {
      const res = await fetchInvitationDetailsAPI(uuid);
      if (res.invitation) {
        setInvitation(res.invitation);
      }
    }
  };

  useEffect(() => {
    console.log(uuid)
    getInvitation(uuid ? uuid : "");
  }, []);

  if (invitation) {
    return (
      <div key={uuid} className="invitation-details-page">
        <InvitationActions
          handleRejectInvitation={onRejectInvitation}
          handleValidateInvitation={onValidateInvitation}
        />
        <div className="invitation-section">
          <HeaderPage
            title={"Invitation : " + uuid}
            descr={"All infomation about invitaion " + invitation.uuid}
          />
          <div className="invitation-section-content">
            <div className="invitation-gallery inv-card">
              <Carousel
                placement={"bottom"}
                shape={"dot"}
                autoplay
                className="custom-slider"
              >
                {invitation.images?.map((img, i) => (
                  <img key={i} src={img} className="img-inv" />
                ))}
              </Carousel>
            </div>
            <div className="invitation-info inv-card">
              <TitleCard title="Invitation" />
              <div className="card-content">
                <div className="title">{invitation.product}</div>
                <div className="descr">{invitation.description}</div>
                <div className="card-information">
                  <div className="information-title">active</div>
                  <Status status={invitation.active} />
                </div>
                <LigneInfoInCard
                  title="Price"
                  value={invitation.price.toString()}
                  icon={<FaDollarSign />}
                />
                <LigneInfoInCard
                  title="Date"
                  value={getFormatDate(
                    invitation.date.toString().split("T")[0]
                  )}
                  icon={<IoMdCalendar />}
                />
                <LigneInfoInCard
                  title="Store Wilaya"
                  value={invitation.storeWilaya}
                  icon={<FaMapMarked />}
                />
                <LigneInfoInCard
                  title="Store Location"
                  value={invitation.storeLocation}
                  icon={<FaSearchLocation />}
                />
                <LigneInfoInCard
                  title="Delivery Type"
                  value={getDeliveryTypeTitle(invitation.deliveryType)}
                  icon={<FaTruck />}
                />
                <LigneInfoInCard
                  title="Delivery Time"
                  value={invitation.deliveryDelayHours.toString() + " H"}
                  icon={<IoMdTime />}
                />
                <LigneInfoInCard
                  title="Local Delivery Price"
                  value={invitation.localDeliveryPrice.toString()}
                  icon={<FaDollarSign />}
                />
              </div>
              <div className="seller">
              <BuyerOrSellerCard
                      onNavigate
                      client={{
                        client: Client.SELLER,
                        address: null,
                        birthDay: null,
                        businessName:
                          invitation.Seller.businessName,
                        description: null,
                        email: invitation.Seller.email,
                        firstName: invitation.Seller.firstName,
                        gender: null,
                        location: invitation.Seller.location,
                        phoneNumber: invitation.Seller.phoneNumber,
                        status:invitation.Seller.status,
                        wilaya: invitation.Seller.wilaya,
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
    return <Page404 />
  }
};

export default InvitationDetails;
