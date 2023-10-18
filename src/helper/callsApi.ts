/* eslint-disable @typescript-eslint/no-unused-vars */
import { AxiosError } from "axios";
import axios from "./axiosConfig";
import { Authorization } from "./constant";
import { IAdminFullTransaction, IAdminTransaction, IHistory, IInvitation, IInvitationComplete, IInvitationTransaction, ISellerBase, ITransactionClosing } from "./types";
import { ADD_NOTE, ADMIN_ACTION, BLOCK_SELLER, BUYER_HISTORY, CLOSE_TRANSACTION, DECIDE_TRANSACTION, GET_CLOSING_INFO, GET_TRANSACTION, INVITAION_DETAILS, REJECT_INVITATION, SELLER_HISTORY, VALIDATE_INVITATION } from "./API";



export const fetchTransactionAPI = async (
  uuid: string
) => {
  try {
    const options = {
      method: "POST",
      url: GET_TRANSACTION,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization() ,
      },
      data: { transactionUuid: uuid },
    };

    

    const response = await axios.request(options);

    return {
      transaction: response.data.transactions as IAdminFullTransaction,
      error: undefined,
    };



  } catch (error: unknown) {
    return {
      transaction: undefined,
      error:
        error instanceof Error ? error.message : "An unknown error occurred",
    };
  }
};

export const addNoteOfTransactionAPI = async (
  uuid: string,
  title: string,
  text: string
)  => {
  try {
    const options = {
      method: "POST",
      url: ADD_NOTE,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data: {
        transactionUuid: uuid,
        title: title,
        text: text,
      },
    };

    const response = await axios.request(options);

    return {
      transaction: response.data.transactions as IAdminFullTransaction,
      error: undefined,
    };

  } catch (error: unknown) {
    return {
      transaction: undefined,
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};


export const changeStateOfTransactionAPI = async (  
    uuid: string,
    decision: string,
    raison: string)    => {
try {
    const options = {
        method: 'POST',
        url: DECIDE_TRANSACTION,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          Authorization : Authorization()
        },
        data: {
          transactionUuid: uuid,
          decision: decision,
          reason: raison
        }
      };
      
    const response = await axios.request(options);

    return {
      transaction: response.data.transaction as IAdminFullTransaction,
      error: undefined,
    };

    } catch (error: unknown) {
        return {
          transaction: undefined,
          error: (error as AxiosError<{ message: string }>).response?.data.message
            ? (error as AxiosError<{ message: string }>).response?.data.message
            : "An unknown error occurred",
        };
      }
}


export const closeTransactionAPI = async (  
    uuid: string,
    )   => {
try {
  
    const options = {
        method: 'POST',
        url: CLOSE_TRANSACTION,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          Authorization: Authorization()
        },
        data: {transactionUuid: uuid}
      };
      
    const response = await axios.request(options);

    return {
      transaction: response.data.transaction as IAdminFullTransaction,
      error: undefined,
    };

    } catch (error: unknown) {
    
        return {
          transaction: undefined,
          error: (error as AxiosError<{ message: string }>).response?.data.message
            ? (error as AxiosError<{ message: string }>).response?.data.message
            : "An unknown error occurred",
        };
      }
}


export const getBuyerHistorieAPI = async (  
  email: string,
  )  => {
try {

  
  const options = {
    method: 'POST',
    url: BUYER_HISTORY,
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      Authorization: Authorization()
    },
    data: {BuyerEmail: email}
  };
    
  const response = await axios.request(options);

  return {
    transactions: response.data.transactions as IAdminFullTransaction[],
    error: undefined,
  };

  } catch (error: unknown) {
  
      return {
        transactions: [],
        error: (error as AxiosError<{ message: string }>).response?.data.message
          ? (error as AxiosError<{ message: string }>).response?.data.message
          : "An unknown error occurred",
      };
    }
}

