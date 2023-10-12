/* eslint-disable @typescript-eslint/no-unused-vars */
import React, { useState } from "react";
import login from "../assets/login.png";
import { useSelector } from 'react-redux';
import {  RootState, useAppDispatch } from "../state/store";
import { FetchTodo, addTodo } from "../state/actions/todoAction";
import "../styles/login.css"

const LoginScreen: React.FC = () => {

  const data = useSelector(( state : RootState) => state.todos)
  const dispatch = useAppDispatch()

  const [userName, setuserName] = useState<string>("");
  const [password, setPassword] = useState<string>("");



  const HandlerInputuserNameChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setuserName(e.target.value);
  };

  const HandlerInputPasswordChange = (
    e: React.ChangeEvent<HTMLInputElement>
  ) => {
    setPassword(e.target.value);
  };

  const HandlerLogin = () => {
    console.log(password,userName)
    dispatch(addTodo(userName , password));
  }

  return (
    <div className="login">
      <div className="login-container">
        <div className="login-form">
          <div onClick={()=>console.log(data)} className="title">Login</div>
          <div onClick={()=> dispatch(FetchTodo())} className="desc">Welcom ! Please Enter your details</div>
          <label>userName</label>
          <input
            placeholder="Enter your userName"
            type="userName"
            value={userName}
            onChange={HandlerInputuserNameChange}
          />
          <label>Password</label>
          <input
            placeholder="Enter your Password"
            type="password"
            value={password}
            onChange={HandlerInputPasswordChange}
          />
          <div onClick={HandlerLogin} className="submit">Login</div>
        </div>
        <div className="login-picture" >
          <img src={login} />
        </div>
      </div>
    </div>
  );
};

export default LoginScreen;
