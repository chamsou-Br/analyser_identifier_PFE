/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable @typescript-eslint/no-unused-vars */
import React, { useEffect, useState } from "react";
import "../styles/client.css";
import { getBuyerHistorieAPI } from "../helper/callsApi";
import {
  Client,
  DeliveryType,
  IAdminFullTransaction,
  IBuyer,
  IBuyerBase,
  IClientBase,
  IRowsTable,
  ITransacionForTable,
  ITransactionNoSeller,
  TransactionStatus,
} from "../helper/types";
import BuyerOrSellerCard from "../components/buyerOrSellerCard";
import { useSelector } from "react-redux";
import { RootState } from "../state/store";
import { useLocation } from "react-router";
import { Currency } from "../helper/constant";
import TableCompo from "../components/Table";
import TransactionActionConfirmation from "../components/transactionActionConfirmation";
import Alert from "../components/alert";

function ClientScreen() {
  const location = useLocation();

  const [client, setClient] = useState<IClientBase>(location.state);
  const [histories, setHistories] = useState<ITransactionNoSeller[]>([]);
  const [isModalConfirmOfBlockClient, setisModalConfirmOfBlockClient] =
  useState<boolean>(false);

  const rows: IRowsTable[] = [
    { headerCell: "Product", dataKey: "ProductName", size: 150 },
    { headerCell: "Price", dataKey: "ProductPrice", size: 100 },
    { headerCell: "Delivery Type", dataKey: "deliveryType", size: 200 },
    { headerCell: "Delivery Price", dataKey: "deliveryPrice", size: 100 },
    { headerCell: "Delivery Date", dataKey: "deliveryDate", size: 150 },
    { headerCell: "Payment Date", dataKey: "paymentDate", size: 150 },
    { headerCell: "State", dataKey: "state", size: 120 },
  ];
  const getDataFromState = (): ITransacionForTable[] => {
    const newData = histories
      ? histories.map((item: ITransactionNoSeller) => ({
          uuid: item.uuid,
          deliveryDate: item.deliveryDate.toString().split("T")[0], // Convert Date to string
          deliveryPlace: item.deliveryPlace,
          deliveryType: item.deliveryType,
          deliveryPrice: item.deliveryPrice.toString() + Currency,
          ProductName: item.Invitation.product,
          ProductPrice: item.Invitation.price.toString() + Currency,
          paymentDate: item.paymentDate.toString().split("T")[0],
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
      setisModalConfirmOfBlockClient(true)
    }

        const handleCanceledModalOfBlockClient = () => {
          setisModalConfirmOfBlockClient(false)
        }
      
        const handleSubmitBlockClient = () => {
         setisModalConfirmOfBlockClient(false)
          onAlert(true , '',true)

        };
      
    /*  End block Seller Dunction*/


  useEffect(() => {
    fetchData();
  }, []);

  if (client) {
    return (
      <div className="client-page">
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
          {client.client == Client.BUYER ? (
            <div onClick={handleBlockClient} className="block">Block</div>
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
    );
  }
}

export default ClientScreen;
