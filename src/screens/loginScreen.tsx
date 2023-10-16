/* eslint-disable @typescript-eslint/no-unused-vars */
import React, { useState, useEffect } from "react";
import login from "../assets/login.png";
import { useSelector } from "react-redux";
import { RootState, useAppDispatch } from "../state/store";
import { FetchTodo, addTodo } from "../state/actions/todoAction";
import "../styles/login.css";
import { authentificate } from "../state/actions/authAction";
import { useNavigate } from "react-router";

const LoginScreen: React.FC = () => {
  const data = useSelector((state: RootState) => state.auth);
  const dispatch = useAppDispatch();
  const navigate = useNavigate();

  const [userName, setuserName] = useState<string>("");
  const [privateKey, setPrivateKey] = useState<string>("");

  const HandlerInputuserNameChange = (
    e: React.ChangeEvent<HTMLInputElement>
  ) => {
    setuserName(e.target.value);
  };

  const HandlerInputPasswordChange = (
    e: React.ChangeEvent<HTMLTextAreaElement>
  ) => {
    setPrivateKey(e.target.value);
  };

  const HandlerLogin = () => {
    dispatch(authentificate(userName, privateKey));
    setuserName("");
    setPrivateKey("");
  };

  useEffect(() => {
    if (data.isAuth == true) {
      navigate("/" );
    }
  }, [data, navigate]);

  if (data.isAuth == false)
  return (
    <div className="login">
      <div className="login-container">
        <div className="login-form">
          <div onClick={() => console.log(data)} className="title">
            Login
          </div>
          <div onClick={() => dispatch(FetchTodo())} className="desc">
            Welcom ! Please Enter your details
          </div>
          <label>userName</label>
          <input
            placeholder="Enter your userName"
            type="userName"
            value={userName}
            onChange={HandlerInputuserNameChange}
          />
          <label>Key</label>
          <textarea
            placeholder="Enter your Key"
            value={privateKey}
            onChange={HandlerInputPasswordChange}
          />
          <div onClick={HandlerLogin} className="submit">
            Login
          </div>
          <div className="error">{data.error}</div>
        </div>
        <div className="login-picture">
          <img src={login} />
        </div>
      </div>
    </div>
  );
};

export default LoginScreen;
