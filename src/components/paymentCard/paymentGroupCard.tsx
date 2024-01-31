
import { getFormatPrice, getFullFormatDate } from "../../helper/constant";
import { Client, IFullPaymentGroup } from "../../helper/types";
import "./paymentCard.css"
import { GrTransaction } from "react-icons/gr";
import { IoMdClock } from "react-icons/io";

type props = {
  paymentGroup: IFullPaymentGroup;
  onLock: (id : number) => void;
};

const PaymentGroupCard = ({ paymentGroup, onLock }: props) => {

 const client = paymentGroup.Payments[0].Seller ? paymentGroup.Payments[0].Seller  : paymentGroup.Payments[0].Buyer 
 const typeClient =  paymentGroup.Payments[0].Seller ?  Client.SELLER : Client.BUYER
 const onLockPaymentGroup = () => {
    onLock(paymentGroup.id as unknown as number);
  };

  if (paymentGroup)
    return (
      <div className="payment-card">
        <div className="payment-card-header">
          <div className="date">
            <IoMdClock />
            {getFullFormatDate(paymentGroup.createdAt)} 
          </div>

          <div className="state">
            <GrTransaction />
            <span>{paymentGroup.Payments[0].type}</span>
          </div>
        </div>
        <div className="payment-card-content">
          <div className="client-name">
          <span>{typeClient} : </span>{client.firstName}</div>
          <div className="email">
            {client.rib}
          </div>
          <div className="email">
            <span>Amount : </span>
            {getFormatPrice(paymentGroup.fullAmount)}
          </div>
          <div onClick={onLockPaymentGroup} className="lock-payment-group">
            Lock
          </div>
          <div className="email-sm">
            <div>{client.rib}</div>
            <div className="password">
            {getFormatPrice(paymentGroup.fullAmount)}
          </div>
          </div>
        </div>
      </div>
    );
};

export default PaymentGroupCard;
