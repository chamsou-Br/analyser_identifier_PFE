/* eslint-disable @typescript-eslint/no-unused-vars */
import { Table, Pagination } from "rsuite";
import { useEffect, useState } from "react";
const { Column, HeaderCell, Cell } = Table;
import { SortType } from "rsuite/esm/Table";
import { useNavigate } from "react-router-dom";
import {
  IRowsTable,
  IColumnsForTable,
  FilterField,
  PayPartFilterValues,
} from "../../helper/types";
import { FaEye } from "react-icons/fa";
import HeaderTable from "../headerTable/headerTable";
import "./table.css";
import Status from "../TransactionStatus/status";
import { tableLimit } from "../../helper/constant";
import DelivryType from "../DelivryType/delivryType";
import Filter from "../filters/filter";

type props = {
  getDefaultData: () => IColumnsForTable[];
  onRefreshData: () => void;
  rows: IRowsTable[];
  isSearch?: boolean;
  onNavigateSeller?: (email: string) => void;
  searchPlaceHolder?: string;
  pageSize?: number;
  total?: number;
  onPaginate?: (page: number, pageSize: number) => void;
  isFilter?: boolean;
  fields?: Array<FilterField>;
  onFilter?: (values: PayPartFilterValues, pageSize: number) => void;
  onClear?: (pageSize: number) => void;
  isRefresh?: boolean;
  isViewable? : boolean;
  onViewable? : (rowData : IColumnsForTable) => void
};

const styleHeaderOfTable = { background: "#FFF", color: "#000" };

