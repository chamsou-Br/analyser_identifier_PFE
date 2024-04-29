import { Button, Modal } from "rsuite";
import "./ActionConfirmation.css"

type Props = {
  isOpen: boolean;
  handleSubmit: () => void;
  handleCanceled: () => void;
  confirmationText: string;
  submitButton? : string
};

const ActionConfirmation = ({isOpen , confirmationText , handleCanceled , handleSubmit , submitButton}: Props) =>  {
  return (
    <Modal
      className="transaction-note"
      open={isOpen}
      backdrop="static"
      onClose={handleCanceled}
    >
      <Modal.Header closeButton={false}>
        <Modal.Title>{confirmationText}</Modal.Title>
      </Modal.Header>
      <Modal.Footer>
        <Button
          className="button"
          onClick={() => handleSubmit()}
          appearance="primary"
        >
        {submitButton ? submitButton : "Submit"}
        </Button>
        <Button
          className="button"
          onClick={handleCanceled}
          appearance="subtle"
        >
          Cancel
        </Button>
      </Modal.Footer>
    </Modal>
  );
}

export default ActionConfirmation;
