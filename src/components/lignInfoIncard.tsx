import React from 'react'
import "../styles/shared.css"
type Props = {
    title:string,
    value : string,
    icon : React.ReactNode
}

const LigneInfoInCard = (props: Props) => {
  return (
    <div className="card-information-lign">
    <div className="information-title">{props.title}</div>
    <div>
      <div className="icon-container">
        {props.icon}
      </div>
      <span>{props.value} </span>
    </div>
  </div>
  )
}

export default LigneInfoInCard