const TableCompo = ({
  getDefaultData,
  onRefreshData,
  rows,
  onNavigateSeller,
  isSearch = true,
  searchPlaceHolder,
  pageSize,
  total,
  onPaginate,
  isFilter,
  fields,
  onClear,
  onFilter,
  isRefresh = true,
  isViewable = true,
  onViewable
}: props) => {
  const [sortColumn, setSortColumn] = useState<string>();
  const [sortType, setSortType] = useState<SortType | undefined>();
  const [limit, setLimit] = useState<number>(
    pageSize
      ? pageSize
      : parseInt(localStorage.getItem(tableLimit) || "0") || 10
  );
  const [page, setPage] = useState<number>(1);
  const [search, setSearch] = useState<string>("");
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  const handleChangeLimit = (dataKey: number) => {
    setPage(1);
    localStorage.setItem(tableLimit, dataKey.toString());
    setLimit(dataKey);
  };

  const handleChangePage = (page: number) => {
    setPage(page);
    if (onPaginate) {
      setLoading(true);
      setTimeout(() => {
        onPaginate(page, limit);
        setLoading(false);
      }, 1000);
    }
  };

  useEffect(() => {
    setTimeout(() => {
      setLoading(false);
    }, 1000);
  });

  const handleSortColumn = (
    sortColumn: string,
    sortType: SortType | undefined
  ) => {
    setLoading(true);
    setTimeout(() => {
      setSortColumn(sortColumn);
      setSortType(sortType);
      setLoading(false);
    }, 500);
  };

  const defaultData: IColumnsForTable[] = getDefaultData();

  const getData = () => {
    const data = defaultData;
    if (sortColumn && sortType) {
      const newData = data.sort((a, b) => {
        const index = sortColumn as keyof IColumnsForTable;
        if (sortColumn in a && sortColumn in b) {
          let x = a[index];
          let y = b[index];
          if (typeof x === "string") {
            x = x.charCodeAt(0);
          }
          if (typeof y === "string") {
            y = y.charCodeAt(0);
          }
          if (x != undefined && y != undefined) {
            if (sortType === "asc") {
              return x - y;
            } else {
              return y - x;
            }
          }
          return 0;
        }
        return 0;
      });
      if (pageSize && total) return newData;
      else {
        return newData.filter((v, i) => {
          const start = limit * (page - 1);
          const end = start + limit;
          return i >= start && i < end;
        });
      }
    }
    if (pageSize && total) return data;
    return data.filter((v, i) => {
      const start = limit * (page - 1);
      const end = start + limit;
      return i >= start && i < end;
    });
  };

  const handleInputSearchChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setSearch(e.target.value);
  };

  const handleInputFocus = () => {
    setSearch("");
  };
  const handleSearch = () => {
    navigate("/details/" + search);
  };
  const onRefreshDataHandler = () => {
    setLoading(true);
    setTimeout(() => {
      onRefreshData();
      setLoading(false);
      setPage(1);
      setSearch("");
    }, 1000);
  };

  const onHandlerFilter = (values: PayPartFilterValues) => {
    setPage(1);
    onFilter ? onFilter(values, limit) : null;
  };

  const onHandleClearFilter = () => {
    onClear ? onClear(limit) : null;
  };

  return (
    <div className="table-container">
      <HeaderTable
        searchPlaceHolder={searchPlaceHolder}
        isSearch={isSearch}
        isRefresh={isRefresh}
        value={search}
        title="Transaction List"
        descr="Information about Transaction which have reclamation !"
        handleChangeInput={handleInputSearchChange}
        handleFocusInput={handleInputFocus}
        handleSearch={handleSearch}
        handleRefresh={onRefreshDataHandler}
      />
      {isFilter && fields && onFilter && onClear && (
        <Filter
          fields={fields}
          onFilter={onHandlerFilter}
          onClear={onHandleClearFilter}
        />
      )}
      <Table
        className="table"
        autoHeight
        style={{ fontFamily: "Mukta", maxWidth: 1400 }}
        virtualized
        data={getData()}
        sortColumn={sortColumn}
        sortType={sortType}
        onSortColumn={handleSortColumn}
        loading={loading}
      >
        {rows.map((row, i) => (
          <Column key={i} width={row.size} sortable resizable>
            <HeaderCell style={styleHeaderOfTable}>{row.headerCell}</HeaderCell>
            {row.headerCell == "State" ? (
              <Cell>
                {(dataRow) => (
                  <Status status={(dataRow as IColumnsForTable).state || ""} />
                )}
              </Cell>
            ) : row.headerCell == "Delivery Type" ? (
              <Cell>
                {(dataRow) => (
                  <DelivryType
                    deliveryType={(dataRow as IColumnsForTable).deliveryType}
                  />
                )}
              </Cell>
            ) : (
              <Cell dataKey={row.dataKey} />
            )}
          </Column>
        ))}

        <Column width={80} fixed="right" align="center">
          <HeaderCell style={styleHeaderOfTable}>...</HeaderCell>
          <Cell style={{ padding: "12px" }}>
            {(rowData) =>
              isViewable ? (
                <FaEye
                  onClick={() =>
                    onViewable ? onViewable(rowData as IColumnsForTable) : null
                  }
                  className="icon-details"
                />
              ) : null
            }
          </Cell>
        </Column>
      </Table>
      <div className="pagination-container">
        {pageSize && total ? (
          <Pagination
            prev
            next
            maxButtons={5}
            size="md"
            style={{ color: "#3782ec88", maxWidth: 1500 }}
            layout={["total", "-", "limit", "|", "pager"]}
            total={total}
            limitOptions={[pageSize]}
            limit={limit}
            pages={total / limit + (total % limit === 0 ? 0 : 1)}
            activePage={page}
            onChangePage={(p) => handleChangePage(p)}
            onChangeLimit={handleChangeLimit}
          />
        ) : (
          <Pagination
            prev
            next
            maxButtons={5}
            size="md"
            style={{ color: "#3782ec88", maxWidth: 1500 }}
            layout={["total", "-", "limit", "|", "pager"]}
            total={defaultData.length}
            limitOptions={[10, 30, 50, 100]}
            limit={limit}
            activePage={page}
            onChangePage={setPage}
            onChangeLimit={handleChangeLimit}
          />
        )}
      </div>
    </div>
  );
};

export default TableCompo;
