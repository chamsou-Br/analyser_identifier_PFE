import React from "react";
import {
  FaAddressCard,
  FaEnvelopeOpen,
  FaExclamation,
  FaLocationArrow,
  FaMapMarked,
  FaPhone,
} from "react-icons/fa";
import LigneInfoInCard from "../LignInfoCard/lignInfoIncard";
import Status from "../TransactionStatus/status";
import { Client, IClientBase } from "../../helper/types";
import { useNavigate } from "react-router";
import "./client.css";
import { getTimeAgo } from "../../helper/constant";
import { IoMdTime } from "react-icons/io";

type Props = {
  client: IClientBase;
  onNavigate?: true;
};

const BuyerOrSellerCard = ({ client, onNavigate }: Props) => {
  const navigate = useNavigate();

  const onNavigateToDetails = () => {
    navigate(client.client == Client.BUYER ? "/buyer" : "/seller", {
      state: client,
    });
  };
  return (
    <div className="client-card">
      <div className="client-card-header">
        <div className="userName">{client.firstName}</div>
        <Status status={client.status} />
      </div>
      <div className="client-card-content">
        {client.createdAt ? (
          <LigneInfoInCard
            title="Creation date"
            value={getTimeAgo(client.createdAt.toString())}
            icon={<IoMdTime />}
          />
        ) : null}
        {client.businessName ? (
          <LigneInfoInCard
            title="Business Name"
            value={client.businessName}
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
          value={client.phoneNumber}
          icon={<FaPhone />}
        />
        {client.gender ? (
          <LigneInfoInCard
            title="Sexe"
            value={client.gender}
            icon={<FaAddressCard />}
          />
        ) : null}

        <LigneInfoInCard
          title="Wilaya"
          value={client.wilaya}
          icon={<FaLocationArrow />}
        />
        <div className="address-buyer-and-seller">
          <div>
            <FaMapMarked />
          </div>

          <span>{client.address ? client.address : client.location}</span>
        </div>
      </div>
      {onNavigate ? (
        <div
          onClick={() => onNavigateToDetails()}
          className="details-navigate-icon"
        >
          <FaExclamation />
        </div>
      ) : null}
    </div>
  );
};

export default BuyerOrSellerCard;
