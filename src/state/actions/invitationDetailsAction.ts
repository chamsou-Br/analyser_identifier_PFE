/* eslint-disable @typescript-eslint/no-unused-vars */


import { ThunkAction } from "redux-thunk"
import { GET_ONGOING_CANCELED, GET_ONGOING_FULFILLED, GET_ONGOIN_WITH_CLAIMS, GET_TRANSACTION, INVITAION_DETAILS } from "../../helper/API"
import axios from "../../helper/axiosConfig"
import { IAdminFullTransaction, IAdminInvitation, IInvitationComplete } from "../../helper/types"
import { RootState } from "../store"
import { Dispatch } from "redux"
import { Authorization } from "../../helper/constant"

export const FETCH_INVITATION_DETAILS_SUCCESS = "FETCH_INVITATION_DETAILS_SUCCESS"
export const FETCH_INVITATION_DETAILS_FAILED  = "FETCH_INVITATION_DETAILS_FAILED"
export const ADD_INVITATION_DETAILS = "ADD_INVITATION_DETAILS"
export const MODIFY_INVITATION_DETAILS = "MODIFY_INVITATION_DETAILS"
export const DELETE_INVITATION_DETAILS = "DELETE_INVITATION_DETAILS"
export const START_LOADING_INVITATION_DETAILS = 'START_LOADING_INVITATION_DETAILS';
export const STOP_LOADING_INVITATION_DETAILS = 'STOP_LOADING_INVITATION_DETAILS';

export interface IAddInvitationDetailsAction {
    type :typeof ADD_INVITATION_DETAILS,
    payload : IAdminInvitation
  }

export interface IDeleteInvitationDetailsAction {
    type :typeof DELETE_INVITATION_DETAILS,
  }

export interface IModifyInvitationDetailsAction {
    type: typeof MODIFY_INVITATION_DETAILS,
    paylaod : IAdminInvitation | undefined

}

export interface IFetchInvitationDetailsSucessAction {
    type : typeof FETCH_INVITATION_DETAILS_SUCCESS , 
    payload :  IAdminInvitation
}

export interface IFetchInvitationDetailsFailedAction {
    type : typeof FETCH_INVITATION_DETAILS_FAILED , 
    payload :  string
}

export interface ILoadingInvitationDetailsAction {
    type : typeof START_LOADING_INVITATION_DETAILS | typeof STOP_LOADING_INVITATION_DETAILS
}

export type InvitationDetailsAction = IAddInvitationDetailsAction | IModifyInvitationDetailsAction | IDeleteInvitationDetailsAction  | IFetchInvitationDetailsSucessAction | IFetchInvitationDetailsFailedAction | ILoadingInvitationDetailsAction

export const AddInvitationDetails =  (inv : IAdminInvitation) : IAddInvitationDetailsAction =>  {
        return {
            type  : ADD_INVITATION_DETAILS,
            payload : inv
        }
}


export const fetchInvitationDetails = (uuid : string) => {
    return async (dispatch: Dispatch<InvitationDetailsAction>, getState: () => RootState) => {
        try {
            const options = {
                method: "POST",
                url: INVITAION_DETAILS,
                headers: {
                  "Content-Type": "application/x-www-form-urlencoded",
                  Authorization: Authorization(),
                },
                data: { uuid: uuid },
              };   
            const res = await axios.request(options)
            dispatch({
                type : FETCH_INVITATION_DETAILS_SUCCESS , payload :  res.data.invitation
            })


        } catch (error) {
            dispatch( {
                type : FETCH_INVITATION_DETAILS_FAILED , payload :  "An Errour has occured :)"
            })
        }
    };
}





export const ModifyInvitationDetails = (inv : IAdminInvitation | undefined) : IModifyInvitationDetailsAction => {
    return {
        type : MODIFY_INVITATION_DETAILS , 
        paylaod : inv
    }
}

export const startLoadingInvitationDetails = () => ({
    type: START_LOADING_INVITATION_DETAILS,
  });
  
 export const stopLoadingInvitationDetails = () => ({
    type: STOP_LOADING_INVITATION_DETAILS,
  });