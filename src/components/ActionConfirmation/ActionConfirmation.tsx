import React from "react";
import { Button, Modal } from "rsuite";
import "./ActionConfirmation.css"

type Props = {
  isOpen: boolean;
  handleSubmit: () => void;
  handleCanceled: () => void;
  confirmationText: string;
};

function ActionConfirmation(props: Props) {
  return (
    <Modal
      className="transaction-note"
      open={props.isOpen}
      backdrop="static"
      onClose={props.handleCanceled}
    >
      <Modal.Header closeButton={false}>
        <Modal.Title>{props.confirmationText}</Modal.Title>
      </Modal.Header>
      <Modal.Footer>
        <Button
          className="button"
          onClick={() => props.handleSubmit()}
          appearance="primary"
        >
          Submit
        </Button>
        <Button
          className="button"
          onClick={props.handleCanceled}
          appearance="subtle"
        >
          Cancel
        </Button>
      </Modal.Footer>
    </Modal>
  );
}

export default ActionConfirmation;
