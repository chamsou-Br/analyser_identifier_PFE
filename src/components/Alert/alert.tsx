import { FaCheck, FaWindowClose } from "react-icons/fa";
import { Modal } from "rsuite";
import "./alert.css";

type Props = {
  alert: {
    isSucess: boolean;
    message: string;
    show: boolean;
  };
  onAlert: (show: boolean, message: string, isSucess: boolean) => void;
};

const Alert = ({ alert, onAlert }: Props) => {
  const onCancel = () => {
    onAlert(alert.isSucess, alert.message, false);
  };
  return (
    <Modal
      className="transaction-note"
      open={alert.show}
      backdrop={true}
      onClose={onCancel}
    >
      <Modal.Title></Modal.Title>
      <Modal.Body className="Alert">
        {alert.isSucess ? (
          <div className="icon-container-sucess">
            <FaCheck />
          </div>
        ) : (
          <div className="icon-container-failed">
            <FaWindowClose />
          </div>
        )}
        <div
          className="message"
          style={alert.isSucess ? { color: "#44E46A" } : { color: "#f17777" }}
        >
          {alert.isSucess
            ? "Your treatment is done successfully"
            : alert.message}
        </div>
      </Modal.Body>
    </Modal>
  );
};

export default Alert;
