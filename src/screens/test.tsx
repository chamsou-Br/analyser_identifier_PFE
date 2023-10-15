/* eslint-disable @typescript-eslint/no-unused-vars */

import { useEffect } from "react";
import "rsuite/dist/rsuite-no-reset-rtl.css"; // Adjust the path as needed
import "../styles/transaction.css";
import { RootState, useAppDispatch } from "../state/store";
import { useSelector } from "react-redux";
import {
  fetchTransaction,
  startLoadingTransaction,
  stopLoadingTransaction,
} from "../state/actions/transactionAction";
import { DeliveryType, IAdminFullTransaction, IRowsTable, ITransacionForTable, TransactionStatus } from "../helper/types";

import TableCompo from "../components/Table/Table";
import { Currency } from "../helper/constant";

// eslint-disable-next-line no-empty-pattern
const TestScreen: React.FC = () => {
  const dispatch = useAppDispatch();
  const transactionState = useSelector(
    (state: RootState) => state.transactions
  );

  useEffect(() => {
    dispatch(startLoadingTransaction());
    setTimeout(() => {
      dispatch(fetchTransaction());
      dispatch(stopLoadingTransaction());
    }, 1000);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const rows : IRowsTable[] = [
    {headerCell : "Buyer" , dataKey : "Buyer" , size : 250},
    {headerCell : "Seller" , dataKey : "Seller" , size :250 },
    {headerCell : "Product" , dataKey : "ProductName" , size :150 },
    {headerCell : "Price" , dataKey : "ProductPrice" , size : 100},
    {headerCell : "Delivery Type" , dataKey : "deliveryType" , size : 200},
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
          deliveryDate: item.deliveryDate.toString().split("T")[0], // Convert Date to string
          deliveryPlace: item.deliveryPlace,
          deliveryType: item.deliveryType,
          deliveryPrice: item.deliveryPrice.toString() + Currency,
          Buyer: item.Buyer.email,
          Seller: item.Invitation.Seller.email,
          ProductName: item.Invitation.product,
          ProductPrice: item.Invitation.price.toString() + Currency,
          paymentDate: item.paymentDate.toString().split("T")[0],
          state: item.state,
          claims: item.Claims.length,
        }))
      : [];
    return newData;
  };



  return (
    <div className="transaction-container">
      <div className="table-container">
        <TableCompo
          rows={rows}
          getDefaultData={getDataFromState}
          
        />
      </div>
    </div>
  );
};

export default TestScreen;
