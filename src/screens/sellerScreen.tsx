/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable @typescript-eslint/no-unused-vars */
import React, { useEffect, useState } from "react";
import "../styles/seller.css";
import { getBuyerHistorieAPI, getSellerHistorieAPI } from "../helper/callsApi";
import {
  Client,
  IClientBase,
  IInvitationTransaction,
  IRowsTable,
  ITransacionForTable,
  ITransactionNoSeller,
} from "../helper/types";
import BuyerOrSellerCard from "../components/buyerOrSellerCard";
import { useLocation } from "react-router";
import {
  Currency,
  getDeliveryTypeTitle,
  getFormatDate,
} from "../helper/constant";
import HeaderPage from "../components/headerPage";
import ClientHistoryCard from "../components/clientHistoryCard";
import Alert from "../components/Alert/alert";
import TransactionActionConfirmation from "../components/transactionActionConfirmation";

function SellerScreen() {
  const location = useLocation();

  const [client, setclient] = useState<IClientBase>(location.state);
  const [histories, setHistories] = useState<IInvitationTransaction[]>([]);
  const [isModalConfirmOfBlockClient, setisModalConfirmOfBlockClient] =
    useState<boolean>(false);

  const fetchData = async () => {
    const res = await getSellerHistorieAPI(client.email);
    console.log(res);
    setHistories(res.historiy);
  };

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

  /* Start block Seller Dunction*/

  const handleBlockClient = () => {
    setisModalConfirmOfBlockClient(true);
  };

  const handleCanceledModalOfBlockClient = () => {
    setisModalConfirmOfBlockClient(false);
  };

  const handleSubmitBlockClient = () => {
    setisModalConfirmOfBlockClient(false);
    onAlert(true, "", true);
  };

  /*  End block Seller Dunction*/

  useEffect(() => {
    fetchData();
  }, []);

  if (client) {
    return (
      <div className="seller-page">
        <HeaderPage
          title={client.firstName}
          descr="Information and Historie of the  Seller !"
        />
        <div className="content">
          <div className="seller-historie">
            {histories.map((his, i) => (
              <ClientHistoryCard key={i} history={his} />
            ))}
          </div>
          <div className="seller-info">
            <div className="header">Seller Information</div>
            <BuyerOrSellerCard client={client} />
            {client.client == Client.SELLER ? (
              <div onClick={handleBlockClient} className="block">
                Block
              </div>
            ) : null}
          </div>
        </div>
        <TransactionActionConfirmation
          isOpen={isModalConfirmOfBlockClient}
          handleCanceled={handleCanceledModalOfBlockClient}
          handleSubmit={handleSubmitBlockClient}
          confirmationText="Are you sure that you want to block this client ?"
        />
        <Alert alert={alert} onAlert={onAlert} />
      </div>
    );
  }
}

export default SellerScreen;
