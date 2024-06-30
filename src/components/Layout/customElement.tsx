import Layout from "./layout";



type props = {
  component: React.ComponentType;
};
const CustomElement = (props: props) => {

    return (
      <Layout>
        <props.component />
      </Layout>
    );
};

export default CustomElement;
