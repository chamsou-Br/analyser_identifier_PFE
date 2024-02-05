import React, { useEffect, useState } from "react";
import HeaderPage from "../components/headerPage/headerPage";
import "../styles/payment.css";
import {
  Client,
  IBuyerBase,
  IFullPaymentGroup,
  ISellerBase,
  PaymentGroupStatus,
} from "../helper/types";
import {
  approvePaymentGroupsAPI,
  getPaymentGroupAPI,
} from "../helper/callsApi";
import ActionConfirmation from "../components/ActionConfirmation/ActionConfirmation";
import Alert from "../components/Alert/alert";
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
} from "../helper/constant";
import { productPriceCalculator } from "../helper/pricing";

const PaymentDetailsScreen: React.FC = () => {
  const { id } = useParams();
  const [group, setGroup] = useState<IFullPaymentGroup>();
  const [client, setClient] = useState<ISellerBase | IBuyerBase>();
  const [clientProfile, setClientProfile] = useState(Client.SELLER);
  const [modalOfApprovePaymentGroup, setModalOfApprovePaymentGroup] =
    useState(false);

  const navigate = useNavigate();

  const [alert, setAlert] = React.useState({
    isSucess: false,
    message: "",
    show: false,
  });

  const onAlert = (isSucess: boolean, message: string, show: boolean) => {
    setAlert({
      isSucess,
      message,
      show,
    });
  };

  const onCancelModalOfApprovePaymentGroup = () => {
    setModalOfApprovePaymentGroup(false);
  };
  const onOpenModalOfApprovePaymentGroup = () => {
    setModalOfApprovePaymentGroup(true);
  };

  const fetchGroup = async () => {
    const res = await getPaymentGroupAPI(id as unknown as number);
    if (res.group) {
      setGroup(res.group);
      setClient(
        res.group.Payments[0].Seller
          ? res.group.Payments[0].Seller
          : res.group.Payments[0].Buyer
      );
      setClientProfile(
        res.group.Payments[0].Seller ? Client.SELLER : Client.BUYER
      );
    } else {
      navigate("/payment");
    }
  };

  const onHandleGenerateGroups = async () => {
    setModalOfApprovePaymentGroup(false);
    const res = await approvePaymentGroupsAPI(id as unknown as number);
    if (res.group) {
      onAlert(true, "payment group is approved with success", true);
    } else {
      onAlert(false, res.error!, true);
    }
  };

  useEffect(() => {
    fetchGroup();
  }, []);

  const onNavigateToTransactionDetails = (uuid: string) => {
    navigate("/details/" + uuid);
  };
  if (group)
    return (
      <div className="payment-details-page">
        <div className="header">
          <HeaderPage title="Payment Group" descr={"Group Payment : " + id} />
          {group.state != PaymentGroupStatus.APPROVED && (
            <div
              onClick={onOpenModalOfApprovePaymentGroup}
              className="generate-new-groups"
            >
              Approve Payment
            </div>
          )}
        </div>
        <div className="body">
          <div className="left">
            <div className="title">
              <div className="label">Payment Group :</div>
              <div className="value">{group.Payments[0].type}</div>
            </div>
            <div className="content">
              <div>
              <div className="info">
                  <div className="label">Name</div>
                  <div className="value">
                    {client?.name + " " + client?.firstName}
                  </div>
                </div>
                <div className="info">
                  <div className="label">Type</div>
                  <div className="value">
                  {clientProfile}
                  </div>
                </div>
                <div className="info">
                  <div className="label">
                    <GrTransaction className="icon" />
                  </div>
                  <div className="value">
                    <span>rib</span>
                    <div className="sub-value">{client?.rib}</div>
                  </div>
                </div>
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
        <ActionConfirmation
          handleCanceled={onCancelModalOfApprovePaymentGroup}
          handleSubmit={onHandleGenerateGroups}
          isOpen={modalOfApprovePaymentGroup}
          confirmationText="Are you sure that you want to approve this payment groups !"
        />
        <Alert
          onCancelInSuccess={() => navigate("/payment")}
          alert={alert}
          onAlert={onAlert}
        />
      </div>
    );
};

export default PaymentDetailsScreen;
