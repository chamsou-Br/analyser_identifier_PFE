
import "./delivryType.css";

type Props = {
  deliveryType: string | undefined;
};

interface delivryTypeStyle {
    local : string,
    inter_wilaya : string , 
    pickup : string,
    not_needed : string , 
    unknown : string ,

}
function DelivryType(props: Props) {

  const styles: delivryTypeStyle = {
    local : "#5cbedf",
    inter_wilaya : "#723ba4" , 
    pickup : "#fad737",
    not_needed : "#EB904F" , 
    unknown : "#E84949" ,
  };


  return (
    <div   className="delivry-type">
        
      <div
        className="delivry-type-container"
        style={
          styles[props.deliveryType?.replace(" ","_").toLowerCase() as keyof delivryTypeStyle] != undefined
            ? { backgroundColor: styles[props.deliveryType?.replace(" ","_").toLowerCase() as keyof delivryTypeStyle] }
            : { backgroundColor: "#3782ec" }
        }
      >
        {props.deliveryType}
      </div>
    </div>
  );
}

export default DelivryType;
