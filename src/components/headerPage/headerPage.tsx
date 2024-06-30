import "./headerPage.css";

type Props = {
  title: string;
  descr: string;
  onHandleGlobalCallGraph : () => void;
  handleOpenFormIdentifierMs: () => void

};

const HeaderPage = ({descr , title , onHandleGlobalCallGraph , handleOpenFormIdentifierMs }: Props)  => {


  return (
    <div className="header-page">
      <div className="header-left">
        <div className="title">{title}</div>
        <div className="descr">{descr}</div>
      </div>
        <div className="header-right">
          <div onClick={onHandleGlobalCallGraph} className="global-call-graph action">
            Global Call Graph
          </div>
          <div onClick={handleOpenFormIdentifierMs} className="ms-candidates action">
            Microservices Candidates
          </div>
        </div>

    </div>
  );
}

export default HeaderPage;
