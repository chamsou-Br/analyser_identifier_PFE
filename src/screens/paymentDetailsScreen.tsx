import React, { useEffect, useState } from "react";
import HeaderPage from "../components/headerPage/headerPage";
import "../styles/payment.css";
import {
  Client,
  IFullPaymentGroup,
} from "../helper/types";
import {
  getPaymentGroupAPI,
} from "../helper/callsApi";

import { useNavigate } from "react-router";
import { useParams } from "react-router-dom";
import "../styles/paymentDetails.css";
import {
  FaEnvelopeOpen,
  FaPhone,
  FaRegClock,
  FaSatellite,
} from "react-icons/fa";
import { GrTransaction } from "react-icons/gr";
import {
  getFormatPrice,
  getFullFormatDate,
  getShortStatusDescriptionFr,
  headerOFPaymentsExportForBuyer,
  headerOFPaymentsExportForDeliveryCompany,
  headerOFPaymentsExportForSeller,
} from "../helper/constant";
import { productPriceCalculator } from "../helper/pricing";
import { CSVLink } from "react-csv";
import { useSelector } from "react-redux";
import { RootState } from "../state/store";

const PaymentDetailsScreen: React.FC = () => {

  const { id } = useParams();
  const [group, setGroup] = useState<IFullPaymentGroup>();
  const client = useSelector((state : RootState) => state.auth).deliveryOffice
  const clientProfile = Client.DELIVERYOFFICE;

  const navigate = useNavigate();

  const fetchGroup = async () => {
    const res = await getPaymentGroupAPI(id as unknown as number);
    if (res.group) {
      setGroup(res.group);
    } else {
      navigate("/");
    }
  };

  useEffect(() => {
    fetchGroup();
  }, []);

  const onNavigateToTransactionDetails = (uuid: string) => {
    navigate("/transaction/" + uuid);
  };


  if (group)
    return (
      <div className="payment-details-page">
        <div className="header">
          <HeaderPage title={"Payment Group " + group.id} descr={group.state} />
          <div className="action">
            <div className="generate-new-groups csv-button">
              <CSVLink
                className="csv-button"
                headers={
                  clientProfile === Client.DELIVERYOFFICE
                    ? headerOFPaymentsExportForDeliveryCompany
                    : clientProfile === Client.SELLER
                    ? headerOFPaymentsExportForSeller
                    : headerOFPaymentsExportForBuyer
                }
                filename={`payment_group_${id}_${new Date()}`}
                data={group.Payments}
              >
                Export csv
              </CSVLink>
            </div>
          </div>
        </div>
        <div className="body">
          <div className="left-container">
            <div className="left">
              <div className="content">
                <div>
                  <div className="info">
                    <div className="label">Name</div>
                    <div className="value">
                      {client!.userName}
                    </div>
                  </div>
                  <div className="info">
                    <div className="label">Type</div>
                    <div className="value">{clientProfile}</div>
                  </div>
                  {client?.rib && (
                    <div className="info">
                      <div className="label">
                        <GrTransaction className="icon" />
                      </div>
                      <div className="value">
                        <div className="sub-value">{client?.rib}</div>
                      </div>
                    </div>
                  )}

                  <div className="info">
                    <div className="label">
                      <FaPhone className="icon" />
                    </div>
                    <div className="value">{client?.phoneNumber}</div>
                  </div>
                  <div className="info">
                    <div className="label">
                      <FaEnvelopeOpen className="icon" />
                    </div>
                    <div className="value">{client?.email}</div>
                  </div>
                </div>
                <div className="prices-container">
                  <div className="price total">
                    <div className="label">FullAmount :</div>
                    <div className="value">
                      {getFormatPrice(group.fullAmount)}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div className="right">
            {group.Payments.map((pay) => (
              <div key={pay.id} className="transaction-card">
                <div className="transaction-card-header">
                  <div className="date">
                    <FaRegClock />
                    {getFullFormatDate(pay.Transaction.createdAt)}
                  </div>
                  <div className="date">
                    <FaSatellite />
                    {getShortStatusDescriptionFr(pay.Transaction.state)}
                  </div>
                </div>
                <div className="transaction-card-content">
                  <div className="company-name">{pay.Transaction.uuid}</div>
                  <div className="info">
                    <span>amount due : </span>
                    {getFormatPrice(pay.fullAmount)}
                  </div>
                  <div className="info">
                    <span>Product : </span>
                    {getFormatPrice(
                      productPriceCalculator(
                        pay.Transaction.fullAmountIn,
                        pay.Transaction.deliveryPrice
                      )
                    )}
                  </div>
                  <div className="info">
                    <span>Livraison : </span>
                    {getFormatPrice(pay.Transaction.deliveryPrice)}
                  </div>
                  <div
                    onClick={() =>
                      onNavigateToTransactionDetails(pay.Transaction.uuid)
                    }
                    className="transaction-details"
                  >
                    details
                  </div>

                </div>
              </div>
            ))}
          </div>
        </div>

      </div>
    );
};

export default PaymentDetailsScreen;
