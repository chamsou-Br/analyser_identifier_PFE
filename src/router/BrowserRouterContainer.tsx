import LoginScreen from "../screens/loginScreen";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import Page404 from "../components/404/page404";
import CustomElement from "../components/Layout/customElement";
import PaymentDetailsScreen from "../screens/paymentDetailsScreen";
import DeliveryCompanyDetailsScreen from "../screens/deliveryCompanyDetailsScreen";
import TransactionDetails from "../screens/transactionDetails";


const BrowserRouterContainer = () => {
  return (
    <BrowserRouter>
    <Routes  >
      <Route path="/" element={<CustomElement component={DeliveryCompanyDetailsScreen} />} />
      <Route path="/payment/:id" element={<CustomElement component={PaymentDetailsScreen} />} />
      <Route path="/transaction/:uuid" element={<CustomElement component={TransactionDetails} />} />
      <Route path="/auth" element={<LoginScreen />} />
      <Route path="*" element={<Page404 />} />
    </Routes>
</BrowserRouter>
  )
}

export default BrowserRouterContainer