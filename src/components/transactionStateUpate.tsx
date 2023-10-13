import React, { useState } from "react";
import { Button, Input, Modal, SelectPicker } from "rsuite";
import TransactionActionConfirmation from "./transactionActionConfirmation";

type Props = {
  isOpen: boolean;
  handleCloseCanceled: () => void;
  handleCloseSucessed: (state: string, raison: string) => void;
};

function TransactionStatusUpdate(props: Props) {

  const [state, setState] = useState<string>("");
  const [raison, setRaison] = useState<string>("");
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
    props.handleCloseSucessed(state, raison);
    setTimeout(()=>{
      setRaison("");
      setState("")
    },2000)
  };

  const data = [
    "opened",
    "accepted",
    "payed",
    "fulfilled",
    "fulfilled-hold",
    "fulfilled-continue",
    "canceled",
    "payed-buyer-cancel-early",
    "payed-buyer-cancel-mid",
    "payed-buyer-cancel-late",
    "payed-ghosted",
    "Albert",
    "payed-seller-cancel",
    "payed-reimbursed",
    "payed-reimbursed-complex",
  ].map((item) => ({ label: item, value: item }));

  return (
    <div>
      <TransactionActionConfirmation
        isOpen={open}
        handleCanceled={handleCancel}
        handleSubmit={handleSubmit}
        confirmationText="Are you sure that you want to Update the status ?"
      />
      <Modal
        className="transaction-note"
        open={props.isOpen}
        backdrop="static"
        onClose={props.handleCloseCanceled}
      >
        <Modal.Body className="content">
          <div className="label">Status : </div>
          <SelectPicker
          placeholder='status'
          style={{width: 300}}
            value={state}
            onChange={(v) => setState(v ? v : "")}
            data={data}
          />
          <div className="label">Raiosn : </div>
          <Input
            value={raison}
            onChange={(v: string) => setRaison(v)}
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

export default TransactionStatusUpdate;
