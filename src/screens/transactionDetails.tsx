/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable @typescript-eslint/no-unused-vars */
import React, { useState, useEffect } from "react";
import "../styles/transactionDetails.css";
import {
  FaDollarSign,
  FaMapMarked,
  FaSearchLocation,
  FaTruck,
  FaMapMarkedAlt,
} from "react-icons/fa";
import { IoMdCalendar, IoMdTime } from "react-icons/io";
import LigneInfoInCard from "../components/LignInfoCard/lignInfoIncard";
import TitleCard from "../components/TitleCard/titleCard";
import BuyerOrSellerCard from "../components/Client/buyerOrSellerCard";
import Reclamationcard from "../components/ReclamationCard/reclamationcard";
import {
  Client,
  IAdminFullTransaction,
  ITransactionClosing,
} from "../helper/types";
import { useSelector } from "react-redux";
import { RootState } from "../state/store";
import Status from "../components/TransactionStatus/status";
import {
  getDeliveryTypeTitle,
  getFormatDate,
  getFormatPrice,
} from "../helper/constant";
import { useParams, useNavigate } from "react-router-dom";
import HeaderPage from "../components/headerPage/headerPage";
import TransactionActions from "../components/TransactionActions/transactionActions";
import TransactionNote from "../components/TransactionNote/transactionNote";
import TransactionStatusUpdate from "../components/TransactionStateUpdate/transactionStateUpate";
import Alert from "../components/Alert/alert";
import {
  addNoteOfTransactionAPI,
  changeStateOfTransactionAPI,
  closeTransactionAPI,
  fetchTransactionAPI,
  getClosingInfoAPI,
} from "../helper/callsApi";
import HistorieTransactioncard from "../components/transactionHistory/TransactionHistory";
import CloseTransactionAction from "../components/closeTransactionAction/closeTransactionAction";

type infoClosing = {
  info: ITransactionClosing | undefined;
  error: string | null | undefined;
};

