/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable @typescript-eslint/no-unused-vars */

import React, { useEffect, useRef, useState } from "react";
import "../styles/deliveryCompanyDetails.css";
import {
  IAdminFullTransaction,
  IRowsTable,
  IColumnsForTable,
  FilterField,
  TypeField,
  PayPartFilterValues,
  IFullPaymentGroup,
} from "../helper/types";
import TableCompo from "../components/Table/Table";
import {
  Currency,
  getFullFormatDate,
  headerOfTransactionsExport,
} from "../helper/constant";
import HeaderPage from "../components/headerPage/headerPage";
import { useNavigate } from "react-router";
import {
  exportTransactionsOfCompanyAPI,
  fetchPaymentGroupsApprovedOfDeliveryCompanyAPI,
  fetchPaymentGroupsPendingOfDeliveryCompanyAPI,
  fetchTransactionsOfCompany,
} from "../helper/callsApi";
import PaymentGroupCard from "../components/paymentCard/paymentGroupCard";
import { Loader, Pagination } from "rsuite";
import { useSelector } from "react-redux";
import { RootState } from "../state/store";
import Filter from "../components/filters/filter";
import { CSVLink } from "react-csv";

// eslint-disable-next-line no-empty-pattern
const DeliveryCompanyDetailsScreen: React.FC = () => {
  const auth = useSelector((state: RootState) => state.auth);

  const [transactionsToExports, setTransactionsToExports] = useState<{
    data: IAdminFullTransaction[];
    loading: boolean;
  }>({
    data: [],
    loading: false,
  });

  const [section, setSection] = useState(0);
  const [groupsPending, setGroupsPending] = useState<IFullPaymentGroup[]>([]);
  const [groupsApproved, setGroupsApproved] = useState<IFullPaymentGroup[]>([]);

  const id = auth.deliveryOffice ? auth.deliveryOffice.id.toString() : "";

  const [transactionsCompany, setTransactionsCompany] = useState<
    IAdminFullTransaction[]
  >([]);

  const [totalTransactionsOfCompany, setTotalTransactionsOfCompany] =
    useState(0);
  const [totalGroupsApproved, setTotalGroupsApproved] = useState(0);
  const [limit, setLimit] = useState(100);
  const [pageArchives, setPageArchives] = useState(1);
  const navigate = useNavigate();

  const onFetchDataTransactions = async (
    page: number,
    pageSize: number,
    createAfterValue?: Date | null,
    createBeforeValue?: Date | null,
    hadPaymentOfDelivery?: boolean | null
  ) => {
    const res = await fetchTransactionsOfCompany(
      id || "",
      page,
      pageSize,
      createAfterValue,
      createBeforeValue,
      hadPaymentOfDelivery
    );
    if (res.transactions) {
      setTransactionsCompany(res.transactions);
      setTotalTransactionsOfCompany(res.total);
    }
  };

  const rows: IRowsTable[] = [
    { headerCell: "Uuid", dataKey: "uuid", size: 150 },
    { headerCell: "Product", dataKey: "ProductName", size: 150 },
    { headerCell: "Price", dataKey: "ProductPrice", size: 150 },
    { headerCell: "Delivery Price", dataKey: "deliveryPrice", size: 150 },
    { headerCell: "Delivery Date", dataKey: "deliveryDate", size: 150 },
    { headerCell: "Payment Date", dataKey: "paymentDate", size: 150 },
    { headerCell: "State", dataKey: "state", size: 120 },
    { headerCell: "validation Date", dataKey: "validationDate", size: 150 },
    {
      headerCell: "Delivery Payment",
      dataKey: "hadPaymentOfDelivery",
      size: 200,
    },
  ];

  const getDataFromState = (): IColumnsForTable[] => {
    const newData = transactionsCompany.map((item: IAdminFullTransaction) => ({
      uuid: item.uuid,
      deliveryDate: getFullFormatDate(item.deliveryDate),
      deliveryPrice: item.deliveryPrice.toString() + Currency,
      ProductName: item.Invitation.product,
      ProductPrice: item.Invitation.price.toString() + Currency,
      paymentDate: getFullFormatDate(item.paymentDate),
      state: item.state,
      validationDate: getFullFormatDate(item.validationDate),
      hadPaymentOfDelivery: item.DeliveryOfficePaymentId ? "true" : "false",
    }));
    return newData;
  };

  const onRefreshData = () => {
    onFetchDataTransactions(1, limit);
  };

  const [createdAfter, setCreateAfter] = useState<Date | null>(null);
  const [createBefore, setCreateBefore] = useState<Date | null>(null);
  const [hasPaymentOfDelivery, setHasPaymentOfDelivery] = useState(null);

  const filters: FilterField[] = [
    {
      type: TypeField.date,
      label: "Créée après",
      name: "createAfter",
      placeHolder: "Date de début",
      onSet: (d) => {
        setCreateAfter(d);
      },
      value: createdAfter,
    },
    {
      type: TypeField.date,
      label: "Et avant",
      name: "createBefore",
      placeHolder: "Date de fin",
      onSet: (d) => {
        setCreateBefore(d);
      },
      value: createBefore,
    },
    {
      type: TypeField.select,
      data: [
        { label: "true", value: "true" },
        { label: "false", value: "false" },
      ],
      label: "has payment of delivery",
      name: "hasPaymentOfDelivery",
      placeHolder: "has payment of delivery",
      onSet: (d) => {
        setHasPaymentOfDelivery(d);
      },
      value: hasPaymentOfDelivery,
    },
  ];

  const onClearFilter = (pageSize: number) => {
    setCreateAfter(null);
    setCreateBefore(null);
    setHasPaymentOfDelivery(null);
    onFetchDataTransactions(1, pageSize);
  };

  const onFilter = (values: PayPartFilterValues, pageSize: number) => {
    const createAfter = values.createAfter as Date | undefined;
    const createBefore = values.createBefore as Date | undefined;
    const hadPaymentOfDelivery = values.hasPaymentOfDelivery as
      | boolean
      | undefined;
    onFetchDataTransactions(
      1,
      pageSize,
      createAfter,
      createBefore,
      hadPaymentOfDelivery
    );
  };

  const [createdAfterPaymentGroup, setCreateAfterPaymentGroup] =
    useState<Date | null>(null);

  const [createBeforePaymentGroup, setCreateBeforePaymentGroup] =
    useState<Date | null>(null);

  const filtersPaymentGroups: FilterField[] = [
    {
      type: TypeField.date,
      label: "Créée après",
      name: "createAfterPaymentGroup",
      placeHolder: "Date de début",
      onSet: (d) => {
        setCreateAfterPaymentGroup(d);
      },
      value: createdAfterPaymentGroup,
    },
    {
      type: TypeField.date,
      label: "Et avant",
      name: "createBeforePaymentGroup",
      placeHolder: "Date de fin",
      onSet: (d) => {
        setCreateBeforePaymentGroup(d);
      },
      value: createBeforePaymentGroup,
    },
  ];

  const onFilterPaymentGroups = (values: PayPartFilterValues) => {
    const createAfter = values.createAfterPaymentGroup as Date | undefined;
    const createBefore = values.createBeforePaymentGroup as Date | undefined;
    fetchGroupsApproved(1, limit, createAfter, createBefore);
  };

  const onClearFilterPaymentGroup = () => {
    setCreateAfterPaymentGroup(null);
    setCreateBeforePaymentGroup(null);
    fetchGroupsApproved(1, limit);
  };

  const onPaginateTransaction = (page: number, pageSize: number) => {
    onFetchDataTransactions(page, pageSize, createdAfter, createBefore);
  };

  const fetchGroupsPending = async () => {
    const res = await fetchPaymentGroupsPendingOfDeliveryCompanyAPI();
    if (res.groups) {
      setGroupsPending(res.groups);
    }
  };

  const fetchGroupsApproved = async (
    page: number,
    pageSize: number,
    createAfterValue?: Date | null,
    createBeforeValue?: Date | null
  ) => {
    const res = await fetchPaymentGroupsApprovedOfDeliveryCompanyAPI(
      id || "",
      page,
      pageSize,
      createAfterValue,
      createBeforeValue
    );
    if (res.groups) {
      setGroupsApproved(res.groups);
      setTotalGroupsApproved(res.total);
    }
  };

  const handleChangeLimit = (limit: number) => {
    setLimit(limit)
  };

  const handleChangePageArchives = (page: number) => {
    setPageArchives(page);
    fetchGroupsApproved(
      page,
      limit,
      createBeforePaymentGroup,
      createBeforePaymentGroup
    );
  };

  useEffect(() => {
    onFetchDataTransactions(1, limit, createdAfter, createBefore);
    fetchGroupsPending();
    fetchGroupsApproved(
      1,
      limit,
      createdAfterPaymentGroup,
      createBeforePaymentGroup
    );
  }, []);

  const exportDataCsv = async () => {
    setTransactionsToExports({ ...transactionsToExports, loading: true });
    const res = await exportTransactionsOfCompanyAPI(
      id || "",
      createdAfter,
      createBefore,
      hasPaymentOfDelivery
    );
    if (res.transactions) {
      setTransactionsToExports({
        loading: true,
        data: res.transactions,
      });
      setTimeout(() => {
        csvLink?.current?.link.click();
        setTransactionsToExports({
          loading: false,
          data: res.transactions,
        });
      }, 2000);
    } else {
      setTransactionsToExports({
        data: [],
        loading: false,
      });
    }
  };

  const csvLink = useRef<
    CSVLink & HTMLAnchorElement & { link: HTMLAnchorElement }
  >(null);

  return (
    <div className="transaction-of-company-container">
      <div className="header">
        <HeaderPage
          title={"Delivery company : " + auth.deliveryOffice?.company}
          descr={
            section === 0
              ? "All transaction delivered by this company"
              : "All groups to make the payment"
          }
        />
      </div>
      <div className="sections">
        <div
          onClick={() => setSection(0)}
          className={section === 0 ? "section active" : "section"}
        >
          Transaction
        </div>
        <div
          onClick={() => setSection(1)}
          className={section === 1 ? "section active" : "section"}
        >
          Payments
        </div>
        <div
          onClick={() => setSection(2)}
          className={section === 2 ? "section active" : "section"}
        >
          Archives
        </div>
      </div>
      {section === 0 && (
        <>
          <CSVLink
            ref={csvLink}
            className="csv-button"
            headers={headerOfTransactionsExport}
            filename={`delivery_company_${id}_${new Date()}`}
            data={transactionsToExports.data}
          ></CSVLink>

          <div onClick={() => exportDataCsv()} className="export-csv">
            {transactionsToExports.loading ? <Loader /> : "Export csv"}
          </div>
          <TableCompo
            isSearch={false}
            searchPlaceHolder="Search Transaction"
            rows={rows}
            getDefaultData={getDataFromState}
            onRefreshData={onRefreshData}
            pageSize={limit}
            total={totalTransactionsOfCompany}
            onPaginate={onPaginateTransaction}
            isFilter
            fields={filters}
            onClear={onClearFilter}
            onFilter={onFilter}
            onViewable={(rowData: IColumnsForTable) =>
              navigate("/transaction/" + rowData.uuid!)
            }
            isRefresh={false}
          />
        </>
      )}
      {section == 1 && (
        <>
          <div className="list">
            {groupsPending.map((item) => (
              <div className="admin" key={item.id}>
                <PaymentGroupCard paymentGroup={item} />
              </div>
            ))}
            {groupsPending.length == 0 && (
              <div className="empty">
                There is no pending payment to display ...
              </div>
            )}
          </div>
        </>
      )}
      {section == 2 && (
        <>
          <Filter
            fields={filtersPaymentGroups}
            onFilter={onFilterPaymentGroups}
            onClear={onClearFilterPaymentGroup}
          />
          <div className="list">
            {groupsApproved.map((item) => (
              <div className="admin" key={item.id}>
                <PaymentGroupCard paymentGroup={item} />
              </div>
            ))}

            {groupsApproved.length == 0 && (
              <div className="empty">
                There is no approved payment to display ...
              </div>
            )}
            <Pagination
              prev
              next
              maxButtons={5}
              size="md"
              style={{ color: "#3782ec88", maxWidth: 1500 }}
              layout={["total", "-", "limit", "|", "pager"]}
              total={totalGroupsApproved}
              limitOptions={[limit]}
              limit={limit}
              pages={
                totalGroupsApproved / limit +
                (totalGroupsApproved % limit === 0 ? 0 : 1)
              }
              activePage={pageArchives}
              onChangePage={handleChangePageArchives}
              onChangeLimit={handleChangeLimit}
              className="pagination-payment-approved "
            />
          </div>
        </>
      )}
    </div>
  );
};
export default DeliveryCompanyDetailsScreen;
