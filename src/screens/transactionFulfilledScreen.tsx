/* eslint-disable @typescript-eslint/no-unused-vars */

import { useEffect } from "react";
import "../styles/transaction.css";
import { RootState, useAppDispatch } from "../state/store";
import { useSelector } from "react-redux";
import {
  fetchFulfilledTransaction,
  startLoadingTransaction,
  stopLoadingTransaction,
} from "../state/actions/transactionAction";
import {
  IAdminFullTransaction,
  IRowsTable,
  IColumnsForTable,
} from "../helper/types";

import TableCompo from "../components/Table/Table";
import {
  Currency,
  getDeliveryTypeTitle,
  getFullFormatDate,
  getTimeAgo,
} from "../helper/constant";
import HeaderPage from "../components/headerPage/headerPage";

// eslint-disable-next-line no-empty-pattern
const TransactionFulfilledScreen: React.FC = () => {
  const dispatch = useAppDispatch();
  const transactionState = useSelector(
    (state: RootState) => state.transactions
  );

  useEffect(() => {
    dispatch(startLoadingTransaction());
    setTimeout(() => {
      dispatch(fetchFulfilledTransaction());
      dispatch(stopLoadingTransaction());
    }, 1000);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const rows: IRowsTable[] = [
    { headerCell: "Buyer", dataKey: "Buyer", size: 150 },
    { headerCell: "Seller", dataKey: "Seller", size: 150 },
    { headerCell: "Product", dataKey: "ProductName", size: 150 },
    { headerCell: "Price", dataKey: "ProductPrice", size: 100 },
    { headerCell: "Update Date", dataKey: "updateDate", size: 150 },
    { headerCell: "Delivery Price", dataKey: "deliveryPrice", size: 100 },
    { headerCell: "Delivery Date", dataKey: "deliveryDate", size: 150 },
    { headerCell: "Payment Date", dataKey: "paymentDate", size: 150 },
    { headerCell: "State", dataKey: "state", size: 120 },
    { headerCell: "Claims", dataKey: "claims", size: 120 },
  ];
  const getDataFromState = (): IColumnsForTable[] => {
    const newData = transactionState.transactions
      ? transactionState.transactions.map((item: IAdminFullTransaction) => ({
          uuid: item.uuid,
          updateDate: getTimeAgo(item.updatedAt),
          deliveryDate: getFullFormatDate(item.deliveryDate), // Convert Date to string
          deliveryPlace: item.deliveryPlace,
          deliveryType: getDeliveryTypeTitle(item.deliveryType),
          deliveryPrice: item.deliveryPrice.toString() + Currency,
          Buyer: item.Buyer.email,
          Seller: item.Invitation.Seller.email,
          ProductName: item.Invitation.product,
          ProductPrice: item.Invitation.price.toString() + Currency,
          paymentDate: getFullFormatDate(item.paymentDate),
          state: item.state,
          claims: item.Claims.length,
        }))
      : [];
    return newData;
  };

  const onRefreshData = () => {
    dispatch(fetchFulfilledTransaction());
  };

  return (
    <div className="transaction-container">
      <div className="table-container">
        <HeaderPage
          title="Transaction List"
          descr="Information about Transaction which have reclamation !"
        />
        <TableCompo
          searchPlaceHolder="Search Transaction"
          rows={rows}
          getDefaultData={getDataFromState}
          onRefreshData={onRefreshData}
        />
      </div>
    </div>
  );
};

export default TransactionFulfilledScreen;
