export const ADD_TODO = "ADD_TODO"
export const FETCH_TODO = "FETCH_TODO"

export interface AddTodoAction {
    type : typeof ADD_TODO ,
    payload : {
        title : string,
        authour : string
    }
}

export interface FetchTodoAction {
    type : typeof FETCH_TODO,
    payload : {
        title : string,
        authour : string
    }[]
}

export type  TodoAction = AddTodoAction | FetchTodoAction;

export const addTodo = (title: string,authour:string): TodoAction => {
    return{
        type: ADD_TODO,
        payload: {
            title: title,
            authour : authour,
        }
    }
}


export const FetchTodo  = () : TodoAction => 
      {
        const data  = [{title : "dfklq",authour : "klvn"},{title : "fjpzeiof" , authour : "kdfnlef"}]
        return{
            type: FETCH_TODO,
            payload : data
        }
    }
 



  
