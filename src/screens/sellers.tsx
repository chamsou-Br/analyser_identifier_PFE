/* eslint-disable @typescript-eslint/no-unused-vars */

import { useEffect, useState } from "react";
import "rsuite/dist/rsuite-no-reset-rtl.css"; // Adjust the path as needed
import "../styles/transaction.css";
import { RootState, useAppDispatch } from "../state/store";
import { useSelector } from "react-redux";
import {
    fetchFulfilledTransaction,

} from "../state/actions/transactionAction";
import {   IRowsTable, ISellerWithRibRequests, IColumnsForTable, ISeller, Client } from "../helper/types";

import TableCompo from "../components/Table/Table";
import HeaderPage from "../components/headerPage/headerPage";
import { getAllRibRequestsAPI } from "../helper/callsApi";
import { useNavigate } from "react-router";

// eslint-disable-next-line no-empty-pattern
const SellersScreen: React.FC = () => {
  const dispatch = useAppDispatch();
  const navigate = useNavigate()
  const [sellers,setSellers] = useState<ISellerWithRibRequests[]>([])

  const fetchData = async () => {
    const res = await getAllRibRequestsAPI()
    if (!res.error) {
        setSellers(res.sellers!)
    }
  }
  useEffect(() => {
    fetchData()
  }, []);

  const rows : IRowsTable[] = [
    {headerCell : "Name" , dataKey : "name" , size : 200},
    {headerCell : "First Name" , dataKey : "firstName" , size :200 },
    {headerCell : "Email" , dataKey : "email" , size :250 },
    {headerCell : "Phone Number" , dataKey : "phoneNumber" , size : 150},
    {headerCell : "Business Name" , dataKey : "businessName" , size : 150},
    {headerCell : "Rib" , dataKey : "rib" , size : 250},
    {headerCell : "Requests" , dataKey : "ribRequest" , size : 120},
  ]
  const getDataFromState = (): IColumnsForTable[] => {
    const newData = sellers 
      ? sellers.map((item: ISellerWithRibRequests) => ({
          name: item.name,
          firstName: item.firstName,
          email: item.email,
          phoneNumber: item.phoneNumber,
          businessName: item.businessName,
          ribRequest: item.ChangeRibRequests.length,
          rib: item.rib,
      } as unknown as IColumnsForTable))
      : [];
    return newData;
  };

  const onRefreshData = () => {
      fetchData()
  };

  const onNavigateToSeller = (email : string ) => {
    const seller = sellers.filter(it => it.email == email)[0]
    const client = {
      ...seller,
      client: Client.SELLER,
      address: null,
      birthDay: null,
      businessName:
        seller.businessName,
      description: null,
      email: seller.email,
      firstName: seller.firstName,
      gender: null,
      location: seller.location,
      phoneNumber: seller.phoneNumber,
      status: seller.status,
      wilaya: seller.wilaya,
      createdAt: seller.createdAt,
      rib : seller.rib,
      official : seller.official
    }
    navigate("/seller", {
      state: client,
    });
  }


  return (
    <div className="transaction-container">
      <div className="table-container">
      <HeaderPage

        title="Sellers"
        descr="Request of Sellers to change the RIB"
        />

        <TableCompo
        onNavigateSeller={onNavigateToSeller}
        isSearch={false}
          rows={rows}
          getDefaultData={getDataFromState}
          onRefreshData={onRefreshData}
          
        />
      </div>
    </div>
  );
};

export default SellersScreen;
