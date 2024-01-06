/* eslint-disable @typescript-eslint/no-unused-vars */
import React from "react";
import { FaSearch } from "react-icons/fa";
import "./headerTable.css";
import { IoMdRefresh } from "react-icons/io";

type Props = {
  title: string;
  descr: string;
  value: string;
  handleSearch: () => void;
  handleFocusInput: () => void;
  handleChangeInput: (e: React.ChangeEvent<HTMLInputElement>) => void;
  handleRefresh: () => void;
  isSearch?: boolean;
};

const HeaderTable = ({
  handleChangeInput,
  handleFocusInput,
  handleRefresh,
  handleSearch,
  value,
  isSearch = true,
}: Props) => {
  return (
    <div className="header-page">
      <div className="header-left">
        <div onClick={handleRefresh} className="refresh-icon-container">
          <IoMdRefresh />
        </div>
      </div>

      {isSearch && (
        <div className="header-right">
          <div onClick={() => handleSearch()} className="search-icon-container">
            <FaSearch />
          </div>
          <div className="search-bar-container">
            <input
              value={value}
              onFocus={handleFocusInput}
              onChange={handleChangeInput}
              placeholder="Search uuid"
            />
          </div>
        </div>
      )}
    </div>
  );
};

export default HeaderTable;
