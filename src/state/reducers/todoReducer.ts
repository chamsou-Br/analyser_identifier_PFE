
import { ADD_TODO, FETCH_TODO, TodoAction } from "../actions/todoAction";
  
  interface TodosState {
    todo : {title : string , authour : string }[],
    error : string | null
  }
  
  const initialState: TodosState = {
    todo: [{
        title : "chamso" , authour : "chamsou berkane"
    }],
    error: null,
  };
  


  
  export const todosReducer = (state = initialState, action: TodoAction): TodosState => {
    switch (action.type) {
      case ADD_TODO:
        return {
          ...state,
          todo: [...state.todo, action.payload],
        };
     case FETCH_TODO : 
        return {
            todo : [...action.payload],
            error: null
        }

      default:
        return state;
    }
  };
  