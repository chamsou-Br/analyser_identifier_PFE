/* eslint-disable @typescript-eslint/no-unused-vars */

import { Provider } from "react-redux";

import store from "./state/store";

import BrowserRouterContainer from "./router/BrowserRouterContainer";

function App() {
  return (
    <Provider store={store}>
      <BrowserRouterContainer />
    </Provider>
  );
}

export default App;
