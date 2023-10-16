/* eslint-disable @typescript-eslint/no-unused-vars */


import { ThunkAction } from "redux-thunk"
import { GET_ONGOING_CANCELED, GET_ONGOING_FULFILLED, GET_ONGOIN_WITH_CLAIMS, GET_TRANSACTION } from "../../helper/API"
import axios from "../../helper/axiosConfig"
import { IAdminFullTransaction } from "../../helper/types"
import { RootState } from "../store"
import { Dispatch } from "redux"
import { Authorization } from "../../helper/constant"

export const FETCH_TRANSACTION_DETAILS_SUCCESS = "FETCH_TRANSACTION_DETAILS_SUCCESS"
export const FETCH_TRANSACTION_DETAILS_FAILED  = "FETCH_TRANSACTION_DETAILS_FAILED"
export const ADD_TRANSACTION_DETAILS = "ADD_TRANSACTION_DETAILS"
export const MODIFY_TRANSACTION_DETAILS = "MODIFY_TRANSACTION_DETAILS"
export const DELETE_TRANSACTION_DETAILS = "DELETE_TRANSACTION_DETAILS"
export const START_LOADING_TRANSACTION_DETAILS = 'START_LOADING_TRANSACTION_DETAILS';
export const STOP_LOADING_TRANSACTION_DETAILS = 'STOP_LOADING_TRANSACTION_DETAILS';

export interface IAddTransactionDetailsAction {
    type :typeof ADD_TRANSACTION_DETAILS,
    payload : IAdminFullTransaction
  }

export interface IDeleteTransactionDetailsAction {
    type :typeof DELETE_TRANSACTION_DETAILS,
  }

export interface IModifyTransactionDetailsAction {
    type: typeof MODIFY_TRANSACTION_DETAILS,
    paylaod : IAdminFullTransaction | undefined

}

export interface IFetchTransactionDetailsSucessAction {
    type : typeof FETCH_TRANSACTION_DETAILS_SUCCESS , 
    payload :  IAdminFullTransaction
}

export interface IFetchTransactionDetailsFailedAction {
    type : typeof FETCH_TRANSACTION_DETAILS_FAILED , 
    payload :  string
}

export interface ILoadingTransactionDetailsAction {
    type : typeof START_LOADING_TRANSACTION_DETAILS | typeof STOP_LOADING_TRANSACTION_DETAILS
}

export type TransactionDetailsAction = IAddTransactionDetailsAction | IModifyTransactionDetailsAction | IDeleteTransactionDetailsAction  | IFetchTransactionDetailsFailedAction | IFetchTransactionDetailsSucessAction | ILoadingTransactionDetailsAction

export const AddTransactionDetails =  (transaction : IAdminFullTransaction) : IAddTransactionDetailsAction =>  {
        return {
            type  : ADD_TRANSACTION_DETAILS,
            payload : transaction
        }
}


export const fetchTransactionDetails = (uuid : string) => {
    return async (dispatch: Dispatch<TransactionDetailsAction>, getState: () => RootState) => {
        try {
            const options = {
                method: "POST",
                url: GET_TRANSACTION,
                headers: {
                  "Content-Type": "application/x-www-form-urlencoded",
                  Authorization: Authorization,
                },
                data: { transactionUuid: uuid },
              };   
            const res = await axios.request(options)
            dispatch({
                type : FETCH_TRANSACTION_DETAILS_SUCCESS , payload :  res.data.transactions
            })


        } catch (error) {
            dispatch( {
                type : FETCH_TRANSACTION_DETAILS_FAILED , payload :  "An Errour has occured :)"
            })
        }
    };
}





export const DeleteTransactionDetails =  () : IDeleteTransactionDetailsAction =>  {
    return {
        type  : DELETE_TRANSACTION_DETAILS,
    }
}

export const ModifyTransactionDetails = (transaction : IAdminFullTransaction | undefined) : IModifyTransactionDetailsAction => {
    return {
        type : MODIFY_TRANSACTION_DETAILS , 
        paylaod : transaction
    }
}

export const startLoadingTransactionDetails = () => ({
    type: START_LOADING_TRANSACTION_DETAILS,
  });
  
 export const stopLoadingTransactionDetails = () => ({
    type: STOP_LOADING_TRANSACTION_DETAILS,
  });