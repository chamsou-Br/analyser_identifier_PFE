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
            {getTimeAgo(company.createdAt)}
          </div>

          <div className="phone">
            <img src={phone} />
            <span>{company.phoneNumber}</span>
          </div>
        </div>
        <div className="delivery-company-content">
          <div className="company-name">{company.company}</div>
          <div className="email">
            {company.email}
          </div>
          <div className="email">
            <span>password </span>
            {company.password}
          </div>
          <div onClick={onDeleteCompany} className="delete-company">
            delete
          </div>
          <div className="email-sm">
            <div>{company.email}</div>
            <div className="password">
            {company.password}
          </div>
          </div>
        </div>
      </div>
    );
};

export default DeliveryCompanyCard;
