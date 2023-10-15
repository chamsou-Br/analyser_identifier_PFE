import React from 'react'
import { FaSearch } from 'react-icons/fa'
import "./headerTable.css"
import { IoMdRefresh } from 'react-icons/io'

type Props = {
    title : string , 
    descr : string , 
    value : string , 
    handleSearch : ()=>void ,
    handleFocusInput : () => void , 
    handleChangeInput  : (e: React.ChangeEvent<HTMLInputElement>) => void,
    handleRefresh : () => void
}

function HeaderTable(props: Props) {
  return (
    <div className="header-page">
    <div className="header-left">
    <div onClick={props.handleRefresh} className="refresh-icon-container">
        <IoMdRefresh />
      </div>
    </div>

    <div className="header-right">
      <div
        onClick={()=>props.handleSearch()}
        className="search-icon-container"
      >
        <FaSearch />
      </div>
      <div className="search-bar-container">
        <input
        value={props.value}
        onFocus={props.handleFocusInput}
        onChange={props.handleChangeInput}
          placeholder="Search uuid"
        />
      </div>
    </div>
  </div>
  )
}

export default HeaderTable