const TransactionDetails: React.FC = () => {
  const { uuid } = useParams();

  const styleIsBuyerOrSellerIsClaimsOrHistories = {
    borderBottom: "3px solid #568deb",
    color: "#568deb",
  };

  const navigate = useNavigate();
  const [isBuyerOrSeller, setIsBuyerOrSeller] = useState<number>(0);
  const [isClaimsOrHistories, setIsClaimsOrHistorie] = useState<number>(0);
  const [search, setSearch] = useState<string>("");
  const [isOpenModalOfTransactionNote, setisOpenModalOfTransactionNote] =
    useState<boolean>(false);
  const [isOpenModalOfTransactionClose, setisOpenModalOfTransactionClose] =
    useState<boolean>(false);
  const [
    isOpenModalOfChangementTransactionState,
    setisOpenModalOfChangementTransactionState,
  ] = useState<boolean>(false);

  const [infoClosing, setInfoClosing] = useState<infoClosing>({
    error: null,
    info: undefined,
  });

  const TransactionState = useSelector(
    (state: RootState) => state.transactions
  );
  const [transaction, setTransaction] = useState<IAdminFullTransaction>();

  /* start Closing Info function */

  const fetchClosingInfo = async (uuid: string) => {
    const res = await getClosingInfoAPI(uuid);
    if (res.error) setInfoClosing({ error: res.error, info: undefined });
    else setInfoClosing({ error: null, info: res.info });
  };

  /* End ClosingInfo functions */

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

  /* End alert functions */

  /* Start Action functions */

  const handleOpenModalOfChangementTransactionState = () => {
    setisOpenModalOfChangementTransactionState(true);
  };

  const handleCloseModalOfChangementTransactionState = () => {
    setisOpenModalOfChangementTransactionState(false);
  };

  const handleSubmitChangmentTransactionState = async (
    decision: string,
    raison: string
  ) => {
    setisOpenModalOfChangementTransactionState(false);
    console.log(decision,raison)
    const res = await changeStateOfTransactionAPI(
      uuid ? uuid : "",
      decision,
      raison
    );
    if (res.error) {
      onAlert(false, res.error, true);
    } else {
      const data = (
        await fetchTransactionAPI(res.transaction ? res.transaction.uuid : "")
      ).transaction;
      const info = await getClosingInfoAPI(
        res.transaction ? res.transaction.uuid : ""
      );
      setInfoClosing({ error: info.error, info: info.info });
      setTransaction(data);
      onAlert(true, "", true);
    }
  };

  const handleOpenModalOfTransactionClose = () => {
    setisOpenModalOfTransactionClose(true);
  };

  const handleCanceledModalOfTransactionClose = () => {
    setisOpenModalOfTransactionClose(false);
  };

  const handleSubmitTransactionClose = async () => {
    setisOpenModalOfTransactionClose(false);
    const res = await closeTransactionAPI(uuid ? uuid : "");
    if (res.error) {
      onAlert(false, res.error, true);
    } else {
      const data = (
        await fetchTransactionAPI(res.transaction ? res.transaction.uuid : "")
      ).transaction;
      setTransaction(data);
      onAlert(true, "", true);
    }
  };

  const handleOpenModalOfNote = () => {
    setisOpenModalOfTransactionNote(true);
  };

  const handleCanceledModalOfNote = () => {
    setisOpenModalOfTransactionNote(false);
  };

  const handleSubmitNote = async (title: string, text: string) => {
    setisOpenModalOfTransactionNote(false);
    const res = await addNoteOfTransactionAPI(uuid ? uuid : "", title, text);
    if (res.error) {
      onAlert(false, res.error, true);
    } else {
      setTransaction(res.transaction);
      onAlert(true, "", true);
    }
  };

  /* End Action Functions */

  /* Start  Buyer , Seller , Reclamation , Histories Functions */

  const handleShowBuyerInfo = () => {
    setIsBuyerOrSeller(0);
  };
  const handleShowSellerInfo = () => {
    setIsBuyerOrSeller(1);
  };
  const handleShowReclamationsInfo = () => {
    setIsClaimsOrHistorie(0);
  };

  const handleShowHistoriesInfo = () => {
    setIsClaimsOrHistorie(1);
  };

  /* End  Buyer , Seller , Reclamation , Histories Functions */

  /* Start Search Functions */

  const handleInputSearchChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setSearch(e.target.value);
  };

  const handleInputFocus = () => {
    setSearch("");
  };

  const handleSearch = () => {
    navigate("/details/" + search);
  };

  /* End Search Functions */

  const getTransaction = async () => {
    const data = TransactionState.transactions.filter(
      (it) => it.uuid.toLocaleLowerCase() === uuid?.toLocaleLowerCase()
    )[0];
    if (data) {
      setTransaction(data);
    } else {
      const res = await fetchTransactionAPI(uuid ? uuid : "");
      if (res.error) {
        navigate("/");
      } else {
        setTransaction(res.transaction);
      }
    }
  };

  useEffect(() => {
    getTransaction();
    fetchClosingInfo(uuid ? uuid : "");
  }, [uuid]);

  if (transaction) {
    return (
      <div key={uuid} className="transaction-details-page">
        <TransactionActions
          handleAddNoteAction={handleOpenModalOfNote}
          handleChangeTransactionStatusAction={
            handleOpenModalOfChangementTransactionState
          }
          handleCloseTransactionAction={handleOpenModalOfTransactionClose}
        />
        <div className="transaction-section">
          <HeaderPage
            value={search}
            isSeach
            title="Transaction Details"
            descr="All Information about Transaction , Invitaion , seller and Buyer"
            handleChangeInput={handleInputSearchChange}
            handleFocusInput={handleInputFocus}
            handleSearch={handleSearch}
          />
          <div className="transaction-section-content">
            <div className="transaction card">
              <TitleCard title="Transaction" />
              <div className="card-content">
                <div className="title">Transaction N {transaction.uuid}</div>
                <div className="card-information">
                  <div className="information-title">Outcom</div>
                  <Status status={transaction.outcome} />
                </div>
                <LigneInfoInCard
                  title="Delivry date"
                  value={getFormatDate(
                    transaction.deliveryDate.toString().split("T")[0]
                  )}
                  icon={<IoMdCalendar />}
                />
                <LigneInfoInCard
                  title="Delivry type"
                  value={getDeliveryTypeTitle(transaction.deliveryType)}
                  icon={<FaTruck />}
                />
                <LigneInfoInCard
                  title="Delivry place"
                  value={transaction.deliveryPlace}
                  icon={<FaMapMarkedAlt />}
                />
                <LigneInfoInCard
                  title="Price"
                  value={getFormatPrice(transaction.deliveryPrice)}
                  icon={<FaDollarSign />}
                />
                <LigneInfoInCard
                  title="payment date"
                  value={getFormatDate(
                    transaction.paymentDate.toString().split("T")[0]
                  )}
                  icon={<IoMdCalendar />}
                />
                <div className="card-information">
                  <div className="information-title">status</div>
                  <Status status={transaction.state} />
                </div>
                <div className="Claims-Histories-container">
                  <div className="header">
                    <div
                      style={
                        isClaimsOrHistories === 0
                          ? styleIsBuyerOrSellerIsClaimsOrHistories
                          : {}
                      }
                      onClick={handleShowReclamationsInfo}
                    >
                      Reclamations
                    </div>
                    <div
                      style={
                        isClaimsOrHistories === 1
                          ? styleIsBuyerOrSellerIsClaimsOrHistories
                          : {}
                      }
                      onClick={handleShowHistoriesInfo}
                    >
                      Histories
                    </div>
                  </div>

                  {isClaimsOrHistories === 0 ? (
                    <div className="reclamations-container">
                      {transaction.Claims.slice()
                        .reverse()
                        .map((claim) => (
                          <Reclamationcard
                            key={claim.id} // Don't forget to add a unique key when mapping components
                            onNavigateToDetails={() => {}}
                            sender={claim.sender}
                            text={claim.text}
                            raison={claim.reason}
                            date={getFormatDate(
                              claim.createdAt.toString().split("T")[0]
                            )}
                          />
                        ))}
                    </div>
                  ) : (
                    <div className="reclamations-container">
                      {transaction.Histories.slice()
                        .reverse()
                        .map((hist) => (
                          <HistorieTransactioncard
                            key={hist.id} // Don't forget to add a unique key when mapping components
                            action={hist.action}
                            actionType={hist.actionType}
                            raison={hist.reason}
                            date={getFormatDate(
                              hist.createdAt.toString().split("T")[0]
                            )}
                          />
                        ))}
                    </div>
                  )}
                </div>
              </div>
            </div>
            <div className="product-details card">
              <TitleCard title="Invitation" />
              <div className="card-content">
                <div className="title">{transaction.Invitation.product}</div>
                <div className="descr">
                  {transaction.Invitation.description}
                </div>
                <LigneInfoInCard
                  title="Price"
                  value={transaction.Invitation.price.toString()}
                  icon={<FaDollarSign />}
                />
                <LigneInfoInCard
                  title="Date"
                  value={getFormatDate(
                    transaction.Invitation.date.toString().split("T")[0]
                  )}
                  icon={<IoMdCalendar />}
                />
                <LigneInfoInCard
                  title="Store Wilaya"
                  value={transaction.Invitation.storeWilaya}
                  icon={<FaMapMarked />}
                />
                <LigneInfoInCard
                  title="Store Location"
                  value={transaction.Invitation.storeLocation}
                  icon={<FaSearchLocation />}
                />
                <LigneInfoInCard
                  title="Delivery Type"
                  value={getDeliveryTypeTitle(
                    transaction.Invitation.deliveryType
                  )}
                  icon={<FaTruck />}
                />
                <LigneInfoInCard
                  title="Delivery Time"
                  value={
                    transaction.Invitation.deliveryDelayHours.toString() + " H"
                  }
                  icon={<IoMdTime />}
                />
                <LigneInfoInCard
                  title="Local Delivery Price"
                  value={transaction.Invitation.localDeliveryPrice.toString()}
                  icon={<FaDollarSign />}
                />
                <div className="Seller-buyer-container">
                  <div className="header">
                    <div
                      style={
                        isBuyerOrSeller === 0
                          ? styleIsBuyerOrSellerIsClaimsOrHistories
                          : {}
                      }
                      onClick={handleShowBuyerInfo}
                    >
                      Buyer Info
                    </div>
                    <div
                      style={
                        isBuyerOrSeller === 1
                          ? styleIsBuyerOrSellerIsClaimsOrHistories
                          : {}
                      }
                      onClick={handleShowSellerInfo}
                    >
                      Seller Info
                    </div>
                  </div>

                  {isBuyerOrSeller == 0 ? (
                    <BuyerOrSellerCard
                      onNavigate
                      client={{
                        client: Client.BUYER,
                        address: transaction.Buyer.address,
                        birthDay: transaction.Buyer.birthDay,
                        businessName: null,
                        description: null,
                        email: transaction.Buyer.email,
                        firstName: transaction.Buyer.firstName,
                        gender: transaction.Buyer.gender,
                        location: null,
                        phoneNumber: transaction.Buyer.phoneNumber,
                        status: transaction.Buyer.status,
                        wilaya: transaction.Buyer.wilaya,
                      }}
                    />
                  ) : (
                    <BuyerOrSellerCard
                      onNavigate
                      client={{
                        client: Client.SELLER,
                        address: null,
                        birthDay: null,
                        businessName:
                          transaction.Invitation.Seller.businessName,
                        description: null,
                        email: transaction.Invitation.Seller.email,
                        firstName: transaction.Invitation.Seller.firstName,
                        gender: null,
                        location: transaction.Invitation.Seller.location,
                        phoneNumber: transaction.Invitation.Seller.phoneNumber,
                        status: transaction.Invitation.Seller.status,
                        wilaya: transaction.Invitation.Seller.wilaya,
                      }}
                    />
                  )}
                </div>
              </div>
            </div>
          </div>
        </div>
        <TransactionNote
          isOpen={isOpenModalOfTransactionNote}
          handleCloseCanceled={handleCanceledModalOfNote}
          handleCloseSucessed={handleSubmitNote}
        />
        <CloseTransactionAction
          isOpen={isOpenModalOfTransactionClose}
          handleCanceled={handleCanceledModalOfTransactionClose}
          handleSubmit={handleSubmitTransactionClose}
          uuid={transaction.uuid}
          info={infoClosing}
        />
        <TransactionStatusUpdate
          isOpen={isOpenModalOfChangementTransactionState}
          handleCloseCanceled={handleCloseModalOfChangementTransactionState}
          handleCloseSucessed={handleSubmitChangmentTransactionState}
        />
        <Alert alert={alert} onAlert={onAlert} />
      </div>
    );
  }
};

export default TransactionDetails;
