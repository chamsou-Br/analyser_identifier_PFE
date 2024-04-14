import React, { useEffect, useState } from "react";
import HeaderPage from "../components/headerPage/headerPage";
import "../styles/payment.css";
import {
  Client,
  IBuyerBase,
  IDeliveryOffice,
  IFullPaymentGroup,
  ISellerBase,
  PaymentGroupStatus,
  PaymentType,
} from "../helper/types";
import {
  approvePaymentGroupsAPI,
  getPaymentGroupAPI,
  lockPaymentGroupsAPI,
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
  headerOFPaymentsExportForBuyer,
  headerOFPaymentsExportForDeliveryCompany,
  headerOFPaymentsExportForSeller,
} from "../helper/constant";
import { productPriceCalculator } from "../helper/pricing";
import JsonFormatter from "react-json-formatter";
import { useSelector } from "react-redux";
import { RootState } from "../state/store";
import { CSVLink } from "react-csv";

const PaymentDetailsScreen: React.FC = () => {
  const auth = useSelector((state: RootState) => state.auth);

  const { id } = useParams();
  const [group, setGroup] = useState<IFullPaymentGroup>();
  const [client, setClient] = useState<
    ISellerBase | IBuyerBase | IDeliveryOffice
  >();
  const [clientProfile, setClientProfile] = useState(Client.SELLER);

  const [modalOfApprovePaymentGroup, setModalOfApprovePaymentGroup] =
    useState(false);

  const [modalOfLockPaymentGroup, setModalOfLockPaymentGroup] = useState(false);

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

  const onCancelModalOfLockPaymentGroup = () => {
    setModalOfLockPaymentGroup(false);
  };
  const onOpenModalOfLockPaymentGroup = () => {
    setModalOfLockPaymentGroup(true);
  };

  const fetchGroup = async () => {
    const res = await getPaymentGroupAPI(id as unknown as number);
    if (res.group) {
      setGroup(res.group);
      setClient(
        res.group.Payments[0].DeliveryOffice
          ? res.group.Payments[0].DeliveryOffice
          : res.group.Payments[0].Seller
          ? res.group.Payments[0].Seller
          : res.group.Payments[0].Buyer
      );
      setClientProfile(
        res.group.Payments[0].DeliveryOffice
          ? Client.DELIVERYOFFICE
          : res.group.Payments[0].Seller
          ? Client.SELLER
          : Client.BUYER
      );
    } else {
      navigate("/payment");
    }
  };

  const DateToApproveDeliveryPayment = new Date();
  DateToApproveDeliveryPayment.setDate(
    DateToApproveDeliveryPayment.getDate() - 1
  );

  const onHandleApprovePaymentGroup = async () => {
    setModalOfApprovePaymentGroup(false);
    if (
      group?.Payments[0].type === PaymentType.DELIVERY &&
      new Date(group?.createdAt) > DateToApproveDeliveryPayment
    ) {
      onAlert(
        false,
        "This payment cannot be approved until five days have passed after its creation",
        true
      );
      return;
    }
    const res = await approvePaymentGroupsAPI(id as unknown as number);
    if (res.group) {
      onAlert(true, "payment group is approved with success", true);
      setGroup({ ...group!, state: PaymentGroupStatus.APPROVED });
    } else {
      onAlert(false, res.error!, true);
    }
  };

  const onHandleLockPaymentGroup = async () => {
    setModalOfLockPaymentGroup(false);
    const res = await lockPaymentGroupsAPI(group?.id as unknown as number);
    if (res.group) {
      onAlert(true, "payment group is locked with success", true);
      setGroup({ ...group!, state: PaymentGroupStatus.LOCKED });
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
          <HeaderPage title="Payment Group" descr={""} />
          <div className="action">
            {group.state === PaymentGroupStatus.LOCKED &&
              auth.admin?.id !== 0 && (
                <div
                  onClick={onOpenModalOfApprovePaymentGroup}
                  className="generate-new-groups"
                >
                  Approve Payment
                </div>
              )}
            {group.state === PaymentGroupStatus.PENDING &&
              group.Payments[0].type === PaymentType.DELIVERY && (
                <div
                  onClick={onOpenModalOfLockPaymentGroup}
                  className="generate-new-groups"
                >
                  Lock Payment
                </div>
              )}
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
              <div className="title">
                <div className="label">Payment Group :</div>
                <div className="value">{group.Payments[0].type}</div>
              </div>
              <div className="content">
                <div>
                  <div className="info">
                    <div className="label">Name</div>
                    <div className="value">
                      {clientProfile != Client.DELIVERYOFFICE
                        ? (client as unknown as ISellerBase)?.name +
                          " " +
                          (client as unknown as ISellerBase)?.firstName
                        : (client as unknown as IDeliveryOffice).userName}
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
            <div className="left">
              <JsonFormatter
                json={{
                  rib: client?.rib || "",
                  firstName:
                    clientProfile != Client.DELIVERYOFFICE
                      ? (client as unknown as ISellerBase)?.name +
                        " " +
                        (client as unknown as ISellerBase)?.firstName
                      : (client as unknown as IDeliveryOffice).userName,
                  amount: group.fullAmount,
                  label: group.id,
                }}
                tabWith={6}
                jsonStyle={{
                  propertyStyle: { color: "#151B26" },
                  stringStyle: { color: "green" },
                  numberStyle: { color: "green" },
                }}
              />
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
          handleSubmit={onHandleApprovePaymentGroup}
          isOpen={modalOfApprovePaymentGroup}
          confirmationText="Are you sure that you want to approve this payment groups !"
        />
        <ActionConfirmation
          handleCanceled={onCancelModalOfLockPaymentGroup}
          handleSubmit={onHandleLockPaymentGroup}
          isOpen={modalOfLockPaymentGroup}
          confirmationText="Are you sure that you want to Lock this payment groups !"
        />
        <Alert
          onCancelInSuccess={() =>
            group.state === PaymentGroupStatus.APPROVED
              ? group.Payments[0].type === PaymentType.DELIVERY
                ? navigate(
                    "/deliveryCompany/" + group.Payments[0].DeliveryOffice.id
                  )
                : navigate("/payment")
              : null
          }
          alert={alert}
          onAlert={onAlert}
        />
      </div>
    );
};

export default PaymentDetailsScreen;
