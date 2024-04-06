import { useSelector } from "react-redux";
import { getFormatPrice, getFullFormatDate } from "../../helper/constant";
import {
  Client,
  IDeliveryOffice,
  IFullPaymentGroup,
  ISellerBase,
  PaymentGroupStatus,
  PaymentType,
} from "../../helper/types";
import "./paymentCard.css";
import { GrTransaction } from "react-icons/gr";
import { IoMdClock } from "react-icons/io";
import { RootState } from "../../state/store";
import { FaLock } from "react-icons/fa";
import { MdOutlinePending } from "react-icons/md";

type props = {
  paymentGroup: IFullPaymentGroup;
  onLock: (paymentGroup: IFullPaymentGroup) => void;
};

const PaymentGroupCard = ({ paymentGroup, onLock }: props) => {
  const auth = useSelector((state: RootState) => state.auth);

  const client = paymentGroup.Payments[0].DeliveryOffice
    ? paymentGroup.Payments[0].DeliveryOffice
    : paymentGroup.Payments[0].Seller
    ? paymentGroup.Payments[0].Seller
    : paymentGroup.Payments[0].Buyer;
  const typeClient = paymentGroup.Payments[0].DeliveryOffice
    ? "Company"
    : paymentGroup.Payments[0].Seller
    ? Client.SELLER
    : Client.BUYER;

  const onLockPaymentGroup = () => {
    onLock(paymentGroup);
  };

  if (paymentGroup)
    return (
      <div className="payment-card">
        <div className="payment-card-header">
          <div className="date">
            <IoMdClock />
            {getFullFormatDate(paymentGroup.createdAt)}
          </div>


          {paymentGroup.Payments[0].type === PaymentType.DELIVERY ? (
            <div className="date">
              {paymentGroup.state == PaymentGroupStatus.APPROVED ? (
                `Approved ( ${paymentGroup.Admin.name} )`
              ) : (
                <>
                  <MdOutlinePending />
                  <span>Pending</span>
                </>
              )}
            </div>
          ) : (
            <div className="date">
              {paymentGroup.state == PaymentGroupStatus.APPROVED ? (
                `Approved ( ${paymentGroup.Admin.name} )`
              ) : paymentGroup.state == PaymentGroupStatus.LOCKED ? (
                <>
                  <FaLock />
                  <span>
                    Locked ({" "}
                    {paymentGroup.AdminLockedId != auth.admin!.id
                      ? paymentGroup.Admin.name
                      : "You"}{" "}
                    )
                  </span>
                </>
              ) : (
                <>
                  <MdOutlinePending />
                  <span>Pending</span>
                </>
              )}
            </div>
          )}

          <div className="state">
            <GrTransaction />
            <span>{paymentGroup.Payments[0].type}</span>
          </div>
        </div>

        <div className="payment-card-content">
          <div className="client-name">
            <span>{typeClient} : </span>
            {(client as ISellerBase).firstName ||
              (client as IDeliveryOffice).userName}
          </div>
          <div className="email">{client.rib}</div>
          <div className="email">
            <span>Amount due : </span>
            {getFormatPrice(paymentGroup.fullAmount)}
          </div>
          <div
            onClick={() =>
              (paymentGroup.state == PaymentGroupStatus.LOCKED &&
                paymentGroup.AdminLockedId != auth.admin!.id &&
                auth.admin!.id !== 0 ) 
                ? null
                : onLockPaymentGroup()
            }
            className={
              paymentGroup.state == PaymentGroupStatus.LOCKED &&
              paymentGroup.AdminLockedId != auth.admin!.id &&
              auth.admin!.id !== 0
                ? "lock-payment-group disabled"
                : "lock-payment-group"
            }
          >
            {paymentGroup.state != PaymentGroupStatus.APPROVED &&
            auth.admin!.id !== 0 && paymentGroup.Payments[0].type !== PaymentType.DELIVERY
              ? "Lock"
              : "details"}
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
