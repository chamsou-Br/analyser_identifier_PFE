/* eslint-disable @typescript-eslint/no-unused-vars */

import { Provider } from "react-redux"
import TransactionScreen from "./screens/transactionScreen"
import store from "./state/store"
import LoginScreen from "./screens/loginScreen"
import TransactionDetails from "./screens/transactionDetails"
import Layout from "./components/layout"
import { BrowserRouter  , Route , Routes} from "react-router-dom"


function App() {


  

  return (
    <Provider store={store}>
      <Layout>
        <BrowserRouter>
        <Routes>
        <Route path="/" element={<TransactionScreen />} />
        <Route path="/:uuid" element={<TransactionDetails />} />
      </Routes>
        </BrowserRouter>
      </Layout>
   </Provider>

  )
}

export default App
