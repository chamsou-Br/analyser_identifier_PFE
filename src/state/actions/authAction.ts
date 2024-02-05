/* eslint-disable @typescript-eslint/no-unused-vars */
import { Dispatch } from "redux";
import { RootState } from "../store";
import axios from "../../helper/axiosConfig";
import { tokenName } from "../../helper/constant";
import { AxiosError } from "axios";
import { ADMIN_PROFILE, AUTH_ADMIN } from "../../helper/API";
import { IAdmin } from "../../helper/types";

export const LOGIN = "LOGIN";

export const LOGIN_SUCCESS = "LOGIN_SUCESS";

export const LOGIN_FAILED = "LOGIN_FAILED";

export const LOGOUT = "LOGOUT";

export const START_LOADING_AUTH = "START_LOADING_AUTH";

export const STOP_LOADING_AUTH = "STOP_LOADING_AUTH";

export const GET_ADMIN = "GET_ADMIN"

export interface getAdminAction {
  type: typeof GET_ADMIN;
  payload: IAdmin;
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
  | getAdminAction
  | StopLoadingAction;

export const authentificate = (name: string, privateKey: string) => {
  return async (dispatch: Dispatch<AuthAction>, getState: () => RootState) => {
    dispatch({
      type: START_LOADING_AUTH,
    });

    try {
      const options = {
        method: "PUT",
        url: AUTH_ADMIN,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        data: {
          name: name,
          privateKey: privateKey,
        },
      };

        const res = await axios.request(options);

        localStorage.setItem(tokenName, res.data.adminToken);
  
        dispatch({
          type: LOGIN_SUCCESS,
          payload: res.data.adminToken,
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


export const getAdminProfile = ( token: string) => {
  return async (dispatch: Dispatch<AuthAction>) => {
    try {
     const options = {
       method: 'GET',
       url: ADMIN_PROFILE,
       headers: {
         'Content-Type': 'application/x-www-form-urlencoded',
         Authorization: token,
       },      
     };
      const response = await axios.request(options);
      dispatch({
        type: GET_ADMIN,
        payload: response.data.admin as IAdmin,
      });
    } catch (error: unknown) { 
      dispatch({
        type: LOGOUT,
      });
    }
  }
}

export const addAdmin = (admin : IAdmin): AuthAction => {
  return {
    type: GET_ADMIN,
    payload : admin
  };
};

