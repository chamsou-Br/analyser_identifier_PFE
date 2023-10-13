import React from 'react'
import { GiMatterStates } from 'react-icons/gi'
import { HiOutlineLockClosed } from 'react-icons/hi'
import { PiNotepad } from 'react-icons/pi'
import "../styles/shared.css"

type props = {
  handleAddNoteAction : () => void ,
  handleCloseTransactionAction : () => void , 
  handleChangeTransactionStatusAction : () => void
}

function TransactionActions(props: props) {
  return (
    <div className="transaction-actions">
    <div className="action">
      <div onClick={props.handleAddNoteAction} className="action-icon">
        <PiNotepad className="icon" />
      </div>
      <div className="action-title">Add Note</div>
    </div>
    <div className="action">
      <div onClick={props.handleCloseTransactionAction} className="action-icon">
        <HiOutlineLockClosed />
      </div>
      <div className="action-title">Close Transaction</div>
    </div>
    <div className="action">
      <div onClick={props.handleChangeTransactionStatusAction} className="action-icon">
        <GiMatterStates />
      </div>
      <div className="action-title">change Status</div>
    </div>
  </div>
  )
}

export default TransactionActions