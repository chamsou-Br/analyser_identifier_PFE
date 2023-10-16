import {   useNavigate } from "react-router";
import Layout from "./layout";
import { useSelector } from "react-redux";
import { RootState } from "../../state/store";
import { useEffect } from "react";

type props = {
  component: React.ComponentType;
};
const CustomElement = (props: props) => {
  const auth = useSelector((state: RootState) => state.auth);
  const navigate = useNavigate()

useEffect(()=>{
  if (!auth.isAuth) {
    navigate("/auth")
  }
},[])


if (auth.isAuth)
    return (
      <Layout>
        <props.component />
      </Layout>
    );




};

export default CustomElement;
