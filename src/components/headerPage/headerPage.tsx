import React from "react";
import { FaSearch } from "react-icons/fa";
import "./headerPage.css";

type Props = {
  title: string;
  descr: string;
  value?: string;
  handleSearch?: () => void;
  handleFocusInput?: () => void;
  handleChangeInput?: (e: React.ChangeEvent<HTMLInputElement>) => void;
  isSeach?: boolean;
};

function HeaderPage(props: Props) {
  return (
    <div className="header-page">
      <div className="header-left">
        <div className="title">{props.title}</div>
        <div className="descr">{props.descr}</div>
      </div>

      {props.isSeach ? (
        <div className="header-right">
          <div onClick={props.handleSearch} className="search-icon-container">
            <FaSearch />
          </div>
          <div className="search-bar-container">
            <input
              value={props.value}
              onFocus={props.handleFocusInput}
              onChange={props.handleChangeInput}
              placeholder="Search uuid"
            />
          </div>
        </div>
      ) : null}
    </div>
  );
}

export default HeaderPage;
