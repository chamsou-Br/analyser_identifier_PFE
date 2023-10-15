import { FaCheck, FaWindowClose } from "react-icons/fa";
import { Modal } from "rsuite";
import "./alert.css"

type Props = {
  alert: {
    isSucess: boolean;
    message: string;
    show: boolean;
  };
  onAlert: (show: boolean, message: string, isSucess: boolean) => void;
};

function Alert(props: Props) {

    const onCancel = () => {
        props.onAlert(props.alert.isSucess , props.alert.message , false)
    }
  return (
    <Modal
      className="transaction-note"
      open={props.alert.show}
      backdrop={true}
      onClose={onCancel}
    >
      <Modal.Title></Modal.Title>
      <Modal.Body className="Alert">
        {props.alert.isSucess ? (
          <div className="icon-container-sucess">
            <FaCheck />
          </div>
        ) : (
          <div className="icon-container-failed">
            <FaWindowClose />
          </div>
        )}
        <div className="message" style={props.alert.isSucess ? { color: "#44E46A"} : { color: "#f17777"}}>
          {props.alert.isSucess
            ? "Your treatment is done successfully"
            : props.alert.message}
        </div>
      </Modal.Body>
    </Modal>
  );
}

export default Alert;
