/* eslint-disable @typescript-eslint/no-unused-vars */
import "./navbar.css";
import { IoMdLogOut } from "react-icons/io";
import { useLocation, useNavigate } from "react-router-dom";
import { RootState, useAppDispatch } from "../../state/store";
import { logout } from "../../state/actions/authAction";
import ActionConfirmation from "../ActionConfirmation/ActionConfirmation";
import { useState } from "react";
import { useSelector } from "react-redux";
import { FaHome, FaRecycle, FaUser } from "react-icons/fa";

const NavBar = () => {
  const navigate = useNavigate();
  const dispatch = useAppDispatch();
  const [open, setIsOpen] = useState(false);

  const handleLogOut = () => {
    setIsOpen(true);
  };

  const handleCancel = () => {
    setIsOpen(false);
  };
  const handleSubmit = () => {
    dispatch(logout());
    navigate("/auth");
  };

  const auth = useSelector((state : RootState) => state.auth)
  return (
    <div className="navBar">
      <ActionConfirmation
        submitButton="Logout"
        isOpen={open}
        handleCanceled={handleCancel}
        handleSubmit={handleSubmit}
        confirmationText="Are you sure that you want to LogOut ?"
      />
      <div onClick={()=> navigate("/")} className="navBar-left">
        <div className="home">
          <FaHome />
        </div>
        <span>Home</span>
      </div>

      <div className="navBar-mid">
          <div className="info">
            <div className="label"><FaUser /></div>
            <div className="value">
              <span>{auth.deliveryOffice?.email}</span>
              <span>{auth.deliveryOffice?.phoneNumber}</span>
            </div>
          </div>
          <div className="info">
            <div className="label"><FaRecycle /></div>
            <div className="value">
              <span>{auth.deliveryOffice?.returnStrategy}</span>
              <span>{auth.deliveryOffice?.rib}</span>
            </div>
          </div>
      </div>
      <div onClick={handleLogOut} className="navBar-right">
        <span>LogOut</span>
        <div className="logOut-icon">
          <IoMdLogOut />
        </div>
      </div>
    </div>
  );
};

export default NavBar;
