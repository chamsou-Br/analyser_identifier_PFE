/* eslint-disable @typescript-eslint/no-unused-vars */
import React, { useState, useEffect } from "react";
import "../styles/transactionDetails.css";
import {
  FaDollarSign,
  FaMapMarked,
  FaSearchLocation,
  FaTruck,
  FaMapMarkedAlt,
  FaTimes,
} from "react-icons/fa";

import { IoMdCalendar, IoMdTime } from "react-icons/io";
import LigneInfoInCard from "../components/lignInfoIncard";
import TitleCard from "../components/titleCard";
import BuyerOrSellerCard from "../components/buyerOrSellerCard";
import Reclamationcard from "../components/reclamationcard";
import { IAdminFullTransaction } from "../helper/types";
import { useSelector } from "react-redux";
import { RootState, useAppDispatch } from "../state/store";
import Status from "../components/status";
import { getDeliveryTypeTitle, getFormatDate } from "../helper/constant";
import { useParams , useNavigate } from "react-router-dom";
import axios from "../helper/axiosConfig";
import { fetchTransaction } from "../state/actions/transactionAction";

const TransactionDetails: React.FC = () => {
  const { uuid } = useParams();

  const styleIsBuyerOrSellerIsClaimsOrHistories = {
    borderBottom: "3px solid #568deb",
    color: "#568deb",
  };

  const navigate = useNavigate()
  const dispatch = useAppDispatch();
  const [isBuyerOrSeller, setIsBuyerOrSeller] = useState(0);
  const [isClaimsOrHistories, setIsClaimsOrHistorie] = useState(0);
  const TransactionState = useSelector(
    (state: RootState) => state.transactions
  );
  const [transaction,setTransaction] = useState<IAdminFullTransaction>(    TransactionState.transactions.filter(
    (it) => it.uuid.toLocaleLowerCase() === uuid?.toLocaleLowerCase()
  )[0])


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

  useEffect(()=>{
    if (!transaction) {
      const options = {
        method: 'POST',
        url: '/admin/transaction',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          Authorization: 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoibmFzc2ltIiwiaWQiOjAsImlhdCI6MTY5NTMyOTQ1OCwiaXNzIjoiYXBwbGljYXRpb24ifQ.NuTJS68OAxJTUJ9lbHHG9vzivObneKsZanfuwiJnqj-PVkF4OVJjlqtgWpuF8jAuTcC-2RxP138ydAsaYoR5x0ZdVhbk6jicyTP78m57NkGVGlUtRGzyRVIFJsmI1Q9tuoZu0hbSxVUk3jkfgmEg7SG-H38onP71GfoUfJucQj8HZD27nWKa2Ik_NqwSSFdI16cKoIbta8WcXjVeRBfFuehlxfQbyEkQNOHNrzUaRu5BslM9OfD0upHE777L1ozCAAtas3iUx2j-HhSdL6YrY9pWq6-tnNv1dwXHWVANEiu9YzF1Xqx9I8uPgZSEkE-In12Xk5CEFHyF86991tKbRA'
        },
        data: {transactionUuid: 'MB-23-10-10-ZZP'}
      };
      
      axios.request(options).then(function (response) {
        setTransaction(response.data.transactions)
      }).catch(function () {
        navigate("/")
      });
    }
  },[])


  if (transaction) {
    return (
      <div className="transaction-details-page">
        <div className="transaction-section">
          <div className="transaction card">
            <TitleCard title="Transaction" />
            <div className="card-content">
              <div className="title">Transaction N {transaction.uuid}</div>
              <div className="card-information">
                <div className="information-title">Oucom</div>
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
                value="Cheraga, 20- Saefda"
                icon={<FaMapMarkedAlt />}
              />
              <LigneInfoInCard
                title="Price"
                value="300 DA"
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
                    className="buyer"
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
                    className="seller"
                  >
                    Histories
                  </div>
                </div>
                {isClaimsOrHistories === 0
                  ? transaction.Claims.map((claim) => (
                      <Reclamationcard
                        key={claim.id} // Don't forget to add a unique key when mapping components
                        onNavigateToDetails={() => {}}
                        sender={claim.sender}
                        text={claim.text}
                        raison={claim.reason}
                        date={getFormatDate(claim.createdAt.toString().split("T")[0])}
                      />
                      
                    ))
                  : null}
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
                value={getFormatDate(transaction.Invitation.date.toString().split("T")[0])}
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
                value={getDeliveryTypeTitle(transaction.Invitation.deliveryType)}
                icon={<FaTruck />}
                />
                <LigneInfoInCard
                title="Delivery Time"
                value={transaction.Invitation.deliveryDelayHours.toString() + " H"}
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
                    className="buyer"
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
                    className="seller"
                  >
                    Seller Info
                  </div>
                </div>
                {isBuyerOrSeller == 0 ? (
                  <BuyerOrSellerCard
                    onNavigateToDetails={() => {}}
                    status={transaction.Buyer.status}
                    userName={transaction.Buyer.firstName}
                    wilaya={transaction.Buyer.wilaya}
                    address={transaction.Buyer.address}
                    phone={transaction.Buyer.phoneNumber}
                    email={transaction.Buyer.email}
                    sexe={transaction.Buyer.gender}
                    businessName=""
                  />
                ) : (
                  <BuyerOrSellerCard
                    onNavigateToDetails={() => {}}
                    status={transaction.Invitation.Seller.status}
                    userName={transaction.Invitation.Seller.firstName}
                    wilaya={transaction.Invitation.Seller.wilaya}
                    phone={transaction.Invitation.Seller.phoneNumber}
                    email={transaction.Invitation.Seller.email}
                    address={transaction.Invitation.Seller.location}
                    sexe=""
                    businessName={transaction.Invitation.Seller.businessName}
                  />
                )}
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  } 
  
};

export default TransactionDetails;
