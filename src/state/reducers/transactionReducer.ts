import { IAdminFullTransaction } from "../../helper/types";
import { ADD_TRANSACTION, DELETE_TRANSACTION, FETCH_TRANSACTION_FAILED, FETCH_TRANSACTION_SUCCESS, START_LOADING_TRANSACTION, STOP_LOADING_TRANSACTION, TransactionAction } from '../actions/transactionAction';



  
  interface TransactionsState {
    transactions : IAdminFullTransaction[];
    error: string | null,
    loading : boolean
  }
  
  const initialState: TransactionsState = {
    transactions: [],
    error: null,
    loading : false
  };
  


  
  export const transactionsReducer = (state = initialState, action: TransactionAction): TransactionsState => {
    switch (action.type) {
      case START_LOADING_TRANSACTION:
        return {
          ...state,
          loading: true,
        };
  
      case STOP_LOADING_TRANSACTION:
        return {
          ...state,
          loading: false,
        };
      case ADD_TRANSACTION:
        return {
          ...state,
          transactions: [...state.transactions, action.payload],
        };
      case DELETE_TRANSACTION:
        return {
          ...state,
          transactions: state.transactions.filter((transaction) => transaction.uuid !== action.payload),
        };
      case FETCH_TRANSACTION_SUCCESS :
        return{
          ...state,
          loading : false,
          transactions : action.payload
        };
      case FETCH_TRANSACTION_FAILED : 
        return{
          ...state , 
          error : action.payload
        }
      default:
        return state;
    }
  };
  