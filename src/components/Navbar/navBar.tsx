/* eslint-disable @typescript-eslint/no-unused-vars */
import { useNavigate } from "react-router";
import "./navbar.css";

import { FaCodepen} from "react-icons/fa";

const NavBar = () => {

  const navigate = useNavigate()
  return (
    <div className="navBar">
      <div className="navBar-left">

      </div>

      <div className="navBar-mid">
          <div onClick={()=>navigate("/")} className="info">
            <div className="label"><FaCodepen /></div>
            <div className="value">
              <span>Code Analyzer</span>
            </div>
          </div>
      </div>
      <div className="navBar-right">

      </div>
    </div>
  );
};

export default NavBar;
