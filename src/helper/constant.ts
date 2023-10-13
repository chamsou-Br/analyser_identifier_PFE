import { DeliveryType } from "./types";

export const BASE_URL = "http://localhost:7550/api"

export const Currency = " $ "

export const Authorization =  'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoibmFzc2ltIiwiaWQiOjAsImlhdCI6MTY5NTMyOTQ1OCwiaXNzIjoiYXBwbGljYXRpb24ifQ.NuTJS68OAxJTUJ9lbHHG9vzivObneKsZanfuwiJnqj-PVkF4OVJjlqtgWpuF8jAuTcC-2RxP138ydAsaYoR5x0ZdVhbk6jicyTP78m57NkGVGlUtRGzyRVIFJsmI1Q9tuoZu0hbSxVUk3jkfgmEg7SG-H38onP71GfoUfJucQj8HZD27nWKa2Ik_NqwSSFdI16cKoIbta8WcXjVeRBfFuehlxfQbyEkQNOHNrzUaRu5BslM9OfD0upHE777L1ozCAAtas3iUx2j-HhSdL6YrY9pWq6-tnNv1dwXHWVANEiu9YzF1Xqx9I8uPgZSEkE-In12Xk5CEFHyF86991tKbRA'

export function getDeliveryTypeTitle(deliveryType: DeliveryType): string {
    switch (deliveryType) {
      case DeliveryType.LOCAL_WILAYA_ONLY:
        return 'Local';
      case DeliveryType.BETWEEN_WILAYAS:
        return 'Inter-Wilaya';
      case DeliveryType.PICK_FROM_SHOP:
        return 'Pickup';
      case DeliveryType.NOT_NEEDED:
        return 'Not Needed';
      default:
        return 'Unknown';
    }
  }


  export  function getFormatDate(inputDate : string) {
    const options : Intl.DateTimeFormatOptions  = { year: 'numeric', month: 'short', day: 'numeric' };
    const date = new Date(inputDate);
    return date.toLocaleDateString(undefined, options);
  }
