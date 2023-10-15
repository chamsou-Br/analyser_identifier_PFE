import React from "react";
import "../styles/shared.css";
type Props = {
  status: string;
};

interface statusStyle {
  pending: string;
  started: string;
  accepted: string;
  rejected: string;
  fulfilled : string;
  payed : string;
  canceled : string;
  ongoing : string;
}
function Status(props: Props) {
  const styles: statusStyle = {
    pending: "#EB904F",
    ongoing : "#EB904F",
    started: "#3782ec",
    payed : "#44E46A",
    accepted: "#44E46A",
    fulfilled : "#44E46A",
    rejected: "#E84949",
    canceled : "#E84949"
  };

  return (
    <div className="status">
      <div
        className="status-container"
        style={
          styles[props.status.toLowerCase() as keyof statusStyle] != undefined
            ? { backgroundColor: styles[props.status as keyof statusStyle] }
            : { backgroundColor: "#3782ec" }
        }
      >
        {props.status}
      </div>
    </div>
  );
}

export default Status;
