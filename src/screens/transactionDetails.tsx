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
  FaEye,
  FaTimes,
  FaEnvelope,
  FaPhone,
  FaFirstOrder,
} from "react-icons/fa";
import { IoMdCalendar, IoMdTime } from "react-icons/io";
import LigneInfoInCard from "../components/LignInfoCard/lignInfoIncard";
import TitleCard from "../components/TitleCard/titleCard";
import BuyerOrSellerCard from "../components/Client/buyerOrSellerCard";
import Reclamationcard from "../components/ReclamationCard/reclamationcard";
import { CiDeliveryTruck } from "react-icons/ci";
import {
  Client,
  EntityStatus,
  IPaymentWithGroup,
  ITransactionClosing,
  PaymentGroupStatus,
  TransactionStatus,
} from "../helper/types";
import { useSelector } from "react-redux";
import { RootState, useAppDispatch } from "../state/store";
import Status from "../components/TransactionStatus/status";
import {
  getDeliveryTypeTitle,
  getFormatPrice,
  getFullFormatDate,
  getTimeAgo,
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
  createPaymentAPI,
  getClosingInfoAPI,
  getPaymentsOfTransactionAPI,
} from "../helper/callsApi";
import HistorieTransactioncard from "../components/transactionHistory/TransactionHistory";
import CloseTransactionAction from "../components/closeTransactionAction/closeTransactionAction";
import {
  AddTransactionDetails,
  ModifyTransactionDetails,
  fetchTransactionDetails,
} from "../state/actions/transactionDetailsAction";
import Page404 from "../components/404/page404";
import DelivryType from "../components/DelivryType/delivryType";
import ActionConfirmation from "../components/ActionConfirmation/ActionConfirmation";
import { GrTransaction } from "react-icons/gr";

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
  const dispatch = useAppDispatch();
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

  const [isOpeModalOfPayment, setIsOpeModalOfPayment] = useState(false);

  const [infoClosing, setInfoClosing] = useState<infoClosing>({
    error: null,
    info: undefined,
  });

  const [sellerPayment, setSellerPayment] = useState<IPaymentWithGroup>();
  const [buyerPayment, setBuyerPayment] = useState<IPaymentWithGroup>();

  const Transactions = useSelector(
    (state: RootState) => state.transactions
  ).transactions;

  const transaction = useSelector(
    (state: RootState) => state.transaction
  ).transaction;

  const error = useSelector((state: RootState) => state.transaction).error;
  const handleNavigateToInvitationDetails = () => {
    navigate("/invitation/" + transaction?.Invitation.uuid);
  };

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
    const res = await changeStateOfTransactionAPI(
      uuid ? uuid : "",
      decision,
      raison
    );
    if (res.error) {
      onAlert(false, res.error, true);
    } else {
      if (res.transaction != undefined && transaction != undefined)
        dispatch(
          ModifyTransactionDetails({
            ...res.transaction,
            Claims: transaction?.Claims,
            Histories: transaction.Histories,
          })
        );
      const info = await getClosingInfoAPI(
        res.transaction ? res.transaction.uuid : ""
      );
      setInfoClosing({ error: info.error, info: info.info });
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
      if (res.transaction != undefined && transaction != undefined)
        dispatch(
          ModifyTransactionDetails({
            ...res.transaction,
            Claims: transaction.Claims,
            Histories: transaction.Histories,
          })
        );

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
      dispatch(ModifyTransactionDetails(res.transaction));
      onAlert(true, "", true);
    }
  };

  /* End Action Functions */

  /* start add payment Modal */

  const handleOpenModalOfPayment = () => {
    setIsOpeModalOfPayment(true);
  };

  const handleCanceledModalOfPayment = () => {
    setIsOpeModalOfPayment(false);
  };

  const handleSubmitAddPayment = async () => {
    setIsOpeModalOfPayment(false);
    const res = await createPaymentAPI(transaction?.uuid || "");
    if (res.error) onAlert(false, res.error, true);
    else {
      dispatch(AddTransactionDetails(res.transaction!));
      onAlert(true, "the payment has been successfully created", true);
    }
  };

  /* End add payment Modal */

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
    setSearch("");
  };

  /* End Search Functions */

  const getTransaction = async (uuid: string) => {
    console.log(transaction)
    if (!transaction || transaction.uuid != uuid) {
      const data = Transactions.filter(
        (it) => it.uuid.toLocaleLowerCase() === uuid?.toLocaleLowerCase()
      )[0];
      if (data) {
        dispatch(AddTransactionDetails(data));
      } else {
        dispatch(fetchTransactionDetails(uuid ? uuid : ""));
      }
    }
  };

  const fetchPaymentOfTransaction = async (uuid: string) => {
    const res = await getPaymentsOfTransactionAPI(uuid);
    setBuyerPayment(res.buyerPayment);
    setSellerPayment(res.sellerPayment);
  };

  useEffect(() => {
    getTransaction(uuid ? uuid : "");
    fetchClosingInfo(uuid ? uuid : "");
    fetchPaymentOfTransaction(uuid ? uuid : "");
  }, [uuid]);

  const onNavigateToPaymentOfTransaction = (payment: IPaymentWithGroup) => {
    if (
      payment &&
      payment.PaymentGroup &&
      payment.PaymentGroup.state === PaymentGroupStatus.APPROVED
    ) {
      navigate("/payment/" + payment.PaymentGroup.id);
    }
  };

  if (transaction && !error) {
    return (
      <div key={uuid} className="transaction-details-page">
        <TransactionActions
          handleAddNoteAction={handleOpenModalOfNote}
          handleChangeTransactionStatusAction={
            handleOpenModalOfChangementTransactionState
          }
          isPaymentCreated={
            transaction.BuyerPaymentId || transaction.SellerPaymentId
              ? true
              : false
          }
          handleCloseTransactionAction={handleOpenModalOfTransactionClose}
          handleAddPayment={handleOpenModalOfPayment}
        />
        <div className="transaction-section">
          <HeaderPage
            value={search}
            isSeach
            title="Transaction Details"
            descr="All Information about Transaction , Invitation , seller and Buyer"
            handleChangeInput={handleInputSearchChange}
            handleFocusInput={handleInputFocus}
            handleSearch={handleSearch}
          />
          <div className="transaction-section-content">
            <div className="transaction card">
              <TitleCard title="Transaction" />
              <div className="card-content">
                <div className="title">Transaction : {transaction.uuid}</div>
                <div className="card-information">
                  <div className="information-title">Outcome</div>
                  <Status status={transaction.outcome} />
                </div>
                <LigneInfoInCard
                  title="Creation date"
                  value={getTimeAgo(transaction.createdAt)}
                  icon={<IoMdTime />}
                />
                <LigneInfoInCard
                  title="Delivery date"
                  value={getFullFormatDate(transaction.deliveryDate)}
                  icon={<IoMdCalendar />}
                />
                <LigneInfoInCard
                  title="Delivery Type"
                  value={getDeliveryTypeTitle(transaction.deliveryType)}
                  icon={<FaMapMarked />}
                />
                <LigneInfoInCard
                  title="Delivery place"
                  value={transaction.deliveryPlace}
                  icon={<FaMapMarkedAlt />}
                />
                <LigneInfoInCard
                  title="Price"
                  value={getFormatPrice(transaction.deliveryPrice)}
                  icon={<FaDollarSign />}
                />
                {transaction.paymentDate && (
                  <LigneInfoInCard
                    title="payment date"
                    value={getFullFormatDate(transaction.paymentDate)}
                    subDescr={getTimeAgo(transaction.paymentDate)}
                    icon={<IoMdCalendar />}
                  />
                )}

                <div className="card-information">
                  <div className="information-title">status</div>
                  <Status status={transaction.state} />
                </div>
                {transaction.satimOrderNumber && (
                  <LigneInfoInCard
                    title="satim Order"
                    value={transaction.satimOrderNumber}
                    icon={<FaFirstOrder />}
                  />
                )}
                {transaction.DeliveryOffice && (
                  <div className="transaction-delivery-company">
                    <LigneInfoInCard
                      title="delivery company"
                      value={transaction.DeliveryOffice.company}
                      icon={<CiDeliveryTruck />}
                    />
                    <LigneInfoInCard
                      title="Email"
                      value={transaction.DeliveryOffice.email}
                      icon={<FaEnvelope />}
                    />
                    <LigneInfoInCard
                      title="phone number"
                      value={transaction.DeliveryOffice.phoneNumber}
                      icon={<FaPhone />}
                    />
                  </div>
                )}
                {(sellerPayment || buyerPayment) && (
                  <div className="paymentOfTransactionTop"></div>
                )}
                {sellerPayment && (
                  <div className="paymentOfTransaction">
                    <LigneInfoInCard
                      title="payment of seller"
                      value={
                        sellerPayment.PaymentGroup &&
                        sellerPayment.PaymentGroup.state ==
                          PaymentGroupStatus.APPROVED
                          ? "Approved"
                          : "Pending"
                      }
                      subDescr={
                        sellerPayment &&
                        sellerPayment.PaymentGroup &&
                        sellerPayment.PaymentGroup.state ===
                          PaymentGroupStatus.APPROVED
                          ? "Detail"
                          : ""
                      }
                      action={() =>
                        onNavigateToPaymentOfTransaction(sellerPayment)
                      }
                      icon={<GrTransaction />}
                    />
                  </div>
                )}

                {buyerPayment && (
                  <div className="paymentOfTransaction">
                    <LigneInfoInCard
                      title="payment of buyer"
                      value={
                        buyerPayment.PaymentGroup &&
                        buyerPayment.PaymentGroup.state ==
                          PaymentGroupStatus.APPROVED
                          ? "Approved"
                          : "Pending"
                      }
                      subDescr={
                        buyerPayment &&
                        buyerPayment.PaymentGroup &&
                        buyerPayment.PaymentGroup.state ===
                          PaymentGroupStatus.APPROVED
                          ? "Detail"
                          : ""
                      }
                      action={() =>
                        onNavigateToPaymentOfTransaction(buyerPayment)
                      }
                      icon={<GrTransaction />}
                    />
                  </div>
                )}

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
                      History
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
                            date={getFullFormatDate(claim.createdAt)}
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
                            date={getFullFormatDate(hist.createdAt)}
                          />
                        ))}
                    </div>
                  )}
                </div>
              </div>
            </div>
            <div className="product-details card">
              <div
                onClick={handleNavigateToInvitationDetails}
                className="navigate-to-invitation-icon"
              >
                <FaEye />
              </div>
              <TitleCard title="Invitation" />
              <div className="card-content">
                <div className="title">{transaction.Invitation.product}</div>
                <div className="descr">
                  {transaction.Invitation.description}
                </div>
                <div className="card-information">
                  <div className="information-title">active</div>
                  <Status status={transaction.Invitation.active} />
                </div>
                <LigneInfoInCard
                  title="Creation date"
                  value={getTimeAgo(transaction.Invitation.createdAt)}
                  icon={<IoMdTime />}
                />
                <LigneInfoInCard
                  title="Price"
                  value={transaction.Invitation.price.toString()}
                  icon={<FaDollarSign />}
                />
                <LigneInfoInCard
                  title="Date"
                  value={getFullFormatDate(transaction.Invitation.date)}
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
                  title="Delivery Time"
                  value={
                    transaction.Invitation.deliveryDelayHours.toString() + " H"
                  }
                  icon={<IoMdTime />}
                />
                <LigneInfoInCard
                  title="Delivery Type"
                  value={getDeliveryTypeTitle(
                    transaction.Invitation.deliveryType
                  )}
                  icon={<FaMapMarked />}
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
                        ...transaction.Buyer,
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
                        ...transaction.Invitation.Seller,
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
                        createdAt: transaction.Invitation.Seller.createdAt,
                        rib : transaction.Invitation.Seller.rib,
                        official : transaction.Invitation.Seller.official
                      }}
                    />
                  )}
                </div>
              </div>
            </div>
          </div>
        </div>
        <ActionConfirmation
          confirmationText="Are you sure that you want to create payment to this Transaction !"
          isOpen={isOpeModalOfPayment}
          handleCanceled={handleCanceledModalOfPayment}
          handleSubmit={handleSubmitAddPayment}
        />
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
  } else {
    return <Page404 />;
  }
};

export default TransactionDetails;
