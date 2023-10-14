import "../styles/shared.css";
import { FaExclamation } from "react-icons/fa";
type Props = {
  sender: string;
  raison: string;
  text: string;
  date: string;
  onNavigateToDetails: () => void;
};


function Reclamationcard(props: Props) {
  return (
    <div className="reclamation-card">
      <div className="content">
      <div className="raison">{props.raison}</div>
      <p className="reclamation-card-descr">{props.text}</p>
      </div>

      <div className="reclamation-card-header">
        <div style={{ display: "flex", alignItems: "center" }}>
          <div
            onClick={() => {
              props.onNavigateToDetails();
            }}
            className="details-navigate-icon"
          >
            <FaExclamation />
          </div>
          <span style={{ marginLeft: 10, marginRight: 10 }}> | </span>
          <div className="sender">{props.sender}</div>
        </div>
        <div className="date">{props.date}</div>
      </div>
    </div>
  );
}

export default Reclamationcard;
