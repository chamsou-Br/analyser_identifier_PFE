import React, { useState } from "react";
import { Button, Input, Modal } from "rsuite";
import TransactionActionConfirmation from "./transactionActionConfirmation";

type Props = {
  isOpen: boolean;
  handleCloseCanceled: () => void;
  handleCloseSucessed: (title: string, text: string) => void;
};

function TransactionNote(props: Props) {
  const [title, setTitle] = useState<string>("");
  const [text, setText] = useState<string>("");
  const [open, setIsOpen] = useState(false);

  const onOpenConfirmationNote = () => {
    setIsOpen(true);
    props.handleCloseCanceled();
  };
  const handleCancel = () => {
    setIsOpen(false);
  };
  const handleSubmit = () => {
    setIsOpen(false);
    props.handleCloseCanceled();
    props.handleCloseSucessed(title, text);
    setTimeout(()=>{
      setTitle("");
      setText("")
    },2000)

  };

  return (
    <div>
      <TransactionActionConfirmation
        confirmationText="Are you sure that you want to add this note ?"
        isOpen={open}
        handleCanceled={handleCancel}
        handleSubmit={handleSubmit}
      />

      <Modal
        className="transaction-note"
        open={props.isOpen}
        backdrop="static"
        onClose={props.handleCloseCanceled}
      >
        <Modal.Body className="content">
          <div className="label">Title : </div>
          <Input
            value={title}
            onChange={(v: string) => setTitle(v)}
            placeholder="Title of Note"
          />
          <div className="label">Text : </div>
          <Input
            value={text}
            onChange={(v: string) => setText(v)}
            as="textarea"
            rows={3}
            placeholder="Description of Note"
          />
        </Modal.Body>
        <Modal.Footer>
          <Button
            className="button"
            onClick={onOpenConfirmationNote}
            appearance="primary"
          >
            Submit
          </Button>
          <Button
            className="button"
            onClick={props.handleCloseCanceled}
            appearance="subtle"
          >
            Cancel
          </Button>
        </Modal.Footer>
      </Modal>
    </div>
  );
}

export default TransactionNote;
