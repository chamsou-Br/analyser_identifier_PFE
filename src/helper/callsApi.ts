/* eslint-disable @typescript-eslint/no-unused-vars */
import { AxiosError } from "axios";
import axios from "./axiosConfig";
import { Authorization } from "./constant";
import {
  IAdminFullTransaction,
  IDeliveryOffice,
  IFullPaymentGroup,
  IPaymentWithGroup,
} from "./types";
import {
  DELIVERY_COMPANY_DETAILS,
  EXPORT_TRANSACTIONS_OF_DELIVERY_COMPANY,
  GET_TRANSACTION_FOR_DELIVERY_COMPANY,
  PAYMENT_GROUP,
  PAYMENT_GROUP_APPROVED_DELIVERY_COMPANY,
  PAYMENT_GROUP_PENDING_DELIVERY_COMPANY,
  TRANSACTIONS_OF_DELIVERY_COMPANY,

} from "./API";


export const getPaymentGroupAPI = async (id: number) => {
  try {
    const options = {
      method: "POST",
      url: PAYMENT_GROUP,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data: {
        groupId: id,
      },
    };

    const response = await axios.request(options);

    return {
      group: response.data.group as IFullPaymentGroup,
      error: null,
    };
  } catch (error: unknown) {
    console.log("e", error);
    return {
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};



export const fetchTransactionsOfCompany = async (
  _id: string,
  page: number,
  pageSize: number,
  createAfter?: Date | null,
  createBefore?: Date | null,
  hadPaymentOfDelivery?: boolean | null
) => {
  try {
    const baseUrl = TRANSACTIONS_OF_DELIVERY_COMPANY;
    const queryParams = [];

    if (createAfter !== null && createAfter !== undefined) {
      queryParams.push(`createAfter=${createAfter}`);
    }

    if (createBefore !== null && createBefore !== undefined) {
      queryParams.push(`createBefore=${createBefore}`);
    }
    if (hadPaymentOfDelivery !== null && hadPaymentOfDelivery !== undefined) {
      queryParams.push(`hadPaymentOfDelivery=${hadPaymentOfDelivery}`);
    }

    const queryString =
      queryParams.length > 0 ? `&${queryParams.join("&")}` : "";

    const options = {
      method: "GET",
      url: `${baseUrl}?page=${page}&pageSize=${pageSize}${queryString}`,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      }
    };

    const response = await axios.request(options);

    return {
      transactions: response.data.transactions as IAdminFullTransaction[],
      page: response.data.page as number,
      total: response.data.total as number,
      error: null,
    };
  } catch (error: unknown) {
    return {
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};



export const exportTransactionsOfCompanyAPI = async (
  _id: string,
  createAfter?: Date | null,
  createBefore?: Date | null,
  hadPaymentOfDelivery?: boolean | null
) => {
  try {
    const baseUrl = EXPORT_TRANSACTIONS_OF_DELIVERY_COMPANY;
    const queryParams = [];

    if (createAfter !== null && createAfter !== undefined) {
      queryParams.push(`createAfter=${createAfter}`);
    }

    if (createBefore !== null && createBefore !== undefined) {
      queryParams.push(`createBefore=${createBefore}`);
    }
    if (hadPaymentOfDelivery !== null && hadPaymentOfDelivery !== undefined) {
      queryParams.push(`hadPaymentOfDelivery=${hadPaymentOfDelivery}`);
    }

    const queryString =
      queryParams.length > 0 ? `${queryParams.join("&")}` : "";

    const options = {
      method: "GET",
      url: `${baseUrl}?${queryString}`,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      }
    };

    const response = await axios.request(options);

    return {
      transactions: response.data.transactions as IAdminFullTransaction[],
      error: null,
    };
  } catch (error: unknown) {
    return {
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};

export const getDeliveryCompanyDetailsAPI = async (id: string) => {
  try {
    const options = {
      method: "GET",
      url: DELIVERY_COMPANY_DETAILS,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data: {
        companyId: id,
      },
    };

    const response = await axios.request(options);
    return {
      company: response.data.company as IDeliveryOffice,
      error: null,
    };
  } catch (error: unknown) {
    return {
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};

export const fetchPaymentGroupsPendingOfDeliveryCompanyAPI = async (

) => {
  try {
    const options = {
      method: "GET",
      url: PAYMENT_GROUP_PENDING_DELIVERY_COMPANY,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      }
    };

    const response = await axios.request(options);

    return {
      groups: response.data.groups as IFullPaymentGroup[],
      error: null,
    };
  } catch (error: unknown) {
    console.log("e", error);
    return {
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};

export const fetchPaymentGroupsApprovedOfDeliveryCompanyAPI = async (
  id: string,
  page: number,
  pageSize: number,
  createAfter?: Date | null,
  createBefore?: Date | null
) => {
  try {
    const baseUrl = PAYMENT_GROUP_APPROVED_DELIVERY_COMPANY;

    const queryParams = [];

    if (createAfter !== null && createAfter !== undefined) {
      queryParams.push(`createAfter=${createAfter}`);
    }

    if (createBefore !== null && createBefore !== undefined) {
      queryParams.push(`createBefore=${createBefore}`);
    }

    const queryString =
      queryParams.length > 0 ? `&${queryParams.join("&")}` : "";
    const options = {
      method: "GET",
      url: `${baseUrl}?page=${page}&pageSize=${pageSize}${queryString}`,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data: {
        companyId: id,
      },
    };

    const response = await axios.request(options);

    return {
      groups: response.data.groups as IFullPaymentGroup[],
      page: response.data.page as number,
      total: response.data.total as number,
      error: null,
    };
  } catch (error: unknown) {
    console.log("e", error);
    return {
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};



export const fetchTransactionDetailsForDeliveryCompanyAPI = async (
  uuid : string
) => {
  try {
    const options = {
      method: "POST",
      url: GET_TRANSACTION_FOR_DELIVERY_COMPANY,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data: { transactionUuid: uuid },
    };  

    const response = await axios.request(options);

    return {
      transaction: response.data.transaction as IAdminFullTransaction,
      deliveryPayment : response.data.deliveryPayment as IPaymentWithGroup,
      error: null,
    };
  } catch (error: unknown) {
    console.log("e", error);
    return {
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};