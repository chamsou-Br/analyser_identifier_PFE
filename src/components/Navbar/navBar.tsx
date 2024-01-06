import "./navbar.css";
import { IoMdLogOut } from "react-icons/io";
import { useLocation, useNavigate } from "react-router-dom";
import { useAppDispatch } from "../../state/store";
import { logout } from "../../state/actions/authAction";
import ActionConfirmation from "../ActionConfirmation/ActionConfirmation";
import { useState } from "react";

const NavBar = () => {
  const navigate = useNavigate();
  const history = useLocation();
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

  return (
    <div className="navBar">
      <ActionConfirmation
        submitButton="Logout"
        isOpen={open}
        handleCanceled={handleCancel}
        handleSubmit={handleSubmit}
        confirmationText="Are you sure that you want to LogOut ?"
      />
      <div className="navBar-left">
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
        <div
          style={history.pathname == "/history" ? { color: "#3782ec" } : {}}
          onClick={() => navigate("/history")}
        >
          History
        </div>
        <div
          style={history.pathname == "/invitation" ? { color: "#3782ec" } : {}}
          onClick={() => navigate("/invitation")}
        >
          Invitations
        </div>
        <div
          style={
            history.pathname == "/deliveryCompany" ? { color: "#3782ec" } : {}
          }
          onClick={() => navigate("/deliveryCompany")}
        >
          deliveryCompanies
        </div>
        <div
          style={
            history.pathname == "/sellers" ? { color: "#3782ec" } : {}
          }
          onClick={() => navigate("/sellers")}
        >
          Rib Request
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
