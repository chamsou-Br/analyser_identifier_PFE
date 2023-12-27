/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable @typescript-eslint/no-unused-vars */
import React, { useEffect, useState } from "react";
import "../styles/buyer.css";
import { getBuyerHistorieAPI } from "../helper/callsApi";
import {
  Client,
  IClientBase,
  IRowsTable,
  ITransacionForTable,
  ITransactionNoSeller,
} from "../helper/types";
import BuyerOrSellerCard from "../components/Client/buyerOrSellerCard";
import { useLocation } from "react-router";
import {
  Currency,
  getDeliveryTypeTitle,
  getFormatDate,
} from "../helper/constant";
import TableCompo from "../components/Table/Table";
import TransactionActionConfirmation from "../components/ActionConfirmation/ActionConfirmation";
import Alert from "../components/Alert/alert";
import HeaderPage from "../components/headerPage/headerPage";

const  BuyerScreen : React.FC  = ()  => {
  const location = useLocation();

  const [client, setclient] = useState<IClientBase>(location.state);
  const [histories, setHistories] = useState<ITransactionNoSeller[]>([]);
  const [isModalConfirmOfBlockClient, setisModalConfirmOfBlockClient] =
    useState<boolean>(false);

  const rows: IRowsTable[] = [
    { headerCell: "Product", dataKey: "ProductName", size: 150 },
    { headerCell: "Price", dataKey: "ProductPrice", size: 100 },
    { headerCell: "Delivery Type", dataKey: "deliveryType", size: 150 },
    { headerCell: "Delivery Price", dataKey: "deliveryPrice", size: 100 },
    { headerCell: "Delivery Date", dataKey: "deliveryDate", size: 150 },
    { headerCell: "Payment Date", dataKey: "paymentDate", size: 150 },
    { headerCell: "State", dataKey: "state", size: 120 },
  ];
  const getDataFromState = (): ITransacionForTable[] => {
    const newData = histories
      ? histories.map((item: ITransactionNoSeller) => ({
          uuid: item.uuid,
          deliveryDate: getFormatDate(
            item.deliveryDate
          ), // Convert Date to string
          deliveryPlace: item.deliveryPlace,
          deliveryType: getDeliveryTypeTitle(item.deliveryType),
          deliveryPrice: item.deliveryPrice.toString() + Currency,
          ProductName: item.Invitation.product,
          ProductPrice: item.Invitation.price.toString() + Currency,
          paymentDate: getFormatDate(item.paymentDate),
          state: item.state,
        }))
      : [];
    return newData;
  };

  const fetchData = async () => {
    const res = await getBuyerHistorieAPI(client.email);

    setHistories(res.transactions);
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
      <div className="client-page">
        <HeaderPage
          title={client.firstName}
          descr="Information and History of the Buyer !"
        />
        <div className="client-page-content">
          <div className="client-historie">
            <TableCompo
              rows={rows}
              getDefaultData={getDataFromState}
              onRefreshData={fetchData}
            />
          </div>
          <div className="client-information">
            <div className="client-information-header">
              {client.client == Client.BUYER
                ? "Buyer Information"
                : "Seller Information"}
            </div>
            <BuyerOrSellerCard client={client} />
            {client.client == Client.SELLER ? (
              <div onClick={handleBlockClient} className="block">
                Block
              </div>
            ) : null}
          </div>
          <TransactionActionConfirmation
            isOpen={isModalConfirmOfBlockClient}
            handleCanceled={handleCanceledModalOfBlockClient}
            handleSubmit={handleSubmitBlockClient}
            confirmationText="Are you sure that you want to block this client ?"
          />
          <Alert alert={alert} onAlert={onAlert} />
        </div>
      </div>
    );
  }
}

export default BuyerScreen;
