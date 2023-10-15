import React, { useState } from "react";
import { Button, Input, Modal } from "rsuite";
import TransactionActionConfirmation from "../TransactionActionConfirmation/transactionActionConfirmation";
import "./transactionStateUpdate.css";

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
    setTimeout(() => {
      setRaison("");
      setState("");
    }, 2000);
  };

  const data = [
    { key: "ghosted", value: ["payed-ghosted"] },
    {
      key: "canceled",
      value: ["payed-buyer-cancel-late", "payed-seller-cancel"],
    },
    {
      key: "reimbursed",
      value: ["payed-reimbursed", "payed-reimbursed-complex"],
    },
    {
      key: "fulfilled",
      value: ["fulfilled-continue","fulfilled-hold", "fulfilled"],
    },
  ];
  //.map((item) => ({ label: item, value: item }));

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
          <select className="custom-select">
            {data.map((grps, i) => (
              <optgroup key={i} label={grps.key}>
                {grps.value.map((option, j) => (
                  <option key={j} value={option}>
                    {option}
                  </option>
                ))}
              </optgroup>
            ))}
          </select>

          {/* <SelectPicker
            placeholder="status"
            style={{ width: 300 }}
            value={state}
            onChange={(v) => setState(v ? v : "")}
            data={data}
          /> */}
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
