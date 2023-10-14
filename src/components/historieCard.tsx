import "../styles/shared.css";
import { FaExclamation } from "react-icons/fa";
type Props = {
  actionType: string;
  action: string;
  raison: string;
  date: string;
};

function Historiecard(props: Props) {
  return (
    <div className="historie-card">
        <div className="historie-card-header">
        <div style={{ display: "flex", alignItems: "center" }}>
          <div
            className="details-navigate-icon"
          >
            <FaExclamation />
          </div>
          <span style={{ marginLeft: 10, marginRight: 10 }}> | </span>
          <div className="action-type">{props.actionType}</div>
        </div>
        <div className="date">{props.date}</div>
      </div>
      <div className="content">
      <div className="action">  { props.actionType == "decision modify state" ? props.action.split("state")[1] :  props.action}</div>
      <div className="historie-card-descr">{props.raison}</div>
      </div>


    </div>
  );
}

export default Historiecard;
