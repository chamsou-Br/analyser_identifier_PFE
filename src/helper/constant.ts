import { DeliveryType } from "./types";

export const BASE_URL = "http://localhost:7550/api";

export const tokenName = "pepper_token"

export const Currency = " $ ";

export const Authorization = () => {
  return localStorage.getItem(tokenName) != null ? localStorage.getItem(tokenName) : ""
}

export function getDeliveryTypeTitle(deliveryType: DeliveryType): string {
  switch (deliveryType) {
    case DeliveryType.LOCAL_WILAYA_ONLY:
      return "Local";
    case DeliveryType.BETWEEN_WILAYAS:
      return "Inter-Wilaya";
    case DeliveryType.PICK_FROM_SHOP:
      return "Pickup";
    case DeliveryType.NOT_NEEDED:
      return "Not Needed";
    default:
      return "Unknown";
  }
}

export function getFormatDate(inputDate: string) {
  const options: Intl.DateTimeFormatOptions = {
    year: "numeric",
    month: "short",
    day: "numeric",
  };
  const date = new Date(inputDate);
  return date.toLocaleDateString(undefined, options);
}

export function getFormatPrice(price: number | undefined): string {
  if (price != undefined) {
    // Use toFixed(2) to ensure two decimal places and convert it to a string
    const formattedPrice = price.toFixed(2);
    // Replace the decimal point with a period
    return formattedPrice.replace(".", ".");
  }
  return "0.00";
}
