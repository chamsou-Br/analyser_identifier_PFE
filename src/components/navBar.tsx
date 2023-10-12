import React from 'react'
import {FaCaretDown } from 'react-icons/fa'
import "../styles/shared.css"


function NavBar() {
  return (
    <div className='navBar'>
            <div className='navBar-left'>
                <div><span>D</span></div>
                <span>Dashboard</span>
            </div>
            <div className='navBar-mid'>
                <div></div>
                <div></div>
                <div></div>
            </div>
            <div className='navBar-right'>
                <span>LogOut</span>
                <div className='logOut-icon'>
                    <FaCaretDown />
                </div>
            </div>
    </div>
  )
}

export default NavBar