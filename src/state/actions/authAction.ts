/* eslint-disable @typescript-eslint/no-unused-vars */
import { Dispatch } from "redux";
import { RootState } from "../store";
import axios from "../../helper/axiosConfig";
import { tokenName } from "../../helper/constant";
import { AxiosError } from "axios";
import { DELIVERY_PROFILE, AUTH_DELIVERY } from "../../helper/API";
import {  IDeliveryOffice } from "../../helper/types";

export const LOGIN = "LOGIN";

export const LOGIN_SUCCESS = "LOGIN_SUCESS";

export const LOGIN_FAILED = "LOGIN_FAILED";

export const LOGOUT = "LOGOUT";

export const START_LOADING_AUTH = "START_LOADING_AUTH";

export const STOP_LOADING_AUTH = "STOP_LOADING_AUTH";

export const GET_DELIVERY = "GET_DELIVERY"

export interface getDeliveryAction {
  type: typeof GET_DELIVERY;
  payload: IDeliveryOffice;
}

export interface LoginSuncessAction {
  type: typeof LOGIN_SUCCESS;
  payload: string;
}

export interface LoginfailedAction {
  type: typeof LOGIN_FAILED;
  payload: string | undefined;
}

export interface LogoutAction {
  type: typeof LOGOUT;
}

export interface StartLoadingAction {
  type: typeof START_LOADING_AUTH;
}

export interface StopLoadingAction {
  type: typeof STOP_LOADING_AUTH;
}

export type AuthAction =
  | LoginSuncessAction
  | LoginfailedAction
  | LogoutAction
  | StartLoadingAction
  | getDeliveryAction
  | StopLoadingAction;

export const authentificate = (name: string, password: string) => {
  return async (dispatch: Dispatch<AuthAction>, _getState: () => RootState) => {
    dispatch({
      type: START_LOADING_AUTH,
    });

    try {
      const options = {
        method: "POST",
        url: AUTH_DELIVERY,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        data: {
          userName: name,
          password : password,
        },
      };

        const res = await axios.request(options);

        localStorage.setItem(tokenName, res.data.token);
  
        dispatch({
          type: LOGIN_SUCCESS,
          payload: res.data.token,
        });

        dispatch({
          type: STOP_LOADING_AUTH,
        });


    } catch (error) {
      dispatch({
        type: STOP_LOADING_AUTH,
      });
      dispatch({
        type: LOGIN_FAILED,
        payload: (error as AxiosError<{ message: string }>).response?.data
          .message
          ? (error as AxiosError<{ message: string }>).response?.data.message
          : "An unknown error occurred",
      });
    }
  };
};

export const logout = (): AuthAction => {
  localStorage.setItem(tokenName, "");
  return {
    type: LOGOUT,
  };
};


export const getDeliveryProfile = ( token: string) => {
  return async (dispatch: Dispatch<AuthAction>) => {
    try {
     const options = {
       method: 'GET',
       url: DELIVERY_PROFILE,
       headers: {
         'Content-Type': 'application/x-www-form-urlencoded',
         Authorization: token,
       },      
     };
      const response = await axios.request(options);
      dispatch({
        type: GET_DELIVERY,
        payload: response.data.company as IDeliveryOffice,
      });
    } catch (error: unknown) { 
      dispatch({
        type: LOGOUT,
      });
    }
  }
}

export const addDelivery = (deliveryOffice : IDeliveryOffice): AuthAction => {
  return {
    type: GET_DELIVERY,
    payload : deliveryOffice
  };
};

