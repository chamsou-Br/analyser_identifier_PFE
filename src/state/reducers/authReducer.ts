
import { IAdmin } from "../../helper/types";
import { AuthAction, GET_ADMIN, LOGIN_FAILED, LOGIN_SUCCESS, LOGOUT, START_LOADING_AUTH, STOP_LOADING_AUTH } from "../actions/authAction";
  
  interface authState {
    isAuth : boolean,
    error? : string | undefined ,
    token : string | null,
    loading? : boolean,
    admin? : IAdmin | null
  }
  
  const initialState: authState = {
    isAuth: false,
    token: "",
    error : undefined,
    loading : false,
    admin : null
  };
  



  
  export const authReducer = (state = initialState, action: AuthAction): authState => {
    switch (action.type) {

      case START_LOADING_AUTH : 
      return {
        ...state  , 
        loading : true
      };
      case STOP_LOADING_AUTH : 
      return {
        ...state, 
        loading : false
      }
      case LOGIN_SUCCESS:
        return {
          isAuth : true , 
          token : action.payload,
          error : undefined
        };
     case LOGIN_FAILED : 
        return {
            isAuth : false,
            token : "",
            error : action.payload
        };
      case LOGOUT: 
        return {
            isAuth : false , 
            token : "",
            error : undefined
      }
      case GET_ADMIN:
        return {...state  , admin : action.payload}
      default:
        return state;
    }
  };
  