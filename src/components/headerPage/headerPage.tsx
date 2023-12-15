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

const HeaderPage = ({descr , title , handleChangeInput , handleFocusInput , handleSearch , isSeach , value}: Props)  => {


  return (
    <div className="header-page">
      <div className="header-left">
        <div className="title">{title}</div>
        <div className="descr">{descr}</div>
      </div>

      {isSeach ? (
        <div className="header-right">
          <div onClick={handleSearch} className="search-icon-container">
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
      ) : null}
    </div>
  );
}

export default HeaderPage;