export const getSellerHistorieAPI = async (  
  email: string,
  )  => {
try {

  
  const options = {
    method: 'POST',
    url: SELLER_HISTORY,
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      Authorization: Authorization()
    },
    data: {sellerEmail: email}
  };
    
  const response = await axios.request(options);

  return {
    historiy : response.data.invitations as IInvitationTransaction[],
    error: undefined,
  };

  } catch (error: unknown) {

      return {
        historiy: [],
        error: (error as AxiosError<{ message: string }>).response?.data.message
          ? (error as AxiosError<{ message: string }>).response?.data.message
          : "An unknown error occurred",
      };
    }
}

export const blockSellerAPI = async (  
  email: string,
  ) => {
try { 

  const options = {
    method: 'POST',
    url: BLOCK_SELLER,
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      Authorization: Authorization()
    },
    data: {sellerEmail: email}
  };
  
    
  const response = await axios.request(options);

  console.log(response)

  return {
    seller : response.data.seller as ISellerBase,
    error: undefined,
  };

  } catch (error: unknown) {
    console.log(error)
      return {
        error: (error as AxiosError<{ message: string }>).response?.data.message
          ? (error as AxiosError<{ message: string }>).response?.data.message
          : "An unknown error occurred",
      };
    }
}


export const getClosingInfoAPI = async (  
  uuid: string,
  ) => {
try { 

  const options = {
    method: 'POST',
    url: GET_CLOSING_INFO,
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      Authorization: Authorization()
    },
    data: {transactionUuid: uuid}
  };
  
    
  const response = await axios.request(options);

  return {
    info : response.data.info as ITransactionClosing ,
    error: null,
  };

  } catch (error: unknown) {
  
      return {
        info : undefined,
        error: (error as AxiosError<{ message: string }>).response?.data.message
          ? (error as AxiosError<{ message: string }>).response?.data.message
          : "An unknown error occurred",
      };
    }
}

export const getAdminActionAPI = async (  
  ) => {
try { 

  const options = {
    method: 'GET',
    url: ADMIN_ACTION,
    headers: {
      Authorization: Authorization()
    }
  };
   
    
  const response = await axios.request(options);

  return {
    history : response.data.history as IHistory[] ,
    error: null,
  };

  } catch (error: unknown) {
  
      return {
        history : [],
        error: (error as AxiosError<{ message: string }>).response?.data.message
          ? (error as AxiosError<{ message: string }>).response?.data.message
          : "An unknown error occurred",
      };
    }
}


export const rejectInvitationAPI = async ( 
  uuid : string 
  ) => {
try { 

  const options = {
    method: 'POST',
    url: REJECT_INVITATION,
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      Authorization: Authorization()
    },
    data: {uuid: uuid}
  };
  
   
    
  const response = await axios.request(options);

  return {
    invitation : response.data.invitation as IInvitation ,
    error: null,
  };

  } catch (error: unknown) {
  
      return {
        invitation : undefined,
        error: (error as AxiosError<{ message: string }>).response?.data.message
          ? (error as AxiosError<{ message: string }>).response?.data.message
          : "An unknown error occurred",
      };
    }
}


export const validateInvitationAPI = async ( 
  uuid : string 
  ) => {
try { 

  const options = {
    method: 'POST',
    url: VALIDATE_INVITATION,
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      Authorization: Authorization()
    },
    data: {uuid: uuid}
  };
    
  const response = await axios.request(options);

  return {
    invitation : response.data.invitation as IInvitation,
    error: null,
  };

  } catch (error: unknown) {
  
      return {
        invitation : undefined,
        error: (error as AxiosError<{ message: string }>).response?.data.message
          ? (error as AxiosError<{ message: string }>).response?.data.message
          : "An unknown error occurred",
      };
    }
}



export const fetchInvitationDetailsAPI = async ( 
  uuid : string 
  ) => {
try { 

  const options = {
    method: 'POST',
    url: INVITAION_DETAILS,
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      Authorization: Authorization()
    },
    data: {InvitationUuid: uuid}
  };
    
  const response = await axios.request(options);

  return {
    invitation : response.data.invitation as IInvitationComplete,
    error: null,
  };

  } catch (error: unknown) {
  
      return {
        invitation : undefined,
        error: (error as AxiosError<{ message: string }>).response?.data.message
          ? (error as AxiosError<{ message: string }>).response?.data.message
          : "An unknown error occurred",
      };
    }
}




