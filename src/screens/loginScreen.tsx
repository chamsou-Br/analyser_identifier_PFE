/* eslint-disable @typescript-eslint/no-unused-vars */
import React, { useState } from "react";
import login from "../assets/login.png";
import { useSelector } from 'react-redux';
import {  RootState, useAppDispatch } from "../state/store";
import { FetchTodo, addTodo } from "../state/actions/todoAction";


const LoginScreen: React.FC = () => {

  const data = useSelector(( state : RootState) => state.todos)
  const dispatch = useAppDispatch()

  const [email, setEmail] = useState<string>("");
  const [password, setPassword] = useState<string>("");



  const HandlerInputEmailChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setEmail(e.target.value);
  };

  const HandlerInputPasswordChange = (
    e: React.ChangeEvent<HTMLInputElement>
  ) => {
    setPassword(e.target.value);
  };

  const HandlerLogin = () => {
    console.log(password,email)
    dispatch(addTodo(email , password));
  }

  return (
    <div className="login">
      <div className="login-container">
        <div className="login-form">
          <div onClick={()=>console.log(data)} className="title">Login</div>
          <div onClick={()=> dispatch(FetchTodo())} className="desc">Welcom ! Please Enter your details</div>
          <label>Email</label>
          <input
            placeholder="Enter your Email"
            type="email"
            value={email}
            onChange={HandlerInputEmailChange}
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
