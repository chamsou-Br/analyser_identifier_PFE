/* eslint-disable @typescript-eslint/no-unused-vars */
import { AxiosError } from "axios";
import axios from "./axiosConfig";
import { Authorization } from "./constant";
import {
  IAdmin,
  IAdminFullTransaction,
  IDeliveryOffice,
  IFullPaymentGroup,
  IHistory,
  IInvitation,
  IInvitationComplete,
  IInvitationTransaction,
  IPaymentWithGroup,
  IRipRequests,
  ISellerBase,
  ISellerWithRibRequests,
  ITransactionClosing,
} from "./types";
import {
  ACCEPT_RIP_REQUEST,
  ADD_ADMIN,
  ADD_NOTE,
  ADMIN_ACTION,
  APPROVE_PAYMENT_GROUP,
  BLOCK_ADMIN,
  BLOCK_SELLER,
  BUYER_HISTORY,
  CLOSE_TRANSACTION,
  CREATE_PAYMENT,
  DECIDE_TRANSACTION,
  DELIVERY_COMPANY,
  GENERATE_PAYMENT_GROUP,
  GET_CLOSING_INFO,
  INVITAION_DETAILS,
  LIST_ADMINS,
  LOCK_PAYMENT_GROUP,
  PAYMENTS_OF_TRANSACTION,
  PAYMENT_GROUP,
  PAYMENT_GROUP_APPROVED,
  PAYMENT_GROUP_PENDING,
  REJECT_INVITATION,
  REJECT_RIP_REQUEST,
  RIB_REQUESTS,
  SELLER_HISTORY,
  VALIDATE_INVITATION,
} from "./API";

