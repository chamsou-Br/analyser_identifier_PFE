/* eslint-disable react-hooks/exhaustive-deps */
import { Button, Modal } from "rsuite";
import "./closeTransactionAction.css";
import { ITransactionClosing } from "../../helper/types";
import { getFormatPrice } from "../../helper/constant";

type infoClosing = {
    info: ITransactionClosing | undefined;
    error: string | null | undefined;
  };
  
type Props = {
  isOpen: boolean;
  handleSubmit: () => void;
  handleCanceled: () => void;
  uuid: string;
  info :  infoClosing;
};



function CloseTransactionAction(props: Props) {
 
  return (
    <Modal
      className="transaction-close"
      open={props.isOpen}
      backdrop="static"
      onClose={props.handleCanceled}
    >
      <Modal.Footer>
        {!props.info.error ? (
          <>
            <div className="closing_accounting">
              <span>
                {" "}
                commission_money : {getFormatPrice(props.info.info?.commission_money)}
              </span>
              <span>
                {" "}
                buyer_money : {getFormatPrice(props.info.info?.buyer_money)}
              </span>
              <span>
                {" "}
                seller_money : {getFormatPrice(props.info.info?.seller_money)}
              </span>
              <span>
                {" "}
                payed_money : {getFormatPrice(props.info.info?.payed_money)}
              </span>
            </div>
            <Modal.Title>
              Are you sure that you want to close the transaction ?
            </Modal.Title>
          </>
        ) : (
          <div className="error">{props.info.error}</div>
        )}
        <Button
          className="button"
          onClick={() => props.handleSubmit()}
          appearance="primary"
          disabled={props.info.error != null}
        >
          Submit
        </Button>
        <Button
          className="button"
          onClick={props.handleCanceled}
          appearance="subtle"
        >
          Cancel
        </Button>
      </Modal.Footer>
    </Modal>
  );
}

export default CloseTransactionAction;
