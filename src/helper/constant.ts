import { DeliveryType, TransactionStatus } from "./types";

export const BASE_URL = "https://api.paypart.dz/api" // "http://localhost:7550/api" 

export const tokenName = "pepper_token";

export const Currency = " DA ";

export const tableLimit = "Table_Limit"

export const InvalidToken = "Invalid token: TokenExpiredError: jwt expired"

export const Authorization = () => {
  return localStorage.getItem(tokenName) != null
    ? localStorage.getItem(tokenName)
    : "";
};

export const getDeliveryTypeTitle = (deliveryType: DeliveryType): string => {
  switch (deliveryType) {
    case DeliveryType.LOCAL_WILAYA_ONLY:
      return "Local";
    case DeliveryType.BETWEEN_WILAYAS:
      return "Inter Wilaya";
    case DeliveryType.PICK_FROM_SHOP:
      return "Pickup";
    case DeliveryType.NOT_NEEDED:
      return "Not Needed";
    default:
      return "Unknown";
  }
}

export const getFormatDate = (inputDate: Date | undefined) => {
  if (!inputDate) return ""
  const date = inputDate ? inputDate.toString().split("T")[0] : ""
  const options: Intl.DateTimeFormatOptions = {
    year: "numeric",
    month: "short",
    day: "numeric",
  };
  const newDate = new Date(date);
  return newDate.toLocaleDateString(undefined, options);
}

export const getFullFormatDate = (date:  Date | undefined ) => {
  const inputDate = date ? date.toString() : ""
  if (!inputDate) return "-"

  const options: Intl.DateTimeFormatOptions = {
    year: "numeric",
    month: "short",
    day: "numeric",
    hour: "2-digit",
    minute: "2-digit",
    timeZone: "UTC",
    hour12: true,
  };

  const newDate = new Date(inputDate);
  const formattedDate = newDate.toLocaleDateString("en-US", options);
  return formattedDate;
};

export const getFormatPrice = (price: number | undefined): string  => {
  if (price != undefined) {
    // Use toFixed(2) to ensure two decimal places and convert it to a string
    const formattedPrice = price.toFixed(2);
    // Replace the decimal point with a period
    return formattedPrice.replace(".", ".") + " " + Currency;
  }
  return "0.00" + " " + Currency;
}


export const getTimeAgo = (input : Date | undefined) => {
// Your initial timestamp
const date = input ? input?.toString() : ""

const timestamp = new Date(date);

// Current time
const currentTime = new Date();

// Calculate the time difference in milliseconds
const timeDifference = currentTime.getTime() - timestamp.getTime();

// Calculate time ago
if (timeDifference < 1000 * 60 * 60) {
  // Less than an hour ago
  const minutesAgo = Math.floor(timeDifference / (1000 * 60));
  return `${minutesAgo} minutes ago`
} else if (timeDifference < 1000 * 60 * 60 * 24) {
  // Less than a day ago
  const hoursAgo = Math.floor(timeDifference / (1000 * 60 * 60));
  return `${hoursAgo} hours ago`
} else {
  // More than a day ago
  const daysAgo = Math.floor(timeDifference / (1000 * 60 * 60 * 24));
  return `${daysAgo} days ago`
}

}


export const getShortStatusDescriptionFr = (
  status: TransactionStatus
): string => {
  switch (status) {
    case TransactionStatus.OPENED:
      return "Opened";
    case TransactionStatus.ACCEPTED:
      return "Accepted";
    case TransactionStatus.PAYED:
      return "Payed";
    case TransactionStatus.FULFILLED:
      return "Validated";
    case TransactionStatus.FULFILLED_HOLD:
      return "Validated with claims";
    case TransactionStatus.FULFILLED_CONTINUE:
      return "Validated After review";
    case TransactionStatus.CANCELED:
      return "Canceled";
    case TransactionStatus.PAYED_BUYER_CANCEL_EARLY:
      return "Canceled by buyer early";
    case TransactionStatus.PAYED_BUYER_CANCEL_MID:
      return "Canceled by buyer mid";
    case TransactionStatus.PAYED_BUYER_CANCEL_LATE:
      return "Canceled by buyer late";
    case TransactionStatus.PAYED_GHOSTED:
      return "Canceled by buyer absence ";
    case TransactionStatus.PAYED_SELLER_CANCEL:
      return "Canceled by seller [payed]";
    case TransactionStatus.PAYED_REIMBURSED:
      return "Reimbursed";
    case TransactionStatus.PAYED_COMPLEX_CANCEL:
      return "Reimbursed complex";

    default:
      return "Statut inconnu";
  }
};

