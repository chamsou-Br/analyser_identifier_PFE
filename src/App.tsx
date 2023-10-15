/* eslint-disable @typescript-eslint/no-unused-vars */

import { Provider } from "react-redux";
import TransactionScreen from "./screens/transactionScreen";
import store from "./state/store";
import LoginScreen from "./screens/loginScreen";
import TransactionDetails from "./screens/transactionDetails";
import Layout from "./components/layout";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import BuyerScreen from "./screens/buyerScreen";
import TestScreen from "./screens/test";
import SellerScreen from "./screens/sellerScreen";

function App() {
  return (
    <Provider store={store}>
      <BrowserRouter>
        <Layout>
          <Routes>
            <Route path="/" element={<TransactionScreen />} />
            <Route path="/test" element={<TestScreen />} />
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
