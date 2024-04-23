import {
  FaEnvelopeOpen,
  FaLocationArrow,
  FaMapMarked,
  FaPhone,
  FaUser,
} from "react-icons/fa";
import LigneInfoInCard from "../LignInfoCard/lignInfoIncard";
import { IClientBase } from "../../helper/types";
import "./client.css";

type Props = {
  client: IClientBase;
  isDocs?: boolean;
};

const BuyerOrSellerCard = ({ client }: Props) => {
  return (
    <div className="client-card">
      <div className="client-card-content">
        {client.businessName ? (
          <LigneInfoInCard
            title="full Name"
            value={client.businessName}
            icon={<FaUser />}
          />
        ) : null}

        {client.firstName ? (
          <LigneInfoInCard
            title="Business Name"
            value={client.firstName}
            icon={<FaLocationArrow />}
          />
        ) : null}

        <LigneInfoInCard
          title="Email"
          value={client.email}
          icon={<FaEnvelopeOpen />}
        />
        <LigneInfoInCard
          title="phone"
          value={client.phoneNumber}
          icon={<FaPhone />}
        />

        <LigneInfoInCard
          title="Wilaya"
          value={client.wilaya}
          icon={<FaLocationArrow />}
        />
        <div className="address-buyer-and-seller">
          <div>
            <FaMapMarked />
          </div>
          <span>{client.address}</span>
        </div>
      </div>
    </div>
  );
};

export default BuyerOrSellerCard;
