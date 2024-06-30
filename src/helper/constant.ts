import { DeliveryType, TransactionStatus } from "./types";

export const BASE_URL = "http://localhost:3009" 

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


export const formatRIB = (rib : string)  => {
  // Remove non-numeric characters
  rib = rib.replace(/\D/g, '');

  // Insert spaces every 5 characters for better readability
  rib = rib.replace(/(.{5})/g, '$1 ').trim();

  return rib;
}


export const headerOfTransactionsExport = [
  { label: 'UUID', key: 'uuid' },
  { label: 'Delivery Date', key: 'deliveryDate' },
  { label: 'Delivery Place', key: 'deliveryPlace' },
  { label: 'Delivery Type', key: 'deliveryType' },
  { label: 'Delivery Price', key: 'deliveryPrice' },
  { label: 'Payment Date', key: 'paymentDate' },
  { label: 'Validation Date', key: 'validationDate' },
  { label: 'Satim Order Id', key: 'satimOrderId' },
  { label: 'Satim Order Number', key: 'satimOrderNumber' },
  { label: 'State', key: 'state' },
  { label: 'Certified Delivery', key: 'certifiedDelivery' },
  { label: 'Certified Company', key: 'certifiedCompany' },
  { label: 'Buyer First Name', key: 'Buyer.firstName' },
  { label: 'Buyer Last Name', key: 'Buyer.lastName' },
  { label: 'Buyer Phone Number', key: 'Buyer.phoneNumber' },
  { label: 'Invitation Product', key: 'Invitation.product' },
  { label: 'Invitation Delivery Type', key: 'Invitation.deliveryType' },
  { label: 'Seller Phone Number', key: 'Invitation.Seller.phoneNumber' },
  { label: 'Seller Email', key: 'Invitation.Seller.email' },
  { label: 'Seller Business Name', key: 'Invitation.Seller.businessName' },
]

export const headerOFPaymentsExportForDeliveryCompany = [
    { label: 'ID', key: 'id' },
    { label: 'RIB', key: 'rib' },
    { label: 'Type', key: 'type' },
    { label: 'payment Amount', key: 'fullAmount' },
    { label: 'Created At', key: 'createdAt' },
    { label: 'Executed Date', key: 'executedDate' },
    { label: 'Delivery Office Company', key: 'DeliveryOffice.company' },
    { label: 'Delivery Office Email', key: 'DeliveryOffice.email' },
    { label: 'Delivery Office Phone Number', key: 'DeliveryOffice.phoneNumber' },
    { label: 'Transaction UUID', key: 'Transaction.uuid' },
    { label: 'Creation Date', key: 'Transaction.createdAt' },
    { label: 'Transaction State', key: 'Transaction.state' },
    { label: 'Satim Order Id', key: 'Transaction.satimOrderId' },
    { label: 'Satim Order Number', key: 'Transaction.satimOrderNumber' },
    { label: 'Delivery Date', key: 'Transaction.deliveryDate' },
    { label: 'Delivery Place', key: 'Transaction.deliveryPlace' },
    { label: 'Delivery Type', key: 'Transaction.deliveryType' },
    { label: 'Delivery Price', key: 'Transaction.deliveryPrice' },
    { label: 'Payment Date', key: 'Transaction.paymentDate' },
    { label: 'Validation Date', key: 'Transaction.validationDate' },   
  ];

  export const headerOFPaymentsExportForSeller = [
    { label: 'ID', key: 'id' },
    { label: 'RIB', key: 'rib' },
    { label: 'Type', key: 'type' },
    { label: 'payment Amount', key: 'fullAmount' },
    { label: 'Created At', key: 'createdAt' },
    { label: 'Executed Date', key: 'executedDate' },
    { label: 'Seller Phone Number', key: 'Seller.phoneNumber' },
    { label: 'Seller Email', key: 'Seller.email' },
    { label: 'Seller Business Name', key: 'Seller.businessName' },
    { label: 'Transaction UUID', key: 'Transaction.uuid' },
    { label: 'Creation Date', key: 'Transaction.createdAt' },
    { label: 'Transaction State', key: 'Transaction.state' },
    { label: 'Satim Order Id', key: 'Transaction.satimOrderId' },
    { label: 'Satim Order Number', key: 'Transaction.satimOrderNumber' },
    { label: 'Delivery Date', key: 'Transaction.deliveryDate' },
    { label: 'Delivery Place', key: 'Transaction.deliveryPlace' },
    { label: 'Delivery Type', key: 'Transaction.deliveryType' },
    { label: 'Delivery Price', key: 'Transaction.deliveryPrice' },
    { label: 'Payment Date', key: 'Transaction.paymentDate' },
    { label: 'Validation Date', key: 'Transaction.validationDate' },   
  ];

  export const headerOFPaymentsExportForBuyer = [
    { label: 'ID', key: 'id' },
    { label: 'RIB', key: 'rib' },
    { label: 'Type', key: 'type' },
    { label: 'payment Amount', key: 'fullAmount' },
    { label: 'Created At', key: 'createdAt' },
    { label: 'Executed Date', key: 'executedDate' },
    { label: 'Buyer First Name', key: 'Buyer.firstName' },
    { label: 'Buyer Last Name', key: 'Buyer.lastName' },
    { label: 'Buyer Phone Number', key: 'Buyer.phoneNumber' },
    { label: 'Transaction UUID', key: 'Transaction.uuid' },
    { label: 'Creation Date', key: 'Transaction.createdAt' },
    { label: 'Transaction State', key: 'Transaction.state' },
    { label: 'Satim Order Id', key: 'Transaction.satimOrderId' },
    { label: 'Satim Order Number', key: 'Transaction.satimOrderNumber' },
    { label: 'Delivery Date', key: 'Transaction.deliveryDate' },
    { label: 'Delivery Place', key: 'Transaction.deliveryPlace' },
    { label: 'Delivery Type', key: 'Transaction.deliveryType' },
    { label: 'Delivery Price', key: 'Transaction.deliveryPrice' },
    { label: 'Payment Date', key: 'Transaction.paymentDate' },
    { label: 'Validation Date', key: 'Transaction.validationDate' },   
  ];

  export function getLastCapitalWord(str : string) {
    // Match words that start with a capital letter at the end of the string
    const matches = str.match(/[A-Z][a-z]*$/g);

    // If matches found, return the last match, otherwise return an empty string
    return matches ? matches[matches.length - 1] : '';
}