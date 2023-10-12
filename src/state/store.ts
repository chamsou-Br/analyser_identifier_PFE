// store.ts

import { createStore, combineReducers, applyMiddleware, Dispatch, AnyAction } from 'redux';
import thunk, { ThunkDispatch } from 'redux-thunk'; 
import { transactionsReducer } from './reducers/transactionReducer';
import { todosReducer } from './reducers/todoReducer';
import {useDispatch} from "react-redux"
// Define RootState
export type RootState = ReturnType<typeof rootReducer>;

//export type AppDispatch = typeof store.dispatch
export type AppDispatch = Dispatch<AnyAction> & ThunkDispatch<RootState, null, AnyAction> 
export const useAppDispatch = () => useDispatch<AppDispatch>() 

// Combine Reducers
const rootReducer = combineReducers({
  transactions: transactionsReducer,
  todos : todosReducer 
});


// Create Redux Store
const store = createStore(rootReducer, applyMiddleware(thunk));

export default store;