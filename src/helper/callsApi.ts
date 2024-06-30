/* eslint-disable @typescript-eslint/no-unused-vars */
import { AxiosError } from "axios";
import axios from "./axiosConfig";
import {
  IClassAnalyzer,
  ICluster,
  IFullPaymentGroup,
} from "./types";
import { CLUSTER_CANDIDATES, GLOBAL_ANALYZER, MULTIPLE_ANALYZER } from "./API";


export const getMultipleClassesAnalyzer = async (path: string) => {
  try {
  
    const options = {
      method: "POST",
      url: MULTIPLE_ANALYZER,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      data: {
        path: path,
      },
    };

    const response = await axios.request(options);

    return {
      classes: response.data.classes as IClassAnalyzer[],
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


export const getGlobalGraphAnalyzer = async (path: string) => {
  try {
  
    const options = {
      method: "POST",
      url: GLOBAL_ANALYZER,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      data: {
        path: path,
      },
    };

    console.log(options)

    const response = await axios.request(options);

    return {
      callGraph: response.data.callGraph as string,
      callGraphData : response.data.callGraphData as string,
      error: null,
    };
  } catch (error: unknown) {
    console.log("err" , error)
    return {
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};



export const getClustersCandidates = async (path: string , alpha : number , beta : number) => {
  try {
  
    const options = {
      method: "POST",
      url: CLUSTER_CANDIDATES,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      data: {
        path: path,
        alpha: alpha,
        beta : beta
      },
    };

    const response = await axios.request(options);

    return {
      clusters: response.data.clusters as ICluster[],
      error: null,
    };
  } catch (error: unknown) {
    console.log("err" , error)
    return {
      error: (error as AxiosError<{ message: string }>).response?.data.message
        ? (error as AxiosError<{ message: string }>).response?.data.message
        : "An unknown error occurred",
    };
  }
};


