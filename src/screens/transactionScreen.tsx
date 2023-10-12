/* eslint-disable @typescript-eslint/no-unused-vars */

import { Table, Pagination } from "rsuite";
import { useState, useEffect } from "react";
const { Column, HeaderCell, Cell } = Table;
import "rsuite/dist/rsuite-no-reset-rtl.css"; // Adjust the path as needed
import "../styles/transaction.css";
import { RootState, useAppDispatch } from "../state/store";
import { useSelector } from "react-redux";
import { fetchTransaction } from "../state/actions/transactionAction";
import {
  DeliveryType,
  IAdminFullTransaction,
  TransactionStatus,
} from "../helper/types";
import { SortType } from "rsuite/esm/Table";
import { FaSearch, FaEye } from "react-icons/fa";
import { IoMdRefresh } from "react-icons/io";
import { Currency } from "../helper/constant";
import {useNavigate} from "react-router-dom"

interface TransacionTransformedData {
  uuid: string;
  deliveryDate: string;
  deliveryPlace: string;
  deliveryType: DeliveryType;
  deliveryPrice: string;
  Buyer: string;
  Seller: string;
  ProductName: string;
  ProductPrice: string;
  paymentDate: string;
  claims: number;
  state: TransactionStatus;
  // Add other properties you need
}

const styleHeaderOfTable = { background: "#acafeb", color: "#FFF" };

