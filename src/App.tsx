/* eslint-disable @typescript-eslint/no-unused-vars */

import { Provider } from "react-redux";
import TransactionScreen from "./screens/transactionScreen";
import store from "./state/store";
import LoginScreen from "./screens/loginScreen";
import TransactionDetails from "./screens/transactionDetails";
import Layout from "./components/Layout/layout";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import BuyerScreen from "./screens/buyerScreen";
import SellerScreen from "./screens/sellerScreen";
import TransactionFulfilledScreen from "./screens/transactionFulfilledScreen";
import TransactionCanceledScreen from "./screens/transactionCanceledScreen";

function App() {
  return (
    <Provider store={store}>
      <BrowserRouter>
        <Layout>
          <Routes>
            <Route path="/" element={<TransactionScreen />} />
            <Route path="/fulfilled" element={<TransactionFulfilledScreen />} />
            <Route path="/canceled" element={<TransactionCanceledScreen />} />
            <Route path="/buyer" element={<BuyerScreen />} />
            <Route path="/seller" element={<SellerScreen />} />
            <Route path="/details/:uuid" element={<TransactionDetails />} />
          </Routes>
        </Layout>
      </BrowserRouter>
    </Provider>
  );
}

export default App;
