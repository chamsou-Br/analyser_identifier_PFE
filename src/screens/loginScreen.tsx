/* eslint-disable @typescript-eslint/no-unused-vars */
import React, { useState, useEffect } from "react";
import login from "../assets/login.png";
import { useSelector } from "react-redux";
import { RootState, useAppDispatch } from "../state/store";
import "../styles/login.css";
import { authentificate } from "../state/actions/authAction";
import { useNavigate } from "react-router";
import { Loader } from "rsuite";

const LoginScreen: React.FC = () => {
  
  const authState = useSelector((state: RootState) => state.auth);
  const dispatch = useAppDispatch();
  const navigate = useNavigate();

  const [userName, setuserName] = useState<string>("");
  const [password, setPassword] = useState<string>("");

  const HandlerInputuserNameChange = (
    e: React.ChangeEvent<HTMLInputElement>
  ) => {
    setuserName(e.target.value);
  };

  const HandlerInputPasswordChange = (
    e: React.ChangeEvent<HTMLInputElement>
  ) => {
    setPassword(e.target.value);
  };

  const HandlerLogin = () => {
      dispatch(authentificate(userName, password));
      setuserName("");
      setPassword("");
  };

  useEffect(() => {
    if (authState.isAuth == true) {
      navigate("/" );
    }
  }, [authState, navigate]);

  if (authState.isAuth == false)
  return (
    <div className="login">
      <div className="login-container">
        <div className="login-form">
          <div className="title">
            Login
          </div>
          <div  className="desc">
            Welcome ! Please Enter your details
          </div>
          <label>userName</label>
          <input
            placeholder="Enter your userName"
            type="userName"
            value={userName}
            onChange={HandlerInputuserNameChange}
          />
          <label>Password</label>
          <input
            placeholder="Enter your password"
            type="password"
            value={password}
            onChange={HandlerInputPasswordChange}
          />

          <div  onClick={HandlerLogin} className={ "submit"}>
          {authState.loading ? (<Loader speed="slow"/>) : "Login"}  
          </div>
          <div className="error">{authState.error}</div>
        </div>
        <div className="login-picture">
          <img src={login} />
        </div>
      </div>
    </div>
  );
};

export default LoginScreen;
