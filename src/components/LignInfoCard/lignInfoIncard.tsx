import React from "react";
import "./lignInfoCard.css";
type Props = {
  title: string;
  value: string;
  icon: React.ReactNode;
  subDescr?: string;
};

const LigneInfoInCard = ({ icon, title, value, subDescr }: Props) => {
  return (
    <div className="card-information-lign">
      <div className="information-title">{title}</div>
      <div>
        <div className="icon-container">{icon}</div>
        <span>{value} </span>
        {subDescr ? <div className="sub-descr">5 hour ago</div> : null}
      </div>
    </div>
  );
};

export default LigneInfoInCard;
