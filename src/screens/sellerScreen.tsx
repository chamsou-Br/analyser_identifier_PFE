/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable @typescript-eslint/no-unused-vars */
import React, { useEffect, useState } from "react";
import "../styles/seller.css";
import { blockSellerAPI, getSellerHistorieAPI } from "../helper/callsApi";
import {
  EntityStatus,
  IClientBase,
  IInvitationTransaction,
} from "../helper/types";
import BuyerOrSellerCard from "../components/Client/buyerOrSellerCard";
import { useLocation, useNavigate } from "react-router";

import HeaderPage from "../components/headerPage/headerPage";
import ClientHistoryCard from "../components/clientHistoryCard/clientHistoryCard";
import Alert from "../components/Alert/alert";
import TransactionActionConfirmation from "../components/ActionConfirmation/ActionConfirmation";
import { RootState, useAppDispatch } from "../state/store";
import { useSelector } from "react-redux";
import { ModifyTransactionDetails } from "../state/actions/transactionDetailsAction";
import Page404 from "../components/404/page404";
import { ModifyInvitationDetails } from "../state/actions/invitationDetailsAction";

const SellerScreen: React.FC = () => {
  const location = useLocation();
  const dispatch = useAppDispatch();
  const navigate = useNavigate();
  const invitation = useSelector(
    (state: RootState) => state.invitation
  ).invitation;
  const transaction = useSelector(
    (state: RootState) => state.transaction
  ).transaction;

  const [client, setClient] = useState<IClientBase>(location.state);
  const [histories, setHistories] = useState<IInvitationTransaction[]>([]);
  const [isModalConfirmOfBlockClient, setisModalConfirmOfBlockClient] =
    useState<boolean>(false);

  const handleNavigateToInvitationDetails = () => {
    navigate("/invitation/" + transaction?.Invitation.uuid);
  };

  const fetchData = async () => {
    if (client.email == transaction?.Invitation.Seller.email) {
      setClient({ ...client, status: transaction.Invitation.Seller.status });
    } else if (client.email == invitation?.Seller.email) {
      setClient({ ...client, status: invitation.Seller.status });
    }
    
    const res = await getSellerHistorieAPI(client ? client.email : "");



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

  const handleSubmitBlockClient = async () => {
    setisModalConfirmOfBlockClient(false);
    const res = await blockSellerAPI(client.email);
    if (!res.seller) {
      onAlert(false, res.error ? res.error : "An Error has occured !", true);
    } else {
      onAlert(true, "", true);
      setClient({ ...client, status: EntityStatus.Rejected });
      if (transaction && transaction.Invitation.Seller.email == client.email) {
        dispatch(
          ModifyTransactionDetails({
            ...transaction,
            Invitation: {
              ...transaction.Invitation,
              Seller: res.seller,
            },
          })
        );
      }
      if (invitation && invitation.Seller.email == client.email) {
        dispatch(
          ModifyInvitationDetails({
            ...invitation,
            Seller: res.seller,
          })
        );
      }
    }
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
              <ClientHistoryCard
                key={i}
                history={his}
                onNavigate={handleNavigateToInvitationDetails}
              />
            ))}
          </div>
          <div className="seller-info">
            <div className="header">Seller Information</div>
            <BuyerOrSellerCard client={client} />
            {client.status != EntityStatus.Rejected ? (
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
  } else return <Page404 />;
};

export default SellerScreen;
