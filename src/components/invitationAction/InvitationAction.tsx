import { HiOutlineLockClosed } from "react-icons/hi";
import "./invitationAction.css";
import { FaCheck } from "react-icons/fa";

type props = {
  handleValidateInvitation: () => void;
  handleRejectInvitation: () => void;
};

const InvitationActions = ({
  handleRejectInvitation,
  handleValidateInvitation,
}: props) => {
  return (
    <div className="transaction-actions">
      <div className="action">
        <div onClick={handleValidateInvitation} className="action-icon">
          <FaCheck />
        </div>
        <div className="action-title">Validate Invitation</div>
      </div>
      <div className="action">
        <div onClick={handleRejectInvitation} className="action-icon">
          <HiOutlineLockClosed />
        </div>
        <div className="action-title">Reject Invitation</div>
      </div>
    </div>
  );
};

export default InvitationActions;
