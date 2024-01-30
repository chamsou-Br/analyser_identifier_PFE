import React from "react";
import { GiMatterStates } from "react-icons/gi";
import { HiOutlineLockClosed } from "react-icons/hi";
import { PiNotepad } from "react-icons/pi";
import "./transactionAction.css";

type props = {
  handleAddNoteAction: () => void;
  handleCloseTransactionAction: () => void;
  handleChangeTransactionStatusAction: () => void;
  handleAddPayment : () => void,
  isPaymentCreated? : boolean
};

const TransactionActions = ({
  handleAddNoteAction,
  handleChangeTransactionStatusAction,
  handleCloseTransactionAction,
  handleAddPayment,
  isPaymentCreated
}: props) => {
  return (
    <div className="transaction-actions">
      <div className="action">
        <div onClick={handleAddNoteAction} className="action-icon">
          <PiNotepad className="icon" />
        </div>
        <div className="action-title">Add Note</div>
      </div>
      <div className="action">
        <div onClick={handleCloseTransactionAction} className="action-icon">
          <HiOutlineLockClosed />
        </div>
        <div className="action-title">Close Transaction</div>
      </div>
      <div className="action">
        <div
          onClick={handleChangeTransactionStatusAction}
          className="action-icon"
        >
          <GiMatterStates />
        </div>
        <div className="action-title">change Status</div>
      </div>
      <div className="action">
        <div onClick={()=> isPaymentCreated ? null : handleAddPayment()  } className={isPaymentCreated ? "action-icon disabled" : "action-icon"}>
          <HiOutlineLockClosed />
        </div>
        <div className="action-title">{isPaymentCreated ? "Payment already created" : " Add Payment"}</div>
      </div>
    </div>
  );
};

export default TransactionActions;
