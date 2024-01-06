import React from "react";
import "./status.css";
type Props = {
  status: string;
};

interface statusStyle {
  pending: string;
  started: string;
  accepted: string;
  rejected: string;
  fulfilled: string;
  active : string;
  payed: string;
  canceled: string;
  ongoing: string;
  fulfilled_continue: string;
  fulfilled_hold: string;
  payed_buyer_cancel_early: string;
  payed_buyer_cancel_mid: string;
  payed_buyer_cancel_late: string;
  payed_seller_cancel: string;
  payed_ghosted: string;
  closed_success: string;
}
const Status = ({ status }: Props) => {
  const styles: statusStyle = {
    pending: "#EB904F",
    ongoing: "#EB904F",
    started: "#3782ec",
    payed: "#b7ec4d",
    accepted: "#88d399",
    active : "#44E46A",
    fulfilled: "#44E46A",
    rejected: "#E84949",
    canceled: "#E84949",
    fulfilled_continue: "#44E46A",
    fulfilled_hold: "#EB904F",
    payed_buyer_cancel_early: "#E84949",
    payed_buyer_cancel_mid: "#E84949",
    payed_buyer_cancel_late: "#E84949",
    payed_seller_cancel: "#EB904F",
    payed_ghosted: "#E84949",
    closed_success: "#44E46A",
  };

  return (
    <div className="status">
      <div
        onClick={() => console.log(status.replace("-", "_"))}
        className="status-container"
        style={
          styles[status.replace("-", "_").toLowerCase() as keyof statusStyle] !=
          undefined
            ? {
                backgroundColor:
                  styles[status.replace("-", "_") as keyof statusStyle],
              }
            : { backgroundColor: "#3782ec" }
        }
      >
        {status}
      </div>
    </div>
  );
};

export default Status;
