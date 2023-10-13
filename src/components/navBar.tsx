import React from "react";
import "../styles/shared.css";
import { IoMdLogOut } from "react-icons/io";
import {NavLink } from "react-router-dom";

function NavBar() {

  return (
    <div className="navBar">
      
        <NavLink to="/" className="navBar-left">
          <div>
            <span>D</span>
          </div>
          <span>Dashboard</span>
        </NavLink>
    
      <div className="navBar-mid">
        <div></div>
        <div></div>
        <div></div>
      </div>
      <div className="navBar-right">
        <span>LogOut</span>
        <div className="logOut-icon">
          <IoMdLogOut />
        </div>
      </div>
    </div>
  );
}

export default NavBar;
