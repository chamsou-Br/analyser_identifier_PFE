import {  IInvitationComplete } from "../../helper/types";
import { ADD_INVITATION_DETAILS, DELETE_INVITATION_DETAILS, FETCH_INVITATION_DETAILS_FAILED, FETCH_INVITATION_DETAILS_SUCCESS, InvitationDetailsAction, MODIFY_INVITATION_DETAILS, START_LOADING_INVITATION_DETAILS, STOP_LOADING_INVITATION_DETAILS } from "../actions/invitationDetailsAction";



  
  interface InvitationState {
    invitation : IInvitationComplete | undefined;
    error: string | null,
    loading : boolean
  }
  
  const initialState: InvitationState = {
    invitation: undefined,
    error: null,
    loading : false
  };
  


  
  export const InvitationDetailsReducer = (state = initialState, action: InvitationDetailsAction): InvitationState => {
    switch (action.type) {
      case START_LOADING_INVITATION_DETAILS:
        return {
          ...state,
          loading: true,
        };
  
      case STOP_LOADING_INVITATION_DETAILS:
        return {
          ...state,
          loading: false,
        };
      case ADD_INVITATION_DETAILS:
        return {
          loading : false,
          error:null,
          invitation: action.payload,
        };
      case MODIFY_INVITATION_DETAILS :
        return{       
          loading : false,
          error:null, 
          invitation : action.paylaod ? {...state.invitation,...action.paylaod}: state.invitation
        }
      case DELETE_INVITATION_DETAILS:
        return {
          loading : false,
          error:null,
          invitation: undefined,
        };
      case FETCH_INVITATION_DETAILS_SUCCESS :
        return{
          error : null ,
          loading : false,
          invitation : action.payload
        };
      case FETCH_INVITATION_DETAILS_FAILED : 
        return{
          ...state , 
          invitation : undefined,
          error : action.payload
        }
      default:
        return state;
    }
  };
  