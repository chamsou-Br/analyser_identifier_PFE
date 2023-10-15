import React from "react";
import "./navbar.css";
import { IoMdLogOut } from "react-icons/io";
import { NavLink, useLocation, useNavigate } from "react-router-dom";

function NavBar() {
  const navigate = useNavigate();
  const history = useLocation();

  return (
    <div className="navBar">
      <div
        onClick={() => console.log(history.pathname)}
        className="navBar-left"
      >
        <div>
          <span>D</span>
        </div>
        <span>Dashboard</span>
      </div>

      <div className="navBar-mid">
        <div
          style={history.pathname == "/" ? { color: "#3782ec" } : {}}
          onClick={() => navigate("/")}
        >
          Claims Transaction
        </div>
        <div
          style={history.pathname == "/fulfilled" ? { color: "#3782ec" } : {}}
          onClick={() => navigate("/fulfilled")}
        >
          Fulfilled Transactions
        </div>
        <div
          style={history.pathname == "/canceled" ? { color: "#3782ec" } : {}}
          onClick={() => navigate("/canceled")}
        >
          Canceled Transaction
        </div>
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
