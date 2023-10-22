import React from 'react'
import "./lignInfoCard.css"
type Props = {
    title:string,
    value : string,
    icon : React.ReactNode,
    subDescr? : string
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
     {props.subDescr ? <div className='sub-descr' >5 hour ago</div> : null }
    </div>
  </div>
  )
}

export default LigneInfoInCard