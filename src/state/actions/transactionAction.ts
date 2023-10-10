import axios from "axios"
import { Dispatch } from "react"

import { IAdminTransaction } from "../../helper/types"

export const FETCH_TRANSACTION_SUCCESS = "FETCH_TRANSACTION"
export const FETCH_TRANSACTION_FAILED  = "FETCH_TRANSACTION_FAILED"
export const ADD_TRANSACTION = "ADD_TRANSACTION"
export const MODIFY_TRANSACTION = "MODIFY_TRANSACTION"
export const DELETE_TRANSACTION = "DELETE_TRANSACTION"

export interface AddTransactionAction {
    type :typeof ADD_TRANSACTION,
    payload : IAdminTransaction
  }

export interface DeleteTransactionAction {
    type :typeof DELETE_TRANSACTION,
    payload : string
  }


export type TransactionAction = AddTransactionAction | DeleteTransactionAction 


export const fetchTransaction = () => {
    return async ( dispatch : Dispatch<unknown> ) => {
        try {
            const res = await axios.get("/admin/transaction");
            dispatch({type : FETCH_TRANSACTION_SUCCESS , payload :  res.data})
        } catch (error) {
            dispatch({type : FETCH_TRANSACTION_FAILED, payload :  error})
        }
    }
}

export const AddTransaction =  (transaction : IAdminTransaction) : AddTransactionAction =>  {
        return {
            type  : ADD_TRANSACTION,
            payload : transaction
        }
}


export const DeleteTransaction =  (transactionUuid : string) : DeleteTransactionAction =>  {
    return {
        type  : DELETE_TRANSACTION,
        payload : transactionUuid
    }
}