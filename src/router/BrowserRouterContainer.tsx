import TransactionScreen from "../screens/transactionScreen";
import LoginScreen from "../screens/loginScreen";
import TransactionDetails from "../screens/transactionDetails";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import BuyerScreen from "../screens/buyerScreen";
import SellerScreen from "../screens/sellerScreen";
import TransactionFulfilledScreen from "../screens/transactionFulfilledScreen";
import TransactionCanceledScreen from "../screens/transactionCanceledScreen";
import Page404 from "../components/404/page404";
import CustomElement from "../components/Layout/customElement";
import HistorieScreen from "../screens/historieScreen";
import InvitationDetails from "../screens/invitationDetails";
import InvitaionsScreen from "../screens/invitaionsScreen";
import DeliveryCompanyScreen from "../screens/deliveryCompanyScreen";


const BrowserRouterContainer = () => {
  return (
    <BrowserRouter>
    <Routes  >
      <Route path="/" element={<CustomElement component={TransactionScreen} />} />
      <Route path="/fulfilled" element={<CustomElement component={TransactionFulfilledScreen} />} />
      <Route path="/invitation" element={ <CustomElement component={InvitaionsScreen} /> } />
      <Route path="/canceled" element={<CustomElement component={TransactionCanceledScreen} />} />
      <Route path="/history" element={<CustomElement component={HistorieScreen} />} />
      <Route path="/invitation/:uuid" element={<CustomElement component={InvitationDetails } />} />
      <Route path="/buyer" element={<CustomElement component={BuyerScreen} />} />
      <Route path="/seller" element={<CustomElement component={SellerScreen} />} />
      <Route path="/details/:uuid" element={<CustomElement component={TransactionDetails} />} />
      <Route path="/deliveryCompany/" element={<CustomElement component={DeliveryCompanyScreen} />} />
      <Route path="/auth" element={<LoginScreen />} />
      <Route path="*" element={<Page404 />} />
    </Routes>
</BrowserRouter>
  )
}

export default BrowserRouterContainer