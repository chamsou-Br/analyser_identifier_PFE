import { IAdminTransaction } from "../../helper/types";
import { ADD_TRANSACTION, DELETE_TRANSACTION, TransactionAction } from '../actions/transactionAction';



  
  interface TransactionsState {
    transactions : IAdminTransaction[];
    error: string | null;
  }
  
  const initialState: TransactionsState = {
    transactions: [],
    error: null,
  };
  


  
  export const transactionsReducer = (state = initialState, action: TransactionAction): TransactionsState => {
    switch (action.type) {
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
      default:
        return state;
    }
  };
  