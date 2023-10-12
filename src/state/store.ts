// store.ts

import {  combineReducers, applyMiddleware, Dispatch, AnyAction, compose } from 'redux';
import thunk, { ThunkDispatch } from 'redux-thunk'; 
import { transactionsReducer } from './reducers/transactionReducer';
// import { todosReducer } from './reducers/todoReducer';
import {useDispatch} from "react-redux"
import logger  from "redux-logger"
import { legacy_createStore} from 'redux'
// Define RootState
export type RootState = ReturnType<typeof rootReducer>;

//export type AppDispatch = typeof store.dispatch
export type AppDispatch = Dispatch<AnyAction> & ThunkDispatch<RootState, null, AnyAction> 
export const useAppDispatch = () => useDispatch<AppDispatch>() 

// Combine Reducers
const rootReducer = combineReducers({
  transactions: transactionsReducer, 
});

const composeEnhancer =  compose;

const initState = {
  transactions : {
    transactions :[],
    error: null,
    loading : false
  }
}


// Create Redux Store
const store = legacy_createStore(rootReducer, initState ,composeEnhancer(applyMiddleware(thunk,logger)));

export default store;