import "./reclamtionCard.css";
import { FaExclamation } from "react-icons/fa";
type Props = {
  sender: string;
  raison: string;
  text: string;
  date: string;
  onNavigateToDetails: () => void;
};

const Reclamationcard = ({
  date,
  onNavigateToDetails,
  raison,
  sender,
  text,
}: Props) => {
  return (
    <div className="reclamation-card">
      <div className="content">
        <div className="raison">{raison}</div>
        <p className="reclamation-card-descr">{text}</p>
      </div>

      <div className="reclamation-card-header">
        <div style={{ display: "flex", alignItems: "center" }}>
          <div
            onClick={() => {
              onNavigateToDetails();
            }}
            className="details-navigate-icon"
          >
            <FaExclamation />
          </div>
          <span style={{ marginLeft: 10, marginRight: 10 }}> | </span>
          <div className="sender">{sender}</div>
        </div>
        <div className="date">{date}</div>
      </div>
    </div>
  );
};

export default Reclamationcard;
