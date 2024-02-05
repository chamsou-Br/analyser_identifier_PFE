import { useNavigate } from "react-router";
import Layout from "./layout";
import { useSelector } from "react-redux";
import { RootState, useAppDispatch } from "../../state/store";
import { useEffect } from "react";
import { getAdminProfile } from "../../state/actions/authAction";

type props = {
  component: React.ComponentType;
};
const CustomElement = (props: props) => {
  const auth = useSelector((state: RootState) => state.auth);
  const navigate = useNavigate();
  const dispatch = useAppDispatch();

  useEffect(() => {
    if (!auth.isAuth) {
      navigate("/auth");
    } else {
      if (!auth.admin) {
        dispatch(getAdminProfile(auth.token ? auth.token : ""));
      }
    }
  }, [auth, navigate]);

  if (auth.isAuth && auth.admin)
    return (
      <Layout>
        <props.component />
      </Layout>
    );
};

export default CustomElement;
