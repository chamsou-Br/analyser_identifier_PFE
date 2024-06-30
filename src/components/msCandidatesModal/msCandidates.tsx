import { Button, Modal } from "rsuite";
import "./msCandidates.css";
import { ICluster } from "../../helper/types";

type Props = {
  isOpen: boolean;
  handleCanceled: () => void;
  clusters: ICluster[]
};

const MsCandidatesModal = ({ isOpen, handleCanceled, clusters }: Props) => {

  return (
    <Modal
      className="msCandidatesModal"
      open={isOpen}
      backdrop="static"
      onClose={handleCanceled}
      size="full"
    >
      <Modal.Header closeButton={false}>
        <Modal.Title>Microservices Candidates</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <div>
        <div className="clusters" >
        {clusters.map((cluster , i) => (
          <div key={i} className="cluster">
            <div className="label">{cluster.name}</div>
            {cluster.class_names.map((className , j) => (
              <div key={j} className="className">
                {className}
              </div>
            ))}
          </div>
        ))}
        </div>
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
};

export default MsCandidatesModal;
