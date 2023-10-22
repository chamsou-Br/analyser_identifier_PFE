/* eslint-disable @typescript-eslint/no-unused-vars */

import { useEffect } from "react";
import "rsuite/dist/rsuite-no-reset-rtl.css"; // Adjust the path as needed
import "../styles/transaction.css";
import { RootState, useAppDispatch } from "../state/store";
import { useSelector } from "react-redux";
import {
  fetchTransactions,
  startLoadingTransaction,
  stopLoadingTransaction,
} from "../state/actions/transactionAction";
import {  IAdminFullTransaction, IRowsTable, ITransacionForTable, TransactionStatus } from "../helper/types";

import TableCompo from "../components/Table/Table";
import { Currency, getDeliveryTypeTitle  , getFormatDate, getFullFormatDate} from "../helper/constant";
import HeaderPage from "../components/headerPage/headerPage";
import { logout } from "../state/actions/authAction";

// eslint-disable-next-line no-empty-pattern
const TransactionScreen: React.FC = () => {
  const dispatch = useAppDispatch();
  const transactionState = useSelector(
    (state: RootState) => state.transactions
  );

  useEffect(() => {
    dispatch(startLoadingTransaction());
      dispatch(fetchTransactions());
      dispatch(stopLoadingTransaction());

    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const rows : IRowsTable[] = [
    {headerCell : "Buyer" , dataKey : "Buyer" , size : 150},
    {headerCell : "Seller" , dataKey : "Seller" , size :150 },
    {headerCell : "Product" , dataKey : "ProductName" , size :150 },
    {headerCell : "Price" , dataKey : "ProductPrice" , size : 100},
    {headerCell : "Delivery Type" , dataKey : "deliveryType" , size : 150},
    {headerCell : "Delivery Price" , dataKey : "deliveryPrice" , size : 100},
    {headerCell : "Delivery Date" , dataKey : "deliveryDate" , size : 150},
    {headerCell : "Payment Date" , dataKey : "paymentDate" , size :150 },
    {headerCell : "State" , dataKey : "state" , size : 120},
    {headerCell : "Claims" , dataKey : "claims" , size : 120},
  ]
  const getDataFromState = (): ITransacionForTable[] => {
    const newData = transactionState.transactions
      ? transactionState.transactions.map((item: IAdminFullTransaction) => ({
          uuid: item.uuid,
          deliveryDate: getFullFormatDate(item.deliveryDate.toString()), // Convert Date to string
          deliveryPlace: item.deliveryPlace,
          deliveryType: getDeliveryTypeTitle(item.deliveryType),
          deliveryPrice: item.deliveryPrice.toString() + Currency,
          Buyer: item.Buyer.email,
          Seller: item.Invitation.Seller.email,
          ProductName: item.Invitation.product,
          ProductPrice: item.Invitation.price.toString() + Currency,
          paymentDate: getFullFormatDate( item.paymentDate.toString() ),
          state: item.state,
          claims: item.Claims.length,
        }))
      : [];
    return newData;
  };


  const onRefreshData = () => {
      dispatch(fetchTransactions());
  };


  return (
    <div className="transaction-container">
 
      <div className="table-container">
      <HeaderPage

        title="Transaction List"
        descr="Information about Transaction which have reclamation !"
        />

        <TableCompo
          rows={rows}
          getDefaultData={getDataFromState}
          onRefreshData={onRefreshData}
          
        />
      </div>
    </div>
  );
};

export default TransactionScreen;
