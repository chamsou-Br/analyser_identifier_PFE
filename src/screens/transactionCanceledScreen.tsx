/* eslint-disable @typescript-eslint/no-unused-vars */

import { useEffect } from "react";
import "rsuite/dist/rsuite-no-reset-rtl.css"; // Adjust the path as needed
import "../styles/transaction.css";
import { RootState, useAppDispatch } from "../state/store";
import { useSelector } from "react-redux";
import {
    fetchCanceledTransaction,
  startLoadingTransaction,
  stopLoadingTransaction,
} from "../state/actions/transactionAction";
import {  IAdminFullTransaction, IRowsTable, ITransacionForTable } from "../helper/types";

import TableCompo from "../components/Table/Table";
import { Currency, getDeliveryTypeTitle  , getFormatDate} from "../helper/constant";
import HeaderPage from "../components/headerPage/headerPage";

// eslint-disable-next-line no-empty-pattern
const TransactionCanceledScreen: React.FC = () => {
  const dispatch = useAppDispatch();
  const transactionState = useSelector(
    (state: RootState) => state.transactions
  );

  useEffect(() => {
    dispatch(startLoadingTransaction());
    setTimeout(() => {
      dispatch(fetchCanceledTransaction());
      dispatch(stopLoadingTransaction());
    }, 1000);
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
          deliveryDate: getFormatDate(item.deliveryDate.toString().split("T")[0]), // Convert Date to string
          deliveryPlace: item.deliveryPlace,
          deliveryType: getDeliveryTypeTitle(item.deliveryType),
          deliveryPrice: item.deliveryPrice.toString() + Currency,
          Buyer: item.Buyer.email,
          Seller: item.Invitation.Seller.email,
          ProductName: item.Invitation.product,
          ProductPrice: item.Invitation.price.toString() + Currency,
          paymentDate: getFormatDate( item.paymentDate.toString().split("T")[0] ),
          state: item.state,
          claims: item.Claims.length,
        }))
      : [];
    return newData;
  };


  const onRefreshData = () => {
      dispatch(fetchCanceledTransaction());
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

export default TransactionCanceledScreen;
