import axios from "axios";
import { BASE_URL } from "./constant";



axios.defaults.baseURL = BASE_URL;

// axios.interceptors.response.use(
//     (response) => response,
//     (error) => {
//       console.log('\nfirst fetch data \n', error)
//       if (error.response.status === 401) {
//         store.dispatch(Logout())
//       }
//       return Promise.reject(error)
//     },
//    )

//   export const setAuthorization = (token) => {
//     if (!token.trim()) return
//     const Authorization = `Bearer ${token}`
//     console.log('\setAuthorization', token)
//     axios.defaults.headers.common = {
//       Authorization,
//     }
//   }

export default axios;