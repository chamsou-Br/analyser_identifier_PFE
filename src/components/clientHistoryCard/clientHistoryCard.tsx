/* eslint-disable @typescript-eslint/no-unused-vars */
import {
  IInvitationComplete,
  IInvitationTransaction,
  IInvitationTransactionsCount,
} from "../../helper/types";
import "./clientHistoryCard.css";
import TitleCard from "../TitleCard/titleCard";
import LigneInfoInCard from "../LignInfoCard/lignInfoIncard";
import {
  FaDollarSign,
  FaEye,
  FaMapMarked,
  FaMapMarkedAlt,
  FaSearchLocation,
} from "react-icons/fa";
import {
  getDeliveryTypeTitle,
  getFormatDate,
  getFormatPrice,
} from "../../helper/constant";
import { IoMdCalendar, IoMdTime } from "react-icons/io";
import Status from "../TransactionStatus/status";
import { useNavigate } from "react-router";
import DelivryType from "../DelivryType/delivryType";
import { MdPriceChange } from "react-icons/md";

type Props = {
  history: IInvitationTransactionsCount | IInvitationTransaction | IInvitationComplete;
  onNavigate?: () => void;
};

const ClientHistoryCard = ({ history }: Props) => {
  const navigate = useNavigate();

  const handleNavigateToTransactionDetails = (uuid: string) => {
    navigate("/details/" + uuid);
  };

  const handleNavigateToInvitationDetails = () => {
    navigate("/invitation/" + history.uuid);
  };


  return (
    <div className="client-history-card">
      <TitleCard title="Invitation" />
      <div className="client-invitation-content ">
        <div
          onClick={handleNavigateToInvitationDetails}
          className="navigate-to-invitation-icon"
        >
          <FaEye />
        </div>
        <div className="title">{history.product}</div>
        <div className="descr">{history.description}</div>
        <div className="informations">
          <LigneInfoInCard
            title="Price"
            value={getFormatPrice(history.price)}
            icon={<FaDollarSign />}
          />
          <LigneInfoInCard
            title="Date"
            value={getFormatDate(history.date)}
            icon={<IoMdCalendar />}
          />
          <LigneInfoInCard
            title="Store Wilaya"
            value={history.storeWilaya}
            icon={<FaMapMarked />}
          />
          <LigneInfoInCard
            title="Store Location"
            value={history.storeLocation}
            icon={<FaSearchLocation />}
          />
          <div onClick={()=> console.log(history)} className="state-information">
            <div className="title">Delivery type</div>
            <DelivryType
              deliveryType={getDeliveryTypeTitle(history.deliveryType)}
            />
          </div>
          <LigneInfoInCard
            title="Delivery Time"
            value={history.deliveryDelayHours.toString() + " H"}
            icon={<IoMdTime />}
          />
          <LigneInfoInCard
            title="Local Delivery Price"
            value={getFormatPrice(history.localDeliveryPrice)}
            icon={<FaDollarSign />}
          />
          {(history as unknown as IInvitationTransactionsCount).TransactionsCount && (
            <LigneInfoInCard
            title="Transactions"
            value={(history as unknown as IInvitationTransactionsCount).TransactionsCount.toString()}
            icon={<MdPriceChange />}
          />            
          )}
        </div>
      </div>
      <div className="client-transactions-content ">
        {(history as IInvitationTransaction).InvitationTransactions &&
          (history as IInvitationTransaction).InvitationTransactions.map(
            (transaction, index) => (
              <div className="client-transaction-content " key={index}>
                <div
                  onClick={() =>
                    handleNavigateToTransactionDetails(transaction.uuid)
                  }
                  className="navigate-icon"
                >
                  <FaEye />
                </div>
                <div className="title">Transaction N {transaction.uuid}</div>
                <div className="informations">
                  <div className="state-information">
                    <div className="title">Outcome</div>
                    <Status status={transaction.outcome} />
                  </div>
                  <LigneInfoInCard
                    title="Delivery date"
                    value={getFormatDate(
                      transaction.deliveryDate
                    )}
                    icon={<IoMdCalendar />}
                  />

                  <LigneInfoInCard
                    title="Delivery place"
                    value={transaction.deliveryPlace}
                    icon={<FaMapMarkedAlt />}
                  />
                  <div className="state-information">
                    <div className="title">Delivery type</div>
                    <DelivryType
                      deliveryType={getDeliveryTypeTitle(
                        transaction.deliveryType
                      )}
                    />
                  </div>
                  <LigneInfoInCard
                    title="Price"
                    value={getFormatPrice(transaction.deliveryPrice)}
                    icon={<FaDollarSign />}
                  />
                  <LigneInfoInCard
                    title="payment date"
                    value={getFormatDate(
                      transaction.paymentDate
                    )}
                    icon={<IoMdCalendar />}
                  />
                  <div className="state-information">
                    <div className="title">status</div>
                    <Status status={transaction.state} />
                  </div>
                </div>
              </div>
            )
          )}
      </div>
    </div>
  );
};

export default ClientHistoryCard;