export const addNoteOfTransactionAPI = async (
  uuid: string,
  title: string,
  text: string
) => {
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
  raison: string
) => {
  try {
    const options = {
      method: "POST",
      url: DECIDE_TRANSACTION,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data: {
        transactionUuid: uuid,
        decision: decision,
        reason: raison,
      },
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
};

export const closeTransactionAPI = async (uuid: string) => {
  try {
    const options = {
      method: "POST",
      url: CLOSE_TRANSACTION,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data: { transactionUuid: uuid },
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
};

export const getBuyerHistorieAPI = async (email: string) => {
  try {
    const options = {
      method: "POST",
      url: BUYER_HISTORY,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data: { BuyerEmail: email },
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
};

export const getSellerHistorieAPI = async (email: string) => {
  try {
    const options = {
      method: "POST",
      url: SELLER_HISTORY,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data: { sellerEmail: email },
    };

    const response = await axios.request(options);

    return {
      historiy: response.data.invitations as IInvitationTransaction[],
      requests : response.data.requests as IRipRequests[],
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
};

export const blockSellerAPI = async (email: string) => {
  try {
    const options = {
      method: "POST",
      url: BLOCK_SELLER,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data: { sellerEmail: email },
    };

    const response = await axios.request(options);

    return {
      seller: response.data.seller as ISellerBase,
      error: undefined,
    };
  } catch (error: unknown) {
    return {
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};

export const getClosingInfoAPI = async (uuid: string) => {
  try {
    const options = {
      method: "POST",
      url: GET_CLOSING_INFO,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data: { transactionUuid: uuid },
    };

    const response = await axios.request(options);

    return {
      info: response.data.info as ITransactionClosing,
      error: null,
    };
  } catch (error: unknown) {
    return {
      info: undefined,
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};

export const getAdminActionAPI = async () => {
  try {
    const options = {
      method: "GET",
      url: ADMIN_ACTION,
      headers: {
        Authorization: Authorization(),
      },
    };

    const response = await axios.request(options);

    return {
      history: response.data.history as IHistory[],
      error: null,
    };
  } catch (error: unknown) {
    return {
      history: [],
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};

export const rejectInvitationAPI = async (uuid: string) => {
  try {
    const options = {
      method: "POST",
      url: REJECT_INVITATION,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data: { uuid: uuid },
    };

    const response = await axios.request(options);

    return {
      invitation: response.data.invitation as IInvitation,
      error: null,
    };
  } catch (error: unknown) {
    return {
      invitation: undefined,
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};

export const validateInvitationAPI = async (uuid: string) => {
  try {
    const options = {
      method: "POST",
      url: VALIDATE_INVITATION,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data: { uuid: uuid },
    };

    const response = await axios.request(options);

    return {
      invitation: response.data.invitation as IInvitation,
      error: null,
    };
  } catch (error: unknown) {
    return {
      invitation: undefined,
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};

export const fetchInvitationDetailsAPI = async (uuid: string) => {
  try {
    const options = {
      method: "POST",
      url: INVITAION_DETAILS,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data: { InvitationUuid: uuid },
    };

    const response = await axios.request(options);

    return {
      invitation: response.data.invitation as IInvitationComplete,
      error: null,
    };
  } catch (error: unknown) {
    return {
      invitation: undefined,
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};

export const fetchDeliveryCompanyAPI = async () => {
  try {
    const options = {
      method: "GET",
      url: DELIVERY_COMPANY,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
    };

    const response = await axios.request(options);
    console.log(response,"oo")

    return {
      companies: response.data.companies as IDeliveryOffice[],
      error: null,
    };
  } catch (error: unknown) {
    console.log("e",error)
    return {
      
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};

export const deleteDeliveryCompanyAPI = async (id : number) => {
  try {

const options = {
      method: 'DELETE',
      url: DELIVERY_COMPANY,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        Authorization: Authorization()
      },
      data: {id: id}
};

    const response = await axios.request(options);

    return {
      companies: response.data.companies as true,
      error: null,
    };
  } catch (error: unknown) {
    console.log("e",error)
    return {
      
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};


export const addDeliveryCompanyAPI = async (company  : string , email : string , phoneNumber : string) => {
  try {

    const options = {
      method: 'POST',
      url: DELIVERY_COMPANY,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        Authorization: Authorization()
      },
      data: {
        company: company,
        email: email,
        phoneNumber: phoneNumber
      }
    };

    const response = await axios.request(options);

    return {
      company: response.data.company as IDeliveryOffice,
      error: null,
    };
  } catch (error: unknown) {
    console.log("e",error)
    return {
      
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};


export const getAllRibRequestsAPI = async () => {
  try {

    const options = {
      method: 'GET',
      url: RIB_REQUESTS,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        Authorization: Authorization()
      },
    };

    const response = await axios.request(options);

    return {
      sellers: response.data.sellers as ISellerWithRibRequests[],
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

export const acceptRibRequestAPI = async (sellerEmail : string,ribRequestId : number) => {
  try {

    const options = {
      method: 'POST',
      url: ACCEPT_RIP_REQUEST,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        Authorization: Authorization()
      },
      data : {
        sellerEmail : sellerEmail,
        ribRequestId : ribRequestId
      }
    };

    const response = await axios.request(options);

    return {
      seller : response.data.seller as ISellerBase,
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

export const rejectRibRequest = async (sellerEmail : string) => {
  try {

    const options = {
      method: 'POST',
      url: REJECT_RIP_REQUEST,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        Authorization: Authorization()
      },
      data : {
        sellerEmail : sellerEmail
      }
    };

    const response = await axios.request(options);

    return {
      seller : response.data.seller as ISellerBase,
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



export const fetchListAdminsAPI = async () => {
  try {
    const options = {
      method: "GET",
      url: LIST_ADMINS,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
    };

    const response = await axios.request(options);

    return {
      admins: response.data.admins as IAdmin[],
      error: null,
    };
  } catch (error: unknown) {
    console.log("e",error)
    return {
      
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};

export const blockAdminAPI = async (id : number) => {
  try {
    const options = {
      method: "DELETE",
      url: BLOCK_ADMIN,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data : {
        id : id
      }
    };

    const response = await axios.request(options);

    return {
      admins: response.data.admins as IAdmin[],
      error: null,
    };
  } catch (error: unknown) {
    console.log("e",error)
    return {
      
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};

export const addAdminAPI = async (name : string) => {
  try {
    const options = {
      method: "POST",
      url: ADD_ADMIN,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data : {
        name : name      
      }
    };

    const response = await axios.request(options);

    return {
      admin: response.data.admin as IAdmin,
      error: null,
    };
  } catch (error: unknown) {
    console.log("e",error)
    return {
      
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};


export const createPaymentAPI = async (transactionUuid : string) => {
  try {
    const options = {
      method: "POST",
      url: CREATE_PAYMENT,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data : {
        transactionUuid : transactionUuid      
      }
    };

    const response = await axios.request(options);

    return {
      transaction: response.data.transaction as IAdminFullTransaction,
      error: null,
    };
  } catch (error: unknown) {
    console.log("e",error)
    return {
      
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};

export const fetchPaymentGroupsPendingAPI = async ( ) => {
  try {
    const options = {
      method: "GET",
      url: PAYMENT_GROUP_PENDING,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
    };

    const response = await axios.request(options);

    return {
      groups: response.data.groups as IFullPaymentGroup[],
      error: null,
    };
  } catch (error: unknown) {
    console.log("e",error)
    return {
      
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};

export const fetchPaymentGroupsApprovedAPI = async ( ) => {
  try {
    const options = {
      method: "GET",
      url: PAYMENT_GROUP_APPROVED,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
    };

    const response = await axios.request(options);

    return {
      groups: response.data.groups as IFullPaymentGroup[],
      error: null,
    };
  } catch (error: unknown) {
    console.log("e",error)
    return {
      
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};

export const generatePaymentGroupsAPI = async ( ) => {
  try {
    const options = {
      method: "GET",
      url: GENERATE_PAYMENT_GROUP,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
    };

    const response = await axios.request(options);

    return {
      success: response.data.success as boolean,
      error: null,
    };
  } catch (error: unknown) {
    console.log("e",error)
    return {
      
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};

export const lockPaymentGroupsAPI = async (id : number) => {
  try {
    const options = {
      method: "POST",
      url: LOCK_PAYMENT_GROUP,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data : {
        groupId : id
      }
    };

    const response = await axios.request(options);

    return {
      group: response.data.group as IFullPaymentGroup,
      error: null,
    };
  } catch (error: unknown) {
    console.log("e",error)
    return {
      
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};

export const approvePaymentGroupsAPI = async (id : number) => {
  try {
    const options = {
      method: "POST",
      url: APPROVE_PAYMENT_GROUP,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data : {
        groupId : id
      }
    };

    const response = await axios.request(options);

    return {
      group: response.data.group as IFullPaymentGroup,
      error: null,
    };
  } catch (error: unknown) {
    console.log("e",error)
    return {
      
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};


export const getPaymentGroupAPI = async (id : number) => {
  try {
    const options = {
      method: "POST",
      url: PAYMENT_GROUP,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data : {
        groupId : id
      }
    };

    const response = await axios.request(options);

    return {
      group: response.data.group as IFullPaymentGroup,
      error: null,
    };
  } catch (error: unknown) {
    console.log("e",error)
    return {
      
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};

export const getPaymentsOfTransactionAPI = async (uuid : string) => {
  try {
    const options = {
      method: "POST",
      url: PAYMENTS_OF_TRANSACTION,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: Authorization(),
      },
      data : {
        transactionUuid : uuid
      }
    };

    const response = await axios.request(options);

    return {
      sellerPayment: response.data.sellerPayment as IPaymentWithGroup,
      buyerPayment: response.data.buyerPayment as IPaymentWithGroup,
      error: null,
    };
  } catch (error: unknown) {
    console.log("e",error)
    return {
      
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};



