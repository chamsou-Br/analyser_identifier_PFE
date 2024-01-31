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
import SellersScreen from "../screens/sellers";
import AdminsScreen from "../screens/adminsScreen";
import PaymentScreen from "../screens/paymentScreen";
import PaymentDetailsScreen from "../screens/paymentDetailsScreen";


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
      <Route path="/sellers" element={<CustomElement component={SellersScreen} />} />
      <Route path="/details/:uuid" element={<CustomElement component={TransactionDetails} />} />
      <Route path="/deliveryCompany/" element={<CustomElement component={DeliveryCompanyScreen} />} />
      <Route path="/admins/" element={<CustomElement component={AdminsScreen} />} />
      <Route path="/payment/" element={<CustomElement component={PaymentScreen} />} />
      <Route path="/payment/:id" element={<CustomElement component={PaymentDetailsScreen} />} />
      <Route path="/auth" element={<LoginScreen />} />
      <Route path="*" element={<Page404 />} />
    </Routes>
</BrowserRouter>
  )
}

export default BrowserRouterContainer