// eslint-disable-next-line no-empty-pattern
const TransactionScreen: React.FC = () => {
  const dispatch = useAppDispatch();
  const transactionState = useSelector(
    (state: RootState) => state.transactions
  );

  const getDataFromState = (): TransacionTransformedData[] => {
    const data = transactionState.transactions
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
    return data;
  };

  const [sortColumn, setSortColumn] = useState<string>();
  const [sortType, setSortType] = useState<SortType | undefined>();
  const [loading, setLoading] = useState<boolean>(transactionState.loading);
  const [limit, setLimit] = useState<number>(10);
  const [page, setPage] = useState<number>(1);
  const [search, setSearch] = useState<string>("");
  const [isSearch, setisSearch] = useState(false);
  const navigate = useNavigate()



  const defaultData: TransacionTransformedData[] = getDataFromState();

  const onRefreshData = () => {
    setLoading(true);
    setTimeout(() => {
      dispatch(fetchTransaction());
      setLoading(false);
      setSearch("");
      setisSearch(false);
    }, 1000);
  };

  const handleInputSearchChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setSearch(e.target.value);
  };

  const handleInputFocus = () => {
    setisSearch(false);
    setSearch("");
  };

  const handleChangeLimit = (dataKey: number) => {
    setPage(1);
    setLimit(dataKey);
  };

  const handleSortColumn = (
    sortColumn: string,
    sortType: SortType | undefined
  ) => {
    setLoading(true);
    setTimeout(() => {
      setLoading(false);
      setSortColumn(sortColumn);
      setSortType(sortType);
    }, 500);
  };

  useEffect(() => {
    setLoading(true);
    setTimeout(() => {
      dispatch(fetchTransaction());
      setLoading(false);
    }, 1000);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const getData = () => {
    const data: TransacionTransformedData[] = isSearch
      ? defaultData.filter((it) =>
          it.uuid.toLowerCase().includes(search.toLocaleLowerCase())
        )
      : defaultData;
    if (sortColumn && sortType) {
      return data
        .sort((a, b) => {
          const index = sortColumn as keyof TransacionTransformedData;
          if (sortColumn in a && sortColumn in b) {
            let x = a[index];
            let y = b[index];
            if (typeof x === "string") {
              x = x.charCodeAt(0);
            }
            if (typeof y === "string") {
              y = y.charCodeAt(0);
            }
            if (sortType === "asc") {
              return x - y;
            } else {
              return y - x;
            }
          }
          return 0;
        })
        .filter((v, i) => {
          const start = limit * (page - 1);
          const end = start + limit;
          return i >= start && i < end;
        });
    }
    return data.filter((v, i) => {
      const start = limit * (page - 1);
      const end = start + limit;
      return i >= start && i < end;
    });
  };

  const navigateToDetailsScreen = (uuid: string) => {
    navigate("/"+uuid);
  };

  return (
    <div className="transaction-container">
      <div className="table-header">
        <div className="table-header-left">
          <div className="title">Transaction List</div>
          <div className="descr">
            Information a bout Buyer , Seller , and product of transaction !
          </div>
        </div>

        <div className="table-header-right">
          <div
            onClick={() => setisSearch(true)}
            className="search-icon-container"
          >
            <FaSearch />
          </div>
          <div className="search-bar-container">
            <input
              onFocus={() => handleInputFocus()}
              value={search}
              onChange={handleInputSearchChange}
              placeholder="Search uuid"
            />
          </div>
        </div>
      </div>
      <div onClick={onRefreshData} className="refresh-icon-container">
        <IoMdRefresh />
      </div>
      <div className="table-container">
        <Table
          className="table"
          autoHeight
          virtualized
          data={getData()}
          sortColumn={sortColumn}
          sortType={sortType}
          onSortColumn={handleSortColumn}
          loading={loading}
        >
          <Column width={250} sortable resizable>
            <HeaderCell style={styleHeaderOfTable}>Buyer</HeaderCell>
            <Cell dataKey="Buyer" />
          </Column>

          <Column width={250} sortable resizable>
            <HeaderCell style={styleHeaderOfTable}>Seller</HeaderCell>
            <Cell dataKey="Seller" />
          </Column>

          <Column width={150} sortable resizable>
            <HeaderCell style={styleHeaderOfTable}>Product</HeaderCell>
            <Cell dataKey="ProductName" />
          </Column>

          <Column width={100} sortable resizable>
            <HeaderCell style={styleHeaderOfTable}>Price</HeaderCell>
            <Cell dataKey="ProductPrice" />
          </Column>

          <Column width={200} sortable resizable>
            <HeaderCell style={styleHeaderOfTable}>delivery Type</HeaderCell>
            <Cell dataKey="deliveryType" />
          </Column>

          <Column width={120} sortable resizable>
            <HeaderCell style={styleHeaderOfTable}>delivery Price</HeaderCell>
            <Cell dataKey="deliveryPrice" />
          </Column>

          <Column width={150} sortable resizable>
            <HeaderCell style={styleHeaderOfTable}>delivery Date</HeaderCell>
            <Cell dataKey="deliveryDate" />
          </Column>

          <Column width={150} sortable resizable>
            <HeaderCell style={styleHeaderOfTable}>payment Date</HeaderCell>
            <Cell dataKey="paymentDate" />
          </Column>

          <Column width={120} sortable resizable>
            <HeaderCell style={styleHeaderOfTable}>State</HeaderCell>
            <Cell dataKey="state" />
          </Column>

          <Column width={120} sortable resizable>
            <HeaderCell style={styleHeaderOfTable}>Claims</HeaderCell>
            <Cell dataKey="claims" />
          </Column>

          <Column width={80} fixed="right" align="center">
            <HeaderCell style={styleHeaderOfTable}>...</HeaderCell>
            <Cell style={{ padding: "12px" }}>
              {(rowData) => (
                <FaEye
                  onClick={() =>
                    navigateToDetailsScreen(
                      (rowData as TransacionTransformedData).uuid
                    )
                  }
                  className="icon-details"
                />
              )}
            </Cell>
          </Column>
        </Table>
        <div className="pagination-container">
          <Pagination
            prev
            next
            maxButtons={5}
            size="md"
            style={{ color: "white" }}
            layout={["total", "-", "limit", "|", "pager"]}
            total={defaultData.length}
            limitOptions={[10, 30, 50]}
            limit={limit}
            activePage={page}
            onChangePage={setPage}
            onChangeLimit={handleChangeLimit}
          />
        </div>
      </div>
    </div>
  );
};

export default TransactionScreen;
