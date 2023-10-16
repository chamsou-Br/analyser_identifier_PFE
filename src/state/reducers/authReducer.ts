
import { AuthAction, LOGIN_FAILED, LOGIN_SUCCESS, LOGOUT } from "../actions/authAction";
  
  interface authState {
    isAuth : boolean,
    error? : string | undefined ,
    token : string | null
  }
  
  const initialState: authState = {
    isAuth: false,
    token: "",
    error : undefined
  };
  



  
  export const authReducer = (state = initialState, action: AuthAction): authState => {
    switch (action.type) {
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
      default:
        return state;
    }
  };
  