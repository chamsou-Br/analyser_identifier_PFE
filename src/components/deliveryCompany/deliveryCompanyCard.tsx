import "./deliveryCompanyCard.css";
import { getTimeAgo } from "../../helper/constant";
import { FaRegClock } from "react-icons/fa";

import { IDeliveryOffice } from "../../helper/types";
import phone from "../../assets/phone.svg";

type props = {
  company: IDeliveryOffice;
  onDelete: () => void;
};

const DeliveryCompanyCard = ({ company, onDelete }: props) => {
  const onDeleteCompany = () => {
    onDelete();
  };

  if (company)
    return (
      <div className="delivery-company">
        <div className="delivery-company-header">
          <div className="date">
            <FaRegClock />
            {getTimeAgo(company.createdAt.toString())}
          </div>

          <div className="phone">
            <img src={phone} />
            <span>{company.phoneNumber}</span>
          </div>
        </div>
        <div className="delivery-company-content">
          <div className="company-name">{company.company}</div>
          <div className="email">
            <span>Email </span>
            {company.email}
          </div>
          <div onClick={onDeleteCompany} className="delete-company">
            delete
          </div>
          <div className="email-sm">{company.email}</div>
        </div>
      </div>
    );
};

export default DeliveryCompanyCard;
