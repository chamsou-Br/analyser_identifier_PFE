import { AxiosError } from "axios";
import axios from "./axiosConfig";
import { Authorization } from "./constant";
import { IAdminFullTransaction } from "./types";
import { ADD_NOTE, CLOSE_TRANSACTION, DECIDE_TRANSACTION, GET_TRANSACTION } from "./API";

type TransactionFetch = {
  transaction: IAdminFullTransaction | undefined;
  error: string | undefined;
};

export const fetchTransactionAPI = async (
  uuid: string
): Promise<TransactionFetch> => {
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
      transaction: response.data.transactions,
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
) : Promise<TransactionFetch> => {
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
      transaction: response.data.transactions,
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
    raison: string)  => {
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
      transaction: response.data.transaction,
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
    )  => {
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
      transaction: response.data.transaction,
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