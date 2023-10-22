/* eslint-disable @typescript-eslint/no-unused-vars */


import { INVITATIONS } from "../../helper/API"
import axios from "../../helper/axiosConfig"
import {  IInvitationComplete } from "../../helper/types"
import { RootState } from "../store"
import { Dispatch } from "redux"
import { Authorization } from "../../helper/constant"

export const FETCH_INVITATION_SUCCESS = "FETCH_INVITATION"
export const FETCH_INVITATION_FAILED  = "FETCH_INVITATION_FAILED"
export const ADD_INVITATION = "ADD_INVITATION"
export const MODIFY_INVITATION = "MODIFY_INVITATION"
export const DELETE_INVITATION  = "DELETE_INVITATION"
export const START_LOADING_INVITATION  = 'START_LOADING_INVITATION';
export const STOP_LOADING_INVITATION  = 'STOP_LOADING_INVITATION';

export interface IAddInvitationAction {
    type :typeof ADD_INVITATION,
    payload : IInvitationComplete
  }

export interface IDeleteInvitationAction {
    type :typeof DELETE_INVITATION,
    payload : string
  }

export interface IFetchInvitationSucessAction {
    type : typeof FETCH_INVITATION_SUCCESS , 
    payload :  IInvitationComplete[]
}

export interface IFetchInvitationFailedAction {
    type : typeof FETCH_INVITATION_FAILED , 
    payload :  string
}

export interface ILoadingInvitationAction {
    type : typeof START_LOADING_INVITATION | typeof STOP_LOADING_INVITATION
}

export type InvitationAction = IAddInvitationAction | IDeleteInvitationAction  | IFetchInvitationFailedAction | IFetchInvitationSucessAction | ILoadingInvitationAction

export const addInvitation =  (inv : IInvitationComplete) : IAddInvitationAction =>  {
        return {
            type  : ADD_INVITATION,
            payload : inv
        }
}


export const fetchInvitations = () => {
    return async (dispatch: Dispatch<InvitationAction>, getState: () => RootState) => {
        try {
            const options = {
                method: 'GET',
                url: INVITATIONS,
                headers: {
                  Authorization: Authorization()
                }
              };    
            const res = await axios.request(options)
            dispatch({
                type : FETCH_INVITATION_SUCCESS , payload :  res.data.invitations
            })


        } catch (error) {
            dispatch( {
                type : FETCH_INVITATION_FAILED , payload :  "An Errour has occured :)"
            })
        }
    };
}


export const startLoadingTransaction = () => ({
    type: START_LOADING_INVITATION,
  });
  
 export const stopLoadingTransaction = () => ({
    type: STOP_LOADING_INVITATION,
  });