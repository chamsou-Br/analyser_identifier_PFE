import axios from "axios";
import { BASE_URL, InvalidToken } from "./constant";
import store from "../state/store";
import { logout } from "../state/actions/authAction";



axios.defaults.baseURL = BASE_URL;

axios.interceptors.response.use(
    (response) => response,
    (error) => {
      if (error.response.status === 401 && error.response.data.message == InvalidToken ) {
        console.log("logout")
        store.dispatch(logout())
      }
      return Promise.reject(error)
    },
   )

//   export const setAuthorization = (token) => {
//     if (!token.trim()) return
//     const Authorization = `Bearer ${token}`
//     console.log('\setAuthorization', token)
//     axios.defaults.headers.common = {
//       Authorization,
//     }
//   }

export default axios;