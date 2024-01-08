import { useState } from "react";
import {
  FaAddressCard,
  FaBehance,
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
import Garage from "../../assets/Garage.svg";
import { Button, Modal } from "rsuite";

type Props = {
  client: IClientBase;
  onNavigate?: true;
  isDocs? : boolean;
};

const BuyerOrSellerCard = ({ client, onNavigate  }: Props) => {
  const navigate = useNavigate();

  const onNavigateToDetails = () => {
    navigate(client.client == Client.BUYER ? "/buyer" : "/seller", {
      state: client,
    });
  };

  const [modalOfOfficialDocs, setModalOfOfficialDocs] = useState(false);
  const [docs, setDocs] = useState({
    type: 0,
    images: client.official?.identity_urls,
  });
  const onOpenModalOfOfficialDocs = () => {
    setModalOfOfficialDocs(true);
  };
  const onCloseModalOfOfficialDocs = () => {
    setModalOfOfficialDocs(false);
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
            value={getTimeAgo(client.createdAt)}
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
          value={client.email}
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
        {client.rib ? (
          <LigneInfoInCard
            title="Rib"
            value={client.rib}
            icon={<FaBehance />}
          />
        ) : null}
        <div className="address-buyer-and-seller">
          <div>
            <FaMapMarked />
          </div>

          <span>{client.address ? client.address : client.location}</span>
        </div>
        {client.official && (
          <div onClick={onOpenModalOfOfficialDocs} className="official-docs">
            <img src={Garage} />
              <div className="need-review">
                See Documents
              </div>
          </div>
        ) }
        <div className="config"></div>
      </div>
      {onNavigate ? (
        <div
          onClick={() => onNavigateToDetails()}
          className="details-navigate-icon"
        >
          <FaExclamation />
        </div>
      ) : null}
      {client.official && (
        <Modal
        open={modalOfOfficialDocs}
        onClose={onCloseModalOfOfficialDocs}
        size="full"
        className="seller-docs"
      >
        <div className="docs-header">
          {" "}
          <span
            onClick={() => {
              setDocs({
                type: 0,
                images: client.official?.identity_urls,
              });
            }}
            className={docs.type == 0 ? "active" : ""}
          >
            {" "}
            Identity Docs
          </span>{" "}
          <span
            onClick={() => {
              setDocs({
                type: 1,
                images: client.official?.rib_urls,
              });
            }}
            className={docs.type == 1 ? "active" : ""}
          >
            Rib Docs
          </span>
        </div>
        <Modal.Body className="content">
          <div className="docs-gallery">
            <div className="img-doc-container" >
              {docs.images!.map((img, i) => (
                <img key={i} src={img} className="img-doc" />
              ))}
            </div>
          </div>
        </Modal.Body>
        <Modal.Footer>
          <Button
            className="button"
            onClick={onCloseModalOfOfficialDocs}
            appearance="subtle"
          >
            Cancel
          </Button>
        </Modal.Footer>
      </Modal>
      )}
      
    </div>
  );
};

export default BuyerOrSellerCard;
