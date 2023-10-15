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
import { Client, IClientBase } from "../helper/types";
import { useNavigate } from "react-router";
import "../styles/shared.css";

type Props = {
  client: IClientBase;
  onNavigate?: true;
};

function BuyerOrSellerCard(props: Props) {
  const navigate = useNavigate();

  const onNavigateToDetails = () => {
    navigate(props.client.client == Client.BUYER ? "/buyer" : "/seller", {
      state: props.client,
    });
  };
  return (
    <div className="client-card">
      <div className="client-card-header">
        <div className="userName">{props.client.firstName}</div>
        <Status status={props.client.status} />
      </div>
      <div className="client-card-content">
        {props.client.businessName ? (
          <LigneInfoInCard
            title="Business Name"
            value={props.client.businessName}
            icon={<FaLocationArrow />}
          />
        ) : null}

        <LigneInfoInCard
          title="Email"
          value="Kris_Sipes@Landen.com"
          icon={<FaEnvelopeOpen />}
        />
        <LigneInfoInCard
          title="phone"
          value={props.client.phoneNumber}
          icon={<FaPhone />}
        />
        {props.client.gender ? (
          <LigneInfoInCard
            title="Sexe"
            value={props.client.gender}
            icon={<FaAddressCard />}
          />
        ) : null}

        <LigneInfoInCard
          title="Wilaya"
          value={props.client.wilaya}
          icon={<FaLocationArrow />}
        />
        <div className="address-buyer-and-seller">
          <div>
            <FaMapMarked />
          </div>

          <span>
            {props.client.address
              ? props.client.address
              : props.client.location}
          </span>
        </div>
      </div>
      {props.onNavigate ? (
        <div
          onClick={() => onNavigateToDetails()}
          className="details-navigate-icon"
        >
          <FaExclamation />
        </div>
      ) : null}
    </div>
  );
}

export default BuyerOrSellerCard;
