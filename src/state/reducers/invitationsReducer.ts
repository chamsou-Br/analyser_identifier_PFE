import {  IInvitationComplete } from "../../helper/types";
import { ADD_INVITATION, DELETE_INVITATION, FETCH_INVITATION_FAILED, FETCH_INVITATION_SUCCESS, InvitationAction, START_LOADING_INVITATION, STOP_LOADING_INVITATION } from "../actions/invitationsAction";


  
  interface InvitationState {
    invitations : IInvitationComplete[];
    error: string | null,
    loading : boolean
  }
  
  const initialState: InvitationState = {
    invitations: [],
    error: null,
    loading : false
  };
  


  
  export const invitationReducer = (state = initialState, action: InvitationAction): InvitationState => {
    
    switch (action.type) {
      case START_LOADING_INVITATION:
        return {
          ...state,
          loading: true,
        };
  
      case STOP_LOADING_INVITATION:
        return {
          ...state,
          loading: false,
        };
      case ADD_INVITATION:
        return {
          ...state,
          invitations: [...state.invitations, action.payload],
        };
      case DELETE_INVITATION:
        return {
          ...state,
          invitations: state.invitations.filter((inv) => inv.uuid !== action.payload),
        };
      case FETCH_INVITATION_SUCCESS :
        return{
          ...state,
          loading : false,
          invitations : action.payload
        };
      case FETCH_INVITATION_FAILED : 
        return{
          ...state , 
          error : action.payload
        }
      default:
        return state;
    }
  };
  