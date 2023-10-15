/* eslint-disable @typescript-eslint/no-unused-vars */
import { AxiosError } from "axios";
import axios from "./axiosConfig";
import { Authorization } from "./constant";
import { IAdminFullTransaction, IAdminTransaction, IInvitationTransaction } from "./types";
import { ADD_NOTE, BLOCK_SELLER, BUYER_HISTORY, CLOSE_TRANSACTION, DECIDE_TRANSACTION, GET_TRANSACTION, SELLER_HISTORY } from "./API";

type TransactionFetch = {
  transaction: IAdminFullTransaction | undefined;
  error: string | undefined;
};

type TransactionsFetch = {
  transactions: IAdminFullTransaction[];
  error: string | undefined;
};

type SellerHistory = {
  historiy : IInvitationTransaction[] , 
  error : string | undefined
}

export const fetchTransactionAPI = async (
  uuid: string
) => {
  try {
    const options = {
      method: "POST",
      url: GET_TRANSACTION,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization,
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
        Authorization: Authorization,
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
          Authorization : Authorization
        },
        data: {
          transactionUuid: uuid,
          decision: decision,
          reason: raison
        }
      };
      
    const response = await axios.request(options);

    return {
      transaction: response.data.transaction as IAdminTransaction,
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
          Authorization: Authorization
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
      Authorization: Authorization
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
      Authorization: Authorization
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
  id: string,
  ) => {
try { 

  const options = {
    method: 'POST',
    url: BLOCK_SELLER,
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      Authorization: Authorization
    },
    data: {sellerId: id}
  };
  
    
  const response = await axios.request(options);

  return {
    error: undefined,
  };

  } catch (error: unknown) {
  
      return {
        error: (error as AxiosError<{ message: string }>).response?.data.message
          ? (error as AxiosError<{ message: string }>).response?.data.message
          : "An unknown error occurred",
      };
    }
}