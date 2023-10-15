import React from 'react'
import { FaCheck } from 'react-icons/fa'

type Props = {
    title :string
}

function TitleCard(props: Props) {
  return (
    <div className="title-card">
    <div>
      <div className="title-icon-container">
        <FaCheck />
      </div>
      <span>{props.title}</span>
    </div>
  </div>
  )
}

export default TitleCard