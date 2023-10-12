/* eslint-disable @typescript-eslint/no-unused-vars */


import { ThunkAction } from "redux-thunk"
import { GET_ONGOIN_WITH_CLAIMS } from "../../helper/API"
import axios from "../../helper/axiosConfig"
import { IAdminFullTransaction } from "../../helper/types"
import { RootState } from "../store"
import { Dispatch } from "redux"

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
                  Authorization: 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoibmFzc2ltIiwiaWQiOjAsImlhdCI6MTY5NTMyOTQ1OCwiaXNzIjoiYXBwbGljYXRpb24ifQ.NuTJS68OAxJTUJ9lbHHG9vzivObneKsZanfuwiJnqj-PVkF4OVJjlqtgWpuF8jAuTcC-2RxP138ydAsaYoR5x0ZdVhbk6jicyTP78m57NkGVGlUtRGzyRVIFJsmI1Q9tuoZu0hbSxVUk3jkfgmEg7SG-H38onP71GfoUfJucQj8HZD27nWKa2Ik_NqwSSFdI16cKoIbta8WcXjVeRBfFuehlxfQbyEkQNOHNrzUaRu5BslM9OfD0upHE777L1ozCAAtas3iUx2j-HhSdL6YrY9pWq6-tnNv1dwXHWVANEiu9YzF1Xqx9I8uPgZSEkE-In12Xk5CEFHyF86991tKbRA'
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