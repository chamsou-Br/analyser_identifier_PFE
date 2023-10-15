import { IInvitationTransaction } from "../../helper/types";
import "./clientHistoryCard.css";
import TitleCard from "../TitleCard/titleCard";
import LigneInfoInCard from "../LignInfoCard/lignInfoIncard";
import {
  FaDollarSign,
  FaEye,
  FaMapMarked,
  FaMapMarkedAlt,
  FaSearchLocation,
  FaTruck,
} from "react-icons/fa";
import {
  getDeliveryTypeTitle,
  getFormatDate,
  getFormatPrice,
} from "../../helper/constant";
import { IoMdCalendar, IoMdTime } from "react-icons/io";
import Status from "../TransactionStatus/status";
import { useNavigate } from "react-router";

type Props = {
  history: IInvitationTransaction;
};


function ClientHistoryCard(props: Props) {

    const navigate = useNavigate()

    const  handleNavigateToTransactionDetails = (uuid : string) => {
        navigate("/details/"+uuid)
    }

  return (
    <div className="client-history-card">
      <TitleCard title="Invitation" />
      <div className="client-invitation-content ">
        <div className="title">{props.history.product}</div>
        <div className="descr">{props.history.description}</div>
        <div className="informations">
          <LigneInfoInCard
            title="Price"
            value={getFormatPrice(props.history.price)}
            icon={<FaDollarSign />}
          />
          <LigneInfoInCard
            title="Date"
            value={getFormatDate(props.history.date.toString().split("T")[0])}
            icon={<IoMdCalendar />}
          />
          <LigneInfoInCard
            title="Store Wilaya"
            value={props.history.storeWilaya}
            icon={<FaMapMarked />}
          />
          <LigneInfoInCard
            title="Store Location"
            value={props.history.storeLocation}
            icon={<FaSearchLocation />}
          />
          <LigneInfoInCard
            title="Delivery Type"
            value={getDeliveryTypeTitle(props.history.deliveryType)}
            icon={<FaTruck />}
          />
          <LigneInfoInCard
            title="Delivery Time"
            value={props.history.deliveryDelayHours.toString() + " H"}
            icon={<IoMdTime />}
          />
          <LigneInfoInCard
            title="Local Delivery Price"
            value={getFormatPrice(props.history.localDeliveryPrice)}
            icon={<FaDollarSign />}
          />
        </div>
      </div>
      <div className="client-transactions-content ">

        {props.history.InvitationTransactions.map((transaction, index) => (
          <div className="client-transaction-content " key={index}>
            <div onClick={()=>handleNavigateToTransactionDetails(transaction.uuid)} className="navigate-icon" >
                <FaEye  />
            </div>
            <div className="title">Transaction N {transaction.uuid}</div>
            <div className="informations">
              <div className="state-information">
                <div className="title">Oucom</div>
                <Status status={transaction.outcome} />
              </div>
              <LigneInfoInCard
                title="Delivry date"
                value={getFormatDate(
                  transaction.deliveryDate.toString().split("T")[0]
                )}
                icon={<IoMdCalendar />}
              />
              <LigneInfoInCard
                title="Delivry type"
                value={getDeliveryTypeTitle(transaction.deliveryType)}
                icon={<FaTruck />}
              />
              <LigneInfoInCard
                title="Delivry place"
                value={transaction.deliveryPlace}
                icon={<FaMapMarkedAlt />}
              />
              <LigneInfoInCard
                title="Price"
                value={getFormatPrice(transaction.deliveryPrice)}
                icon={<FaDollarSign />}
              />
              <LigneInfoInCard
                title="payment date"
                value={getFormatDate(
                  transaction.paymentDate.toString().split("T")[0]
                )}
                icon={<IoMdCalendar />}
              />
              <div className="state-information">
                <div className="title">status</div>
                <Status status={transaction.state} />
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default ClientHistoryCard;
