import { useSelector } from "react-redux";
import {
  formatRIB,
  getFormatPrice,
  getFullFormatDate,
} from "../../helper/constant";
import {
  Client,
  IFullPaymentGroup,

  PaymentGroupStatus,

} from "../../helper/types";
import "./paymentCard.css";
import { GrTransaction } from "react-icons/gr";
import { IoMdClock } from "react-icons/io";
import { RootState } from "../../state/store";

import { MdOutlinePending } from "react-icons/md";
import { useNavigate } from "react-router";

type props = {
  paymentGroup: IFullPaymentGroup;
};

const PaymentGroupCard = ({ paymentGroup }: props) => {
  
  const client = useSelector((state: RootState) => state.auth).deliveryOffice;

  const typeClient = Client.DELIVERYOFFICE;

  const navigate = useNavigate()

  const onNavigateToPayment = () => {
    navigate("/payment/"+paymentGroup.id)
  };

  if (paymentGroup)
    return (
      <div className="payment-card">
        <div className="payment-card-header">
          <div className="date">
            <IoMdClock />
            {getFullFormatDate(paymentGroup.createdAt)}
          </div>
          <div className="date">
            {paymentGroup.state == PaymentGroupStatus.APPROVED ? (
              "Approved"
            ) : (
              <>
                <MdOutlinePending />
                <span>Pending</span>
              </>
            )}
          </div>
          <div className="state">
            <GrTransaction />
            <span>{paymentGroup.Payments[0].type}</span>
          </div>
        </div>

        <div className="payment-card-content">
          {typeClient !== Client.DELIVERYOFFICE ? (
            <div className="client-name">
              <span>{typeClient} : </span>
              {client!.userName}
            </div>
          ) : (
            <div className="client-name">
              <span>id : </span>
              {paymentGroup.id}
            </div>
          )}

          <div className="info">
            <span>Rib : </span>
            {formatRIB(client!.rib)}
          </div>
          <div className="info price">
            <span>Amount due : </span>
            {getFormatPrice(paymentGroup.fullAmount)}
          </div>
          <div onClick={onNavigateToPayment} className="lock-payment-group">
            details
          </div>
          <div className="info-sm">
            <div>{client!.rib}</div>
            <div className="password">
              {getFormatPrice(paymentGroup.fullAmount)}
            </div>
          </div>
        </div>
      </div>
    );
};

export default PaymentGroupCard;
