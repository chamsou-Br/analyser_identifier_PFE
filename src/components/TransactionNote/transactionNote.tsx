import React, { useState } from "react";
import { Button, Input, Modal } from "rsuite";
import ActionConfirmation from "../ActionConfirmation/ActionConfirmation";
import "./transactionNote.css";

type Props = {
  isOpen: boolean;
  handleCloseCanceled: () => void;
  handleCloseSucessed: (title: string, text: string) => void;
};

const TransactionNote = ({
  handleCloseCanceled,
  handleCloseSucessed,
  isOpen,
}: Props) => {
  const [title, setTitle] = useState<string>("");
  const [text, setText] = useState<string>("");
  const [open, setIsOpen] = useState(false);

  const onOpenConfirmationNote = () => {
    setIsOpen(true);
    handleCloseCanceled();
  };
  const handleCancel = () => {
    setIsOpen(false);
  };
  const handleSubmit = () => {
    setIsOpen(false);
    handleCloseCanceled();
    handleCloseSucessed(title, text);
    setTimeout(() => {
      setTitle("");
      setText("");
    }, 2000);
  };

  return (
    <div>
      <ActionConfirmation
        confirmationText="Are you sure that you want to add this note ?"
        isOpen={open}
        handleCanceled={handleCancel}
        handleSubmit={handleSubmit}
      />

      <Modal
        className="transaction-note"
        open={isOpen}
        backdrop="static"
        onClose={handleCloseCanceled}
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
            onClick={handleCloseCanceled}
            appearance="subtle"
          >
            Cancel
          </Button>
        </Modal.Footer>
      </Modal>
    </div>
  );
};

export default TransactionNote;
