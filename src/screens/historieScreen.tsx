import React, { useEffect, useState } from "react";
import "../styles/historie.css";
import { getAdminActionAPI } from "../helper/callsApi";
import { IHistory } from "../helper/types";
import HeaderPage from "../components/headerPage/headerPage";
import HistorieTransactioncard from "../components/transactionHistory/TransactionHistory";
import { getFullFormatDate } from "../helper/constant";
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
          title={"History"}
          descr="Information about all action of admin!"
        />
        <div className="jdskbkzejfb"></div>
        <div className="historie-admin-content">
          {history.map((hist, index) => (
            <div key={index} className="historie-admin-card">
              <HistorieTransactioncard
                num={index + 1}
                action={hist.action}
                actionType={hist.actionType}
                date={getFullFormatDate(hist.createdAt.toString())}
                raison={hist.reason}
              />
            </div>
          ))}
          {history.length == 0 && (
            <div className="no-action-yet">
              No action existe yet !
            </div>
          )}
        </div>
      </div>
    );
  } else {
    return <Page404 />;
  }
};

export default HistorieScreen;
