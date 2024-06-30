import { Button, Modal } from "rsuite";
import "./classDetails.css"
import { IClassAnalyzer } from "../../helper/types";
import { BASE_URL } from "../../helper/constant";

type Props = {
  isOpen: boolean;
  data?: IClassAnalyzer ;
  handleCanceled: () => void;
};

const ClassDetails = ({isOpen  , handleCanceled , data}: Props) =>  {

if (data)
  return (
    <Modal
      className="ClassDetailsModal"
      open={isOpen}
      backdrop="static"
      onClose={handleCanceled}
      size="lg"
    >
      <Modal.Header closeButton={false}>
        <Modal.Title>{data.class_name} ( {BASE_URL + data.filename} ) </Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <div className="classCallGraphPicture">
            <img src={BASE_URL + data.filename} />
        </div>

      </Modal.Body>
      <Modal.Footer>
        <Button
          className="button"
          onClick={handleCanceled}
          appearance="primary"
        >
        Close
        </Button>
      </Modal.Footer>
    </Modal>
  );
}

export default ClassDetails;
