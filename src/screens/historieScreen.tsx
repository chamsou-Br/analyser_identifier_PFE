import React, { useEffect, useState } from "react";
import "../styles/historie.css";
import { getAdminActionAPI } from "../helper/callsApi";
import { IHistory } from "../helper/types";
import HeaderPage from "../components/headerPage/headerPage";
import HistorieTransactioncard from "../components/transactionHistory/TransactionHistory";
import {  getFullFormatDate } from "../helper/constant";
import Page404 from "../components/404/page404";

const HistorieScreen: React.FC = () => {
  const [history, setHistory] = useState<IHistory[]>([]);
  const [error, setError] = useState(false);

  const fetchHistory = async () => {
    const res = await getAdminActionAPI();
    if (!res.error) {
      setHistory(res.history);
    } else {
      setError(true);
    }
  };

  useEffect(() => {
    fetchHistory();
  }, []);


  if (!error) {
    return (
      <div className="historie-admin-page">
        <HeaderPage
          title={"Histories"}
          descr="Information about all action of admin!"
        />
        <div className="jdskbkzejfb"></div>
        <div className="historie-admin-content">
          {history.map((hist, index) => (
            <div className="historie-admin-card">
              <HistorieTransactioncard
                key={index}
                action={hist.action}
                actionType={hist.actionType}
                date={getFullFormatDate(hist.createdAt.toString())}
                raison={hist.reason}
              />
            </div>
          ))}
        </div>
      </div>
    );
  } else {
    return <Page404 />;
  }
};

export default HistorieScreen;