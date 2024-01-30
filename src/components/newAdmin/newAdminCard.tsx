import React from 'react'
import "./newAdmin.css"
type Props = {
    name : string,
    onDeleteAdmin : () => void
}

const NewAdminCard = ({name , onDeleteAdmin}: Props) => {
  return (
    <div className="new-admin-card">
    <div className="new-admin-card-content">
      <div className="company-name">{name}</div>
      <div onClick={onDeleteAdmin} className="delete-admin">
        delete
      </div>
    </div>
  </div>
  )
}

export default NewAdminCard