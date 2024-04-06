import "./deliveryCompanyCard.css";
import { getTimeAgo } from "../../helper/constant";
import { FaRegClock } from "react-icons/fa";

import { IDeliveryOffice } from "../../helper/types";
import phone from "../../assets/phone.svg";
import { useNavigate } from "react-router";
import { useSelector } from "react-redux";
import { RootState } from "../../state/store";

type props = {
  company: IDeliveryOffice;
  onDelete: () => void;
};

const DeliveryCompanyCard = ({ company, onDelete }: props) => {
  const auth = useSelector((state: RootState) => state.auth).admin;
  const onDeleteCompany = () => {
    onDelete();
  };

  const navigate = useNavigate();

  const onNavigateToDetails = () => {
    navigate("/deliveryCompany/" + company.id);
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
          <div className="email">{company.email}</div>
          <div className="email">
            <span>rib : </span>
            {company.rib}
          </div>
          <div className="action-company">
            {auth?.id === 0 && (
              <>
                <span onClick={onDeleteCompany} className="delete">
                  delete
                </span>{" "}
                /{" "}
              </>
            )}
            <span onClick={onNavigateToDetails} className="details">
              Details
            </span>
          </div>
          <div className="email-sm">
            <div>{company.email}</div>
            <div className="password">{company.rib}</div>
          </div>
        </div>
      </div>
    );
};

export default DeliveryCompanyCard;
