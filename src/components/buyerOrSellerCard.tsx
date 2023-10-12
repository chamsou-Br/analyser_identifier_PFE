import React from "react";
import {
  FaAddressCard,
  FaEnvelopeOpen,
  FaExclamation,
  FaLocationArrow,
  FaMapMarked,
  FaPhone,
} from "react-icons/fa";
import LigneInfoInCard from "./lignInfoIncard";
import Status from "./status";

type Props = {
  userName: string;
  email: string;
  phone: string;
  wilaya:string,
  address: string;
  sexe: string;
  status : string;
  businessName: string | undefined;
  onNavigateToDetails: ()=>void
};

function BuyerOrSellerCard(props: Props) {
  return (
    <div className="">
      <div className="content">
        <div className="status-seller-buyer">
          <Status status={props.status} />
        </div>
        <div onClick={()=> props.onNavigateToDetails()} className="details-navigate-icon">
          <FaExclamation />
        </div>
        <div className="userName">{props.userName}</div>
        {props.businessName ? (
          <LigneInfoInCard
            title="Business Name"
            value={props.businessName}
            icon={<FaLocationArrow />}
          />
        ) : null}

        <LigneInfoInCard
          title="Email"
          value="Kris_Sipes@Landen.com"
          icon={<FaEnvelopeOpen />}
        />
        <LigneInfoInCard title="phone" value={props.phone} icon={<FaPhone />} />
        {props.sexe ? (
        <LigneInfoInCard
          title="Sexe"
          value={props.sexe}
          icon={<FaAddressCard />}
        />) : null}

        <LigneInfoInCard
          title="Wilaya"
          value={props.wilaya}
          icon={<FaLocationArrow />}
        />
        <div className="address-buyer-and-seller">
          <div>
          <FaMapMarked />
          </div>
          
          <span>{props.address}</span>
        </div>
      </div>
    </div>
  );
}

export default BuyerOrSellerCard;
