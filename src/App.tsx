/* eslint-disable @typescript-eslint/no-unused-vars */

import { Provider } from "react-redux"
import TransactionScreen from "./screens/transactionScreen"
import store from "./state/store"
import LoginScreen from "./screens/loginScreen"


function App() {


  

  return (
    <Provider store={store}>
        <TransactionScreen />
   </Provider>

  )
}

export default App
