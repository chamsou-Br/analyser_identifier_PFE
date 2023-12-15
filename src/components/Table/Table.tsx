import { Table, Pagination } from "rsuite";
import { useEffect, useState } from "react";
const { Column, HeaderCell, Cell } = Table;
import "rsuite/dist/rsuite-no-reset-rtl.css";
import { SortType } from "rsuite/esm/Table";
import { useNavigate } from "react-router-dom";
import { IRowsTable, ITransacionForTable } from "../../helper/types";
import { FaEye } from "react-icons/fa";
import HeaderTable from "../headerTable/headerTable";
import "./table.css";
import Status from "../TransactionStatus/status";
import { tableLimit } from "../../helper/constant";
import DelivryType from "../DelivryType/delivryType";

type props = {
  getDefaultData: () => ITransacionForTable[];
  onRefreshData: () => void;
  rows: IRowsTable[];
};

const styleHeaderOfTable = { background: "#FFF", color: "#000" };

const TableCompo = ({getDefaultData , onRefreshData , rows}: props) => {

  const [sortColumn, setSortColumn] = useState<string>();
  const [sortType, setSortType] = useState<SortType | undefined>();
  const [limit, setLimit] = useState<number>(
    parseInt(localStorage.getItem(tableLimit) || "0") || 10
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

  const navigateToDetailsScreen = (uuid: string) => {
    navigate("/details/" + uuid);
  };

  const defaultData: ITransacionForTable[] = getDefaultData();

  const getData = () => {
    const data = defaultData;
    if (sortColumn && sortType) {
      return data
        .sort((a, b) => {
          const index = sortColumn as keyof ITransacionForTable;
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
      setSearch("");
    }, 1000);
  };

  return (
    <div className="table-container">
      <HeaderTable
        value={search}
        title="Transaction List"
        descr="Information about Transaction which have reclamation !"
        handleChangeInput={handleInputSearchChange}
        handleFocusInput={handleInputFocus}
        handleSearch={handleSearch}
        handleRefresh={onRefreshDataHandler}
      />
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
                  <Status status={(dataRow as ITransacionForTable).state} />
                )}
              </Cell>
            ) : row.headerCell == "Delivery Type" ? (
              <Cell>
                {(dataRow) => (
                  <DelivryType deliveryType={(dataRow as ITransacionForTable).deliveryType } />
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
            {(rowData) => (
              <FaEye
                onClick={() =>
                  navigateToDetailsScreen((rowData as ITransacionForTable).uuid)
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
          style={{ color: "#3782ec88", maxWidth: 1500 }}
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
  );
}

export default TableCompo;
