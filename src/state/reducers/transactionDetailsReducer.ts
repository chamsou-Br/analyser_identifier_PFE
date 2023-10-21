import { IAdminFullTransaction } from "../../helper/types";
import { ADD_TRANSACTION_DETAILS, DELETE_TRANSACTION_DETAILS, FETCH_TRANSACTION_DETAILS_FAILED, FETCH_TRANSACTION_DETAILS_SUCCESS, MODIFY_TRANSACTION_DETAILS, START_LOADING_TRANSACTION_DETAILS, STOP_LOADING_TRANSACTION_DETAILS, TransactionDetailsAction } from "../actions/transactionDetailsAction";



  
  interface TransactionState {
    transaction : IAdminFullTransaction | undefined;
    error: string | null,
    loading : boolean
  }
  
  const initialState: TransactionState = {
    transaction: undefined,
    error: null,
    loading : false
  };
  


  
  export const transactionDetailsReducer = (state = initialState, action: TransactionDetailsAction): TransactionState => {
    switch (action.type) {
      case START_LOADING_TRANSACTION_DETAILS:
        return {
          ...state,
          loading: true,
        };
  
      case STOP_LOADING_TRANSACTION_DETAILS:
        return {
          ...state,
          loading: false,
        };
      case ADD_TRANSACTION_DETAILS:
        return {
          loading : false,
          error:null,
          transaction: action.payload,
        };
      case MODIFY_TRANSACTION_DETAILS :
        return{       
          loading : false,
          error:null, 
          transaction : action.paylaod ? {...state.transaction,...action.paylaod}: state.transaction
        }
      case DELETE_TRANSACTION_DETAILS:
        return {
          loading : false,
          error:null,
          transaction: undefined,
        };
      case FETCH_TRANSACTION_DETAILS_SUCCESS :
        return{
          error : null ,
          loading : false,
          transaction : action.payload
        };
      case FETCH_TRANSACTION_DETAILS_FAILED : 
        return{
          ...state , 
          transaction : undefined,
          error : action.payload
        }
      default:
        return state;
    }
  };
  