/* eslint-disable @typescript-eslint/no-unused-vars */


import { ThunkAction } from "redux-thunk"
import { GET_ONGOIN_WITH_CLAIMS } from "../../helper/API"
import axios from "../../helper/axiosConfig"
import { IAdminFullTransaction } from "../../helper/types"
import { RootState } from "../store"
import { Dispatch } from "redux"
import { Authorization } from "../../helper/constant"

export const FETCH_TRANSACTION_SUCCESS = "FETCH_TRANSACTION"
export const FETCH_TRANSACTION_FAILED  = "FETCH_TRANSACTION_FAILED"
export const ADD_TRANSACTION = "ADD_TRANSACTION"
export const MODIFY_TRANSACTION = "MODIFY_TRANSACTION"
export const DELETE_TRANSACTION = "DELETE_TRANSACTION"
export const START_LOADING_TRANSACTION = 'START_LOADING_TRANSACTION';
export const STOP_LOADING_TRANSACTION = 'STOP_LOADING_TRANSACTION';

export interface IAddTransactionAction {
    type :typeof ADD_TRANSACTION,
    payload : IAdminFullTransaction
  }

export interface IDeleteTransactionAction {
    type :typeof DELETE_TRANSACTION,
    payload : string
  }

export interface IFetchTransactionsSucessAction {
    type : typeof FETCH_TRANSACTION_SUCCESS , 
    payload :  IAdminFullTransaction[]
}

export interface IFetchTransactionsFailedAction {
    type : typeof FETCH_TRANSACTION_FAILED , 
    payload :  string
}

export interface ILoadingTransactionAction {
    type : typeof START_LOADING_TRANSACTION | typeof STOP_LOADING_TRANSACTION
}

export type TransactionAction = IAddTransactionAction | IDeleteTransactionAction  | IFetchTransactionsFailedAction | IFetchTransactionsSucessAction | ILoadingTransactionAction

export const AddTransaction =  (transaction : IAdminFullTransaction) : IAddTransactionAction =>  {
        return {
            type  : ADD_TRANSACTION,
            payload : transaction
        }
}


export const fetchTransaction = () => {
    return async (dispatch: Dispatch<TransactionAction>, getState: () => RootState) => {
        try {
            const options = {
                method: 'GET',
                url: GET_ONGOIN_WITH_CLAIMS,
                headers: {
                  Authorization: Authorization
                }
              };    
            const res = await axios.request(options)
            dispatch({
                type : FETCH_TRANSACTION_SUCCESS , payload :  res.data.transactions
            })


        } catch (error) {
            dispatch( {
                type : FETCH_TRANSACTION_FAILED , payload :  "An Errour has occured :)"
            })
        }
    };
}

export const DeleteTransaction =  (transactionUuid : string) : IDeleteTransactionAction =>  {
    return {
        type  : DELETE_TRANSACTION,
        payload : transactionUuid
    }
}


export const startLoadingTransaction = () => ({
    type: START_LOADING_TRANSACTION,
  });
  
 export const stopLoadingTransaction = () => ({
    type: STOP_LOADING_TRANSACTION,
  });