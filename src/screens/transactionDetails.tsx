/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable @typescript-eslint/no-unused-vars */
import React, { useState, useEffect } from "react";
import "../styles/transactionDetails.css";
import {
  FaDollarSign,
  FaMapMarked,
  FaSearchLocation,
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
  IPaymentWithGroup,
  PaymentGroupStatus,
} from "../helper/types";
import Status from "../components/TransactionStatus/status";
import {
  getDeliveryTypeTitle,
  getFullFormatDate,
} from "../helper/constant";
import { useParams, useNavigate } from "react-router-dom";
import HeaderPage from "../components/headerPage/headerPage";
import { fetchTransactionDetailsForDeliveryCompanyAPI } from "../helper/callsApi";

import Page404 from "../components/404/page404";
import { GrTransaction } from "react-icons/gr";


const TransactionDetails: React.FC = () => {
  const { uuid } = useParams();

  const styleIsBuyerOrSellerIsClaimsOrHistories = {
    borderBottom: "3px solid #568deb",
    color: "#568deb",
  };

  const navigate = useNavigate();

  const [isBuyerOrSeller, setIsBuyerOrSeller] = useState<number>(0);

  const [deliveryPayment, setDeliveryPayment] = useState<IPaymentWithGroup>();
  const [transaction, setTransaction] = useState<IAdminFullTransaction>();

  const handleShowBuyerInfo = () => {
    setIsBuyerOrSeller(0);
  };
  const handleShowSellerInfo = () => {
    setIsBuyerOrSeller(1);
  };

  const getTransaction = async (uuid: string) => {
    const res = await fetchTransactionDetailsForDeliveryCompanyAPI(uuid);
    if (res.transaction) {
      setTransaction(res.transaction);
      setDeliveryPayment(res.deliveryPayment);
    }
  };

  useEffect(() => {
    getTransaction(uuid ? uuid : "");
  }, [uuid]);

  const onNavigateToPaymentOfTransaction = (payment: IPaymentWithGroup) => {
    if (payment) {
      navigate("/payment/" + payment.PaymentGroup.id);
    }
  };

  if (transaction) {
    return (
      <div key={uuid} className="transaction-details-page">
        <div className="transaction-section">
          <HeaderPage
            title="Transaction Details"
            descr="All Information about Transaction , Invitation , seller and Buyer"
            isSeach={false}
          />
          <div className="transaction-section-content">
            <div className="transaction card">
              <TitleCard title="Transaction" />
              <div className="card-content">
                <div className="title">Transaction : {transaction.uuid}</div>
                <div className="card-information">
                  <div className="information-title">status</div>
                  <Status status={transaction.state} />
                </div>
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

                {deliveryPayment && (
                  <>
                    <div className="paymentOfTransactionTop"></div>
                    <div className="paymentOfTransaction">
                      <LigneInfoInCard
                        title="payment of seller"
                        value={
                          deliveryPayment.PaymentGroup &&
                          deliveryPayment.PaymentGroup.state ==
                            PaymentGroupStatus.APPROVED
                            ? "Approved"
                            : "Pending"
                        }
                        subDescr={
                          deliveryPayment &&
                          deliveryPayment.PaymentGroup &&
                          deliveryPayment.PaymentGroup.state ===
                            PaymentGroupStatus.APPROVED
                            ? "Detail"
                            : ""
                        }
                        action={() =>
                          onNavigateToPaymentOfTransaction(deliveryPayment)
                        }
                        icon={<GrTransaction />}
                      />
                    </div>
                  </>
                )}


                <div className="Claims-Histories-container">
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
                </div>
              </div>
            </div>
            <div className="product-details card">
              <div className="navigate-to-invitation-icon"></div>
              <TitleCard title="Invitation" />
              <div className="card-content">
                <div className="title">{transaction.Invitation.product}</div>
                <div className="descr">
                  {transaction.Invitation.description}
                </div>
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
                      client={{
                        ...transaction.Buyer,
                        client: Client.BUYER,
                        address: transaction.Buyer.address,
                        businessName: null,
                        email: transaction.Buyer.email,
                        firstName: transaction.Buyer.firstName + " " + transaction.Buyer.name,
                        phoneNumber: transaction.Buyer.phoneNumber,
                        wilaya: transaction.Buyer.wilaya,
                      }}
                    />
                  ) : (
                    <BuyerOrSellerCard
                      client={{
                        ...transaction.Invitation.Seller,
                        client: Client.SELLER,
                        businessName:
                          transaction.Invitation.Seller.businessName,
                        email: transaction.Invitation.Seller.email,
                        firstName: transaction.Invitation.Seller.firstName + " " + transaction.Invitation.Seller.name,
                        address: transaction.Invitation.Seller.location,
                        phoneNumber: transaction.Invitation.Seller.phoneNumber,
                        wilaya: transaction.Invitation.Seller.wilaya,
                      }}
                    />
                  )}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  } else {
    return <Page404 />;
  }
};

export default TransactionDetails;
