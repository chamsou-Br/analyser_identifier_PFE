import { getFormatPrice } from "../../helper/constant";
import "./transactionHistory.css";
import { FaExclamation } from "react-icons/fa";
type Props = {
  actionType: string;
  action: string;
  raison: string;
  date: string;
};

function HistorieTransactioncard(props: Props) {
  const closing_accounting =
    props.actionType == "closing & accounting"
      ? {
          commission_money: getFormatPrice(
            JSON.parse(props.raison).commission_money
          ),
          buyer_money: getFormatPrice(
            JSON.parse(props.raison).commission_money
          ),
          seller_money: getFormatPrice(
            JSON.parse(props.raison).commission_money
          ),
          payed_money: getFormatPrice(
            JSON.parse(props.raison).commission_money
          ),
        }
      : null;

  return (
    <div className="historie-card">
      <div className="historie-card-header">
        <div style={{ display: "flex", alignItems: "center" }}>
          <div className="details-navigate-icon">
            <FaExclamation />
          </div>
          <span style={{ marginLeft: 10, marginRight: 10 }}> | </span>
          <div className="action-type">{props.actionType}</div>
        </div>
        <div className="date">{props.date}</div>
      </div>
      <div className="content">
        <div className="action">
          {" "}
          {props.actionType == "decision modify state"
            ? props.action.split("state")[1]
            : props.action}
        </div>
        <div
          onClick={() => {
            console.log(JSON.parse(props.raison));
          }}
          className="historie-card-descr"
        >
          {closing_accounting == null ? (
            props.raison
          ) : (
            <div className="closing_accounting" >
              <span> commission_money : {closing_accounting.commission_money}</span> 
              <span> buyer_money : {closing_accounting.buyer_money}</span> 
              <span> seller_money : {closing_accounting.seller_money}</span> 
              <span> payed_money : {closing_accounting.payed_money}</span>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

export default HistorieTransactioncard;
