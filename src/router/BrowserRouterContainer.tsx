import { BrowserRouter, Route, Routes } from "react-router-dom";
import Page404 from "../components/404/page404";
import CustomElement from "../components/Layout/customElement";
import TransactionDetails from "../screens/transactionDetails";
import HomeScreen from "../screens/homeScreen";
import MultipleAnalyzeScreen from "../screens/multipleAnalyzeScreen";


const BrowserRouterContainer = () => {
  return (
    <BrowserRouter>
    <Routes  >
    <Route path="/" element={<CustomElement component={HomeScreen} />} />
      <Route path="/analyze" element={<CustomElement component={MultipleAnalyzeScreen} />} />
      <Route path="/transaction/:uuid" element={<CustomElement component={TransactionDetails} />} />
      <Route path="*" element={<Page404 />} />
    </Routes>
</BrowserRouter>
  )
}

export default BrowserRouterContainer