/* eslint-disable @typescript-eslint/no-unused-vars */
import { Dispatch } from "redux";
import { RootState } from "../store";
import axios from "../../helper/axiosConfig";
import { tokenName } from "../../helper/constant";
import { AxiosError } from "axios";

export const LOGIN = "LOGIN";

export const LOGIN_SUCCESS = "LOGIN_SUCESS";

export const LOGIN_FAILED = "LOGIN_FAILED";

export const LOGOUT = "LOGOUT";

export const START_LOADING_AUTH = "START_LOADING_AUTH";

export const STOP_LOADING_AUTH = "STOP_LOADING_AUTH";

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
  | StopLoadingAction;

export const authentificate = (name: string, privateKey: string) => {
  return async (dispatch: Dispatch<AuthAction>, getState: () => RootState) => {
    dispatch({
      type: START_LOADING_AUTH,
    });

    try {
      const options = {
        method: "PUT",
        url: "http://localhost:7550/api/admin",
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
