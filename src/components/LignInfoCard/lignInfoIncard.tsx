import React from "react";
import "./lignInfoCard.css";
type Props = {
  title: string;
  value: string;
  icon: React.ReactNode;
  subDescr?: string;
  action?: () => void;
};

const LigneInfoInCard = ({ icon, title, value, subDescr, action }: Props) => {
  return (
    <div className="card-information-lign">
      <div className="information-title">{title}</div>
      <div>
        <div className="icon-container">{icon}</div>
        <span>{value} </span>
        {subDescr ? (
          <div onClick={() => (action ? action() : null)} className={ action ? "sub-descr action" : "sub-descr"}>
            {subDescr}
          </div>
        ) : null}
      </div>
    </div>
  );
};

export default LigneInfoInCard;
