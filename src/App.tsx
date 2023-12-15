/* eslint-disable @typescript-eslint/no-unused-vars */

import { Provider } from "react-redux";
import TransactionScreen from "./screens/transactionScreen";
import store from "./state/store";
import LoginScreen from "./screens/loginScreen";
import TransactionDetails from "./screens/transactionDetails";
import Layout from "./components/Layout/layout";
import { BrowserRouter, Navigate, Route, Routes } from "react-router-dom";
import BuyerScreen from "./screens/buyerScreen";
import SellerScreen from "./screens/sellerScreen";
import TransactionFulfilledScreen from "./screens/transactionFulfilledScreen";
import TransactionCanceledScreen from "./screens/transactionCanceledScreen";
import Page404 from "./components/404/page404";
import CustomElement from "./components/Layout/customElement";
import HistorieScreen from "./screens/historieScreen";
import InvitationDetails from "./screens/invitationDetails";
import InvitaionsScreen from "./screens/invitaionsScreen";
import DeliveryCompanyScreen from "./screens/deliveryCompanyScreen";



function App() {


  return (
    <Provider store={store}>
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
    </Provider>
  );
}

export default App;
