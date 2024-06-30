import { Button, Loader, Modal } from "rsuite";
import "./globalGraph.css";
import { BASE_URL } from "../../helper/constant";
import { useEffect, useState } from "react";
import { getGlobalGraphAnalyzer } from "../../helper/callsApi";

type Props = {
  isOpen: boolean;
  path: string;
  handleCanceled: () => void;
};

const GlobalGraphModal = ({ isOpen, handleCanceled, path }: Props) => {
  const [image, setImage] = useState({
    callGraph: "",
    callGraphData: "",
    loading :true
  });

  const [active, setActive] = useState(0);

  useEffect(() => {
    const fetchCallGraph = async () => {
      const res = await getGlobalGraphAnalyzer(path);
      if (!res.error) {
        setImage({
          callGraph: res.callGraph!,
          callGraphData: res.callGraphData!,
          loading : false
        });
      }
    };
    if (image.loading == true) fetchCallGraph();
  }, []);

  return (
    <Modal
      className="globalCallGraphModal"
      open={isOpen}
      backdrop="static"
      onClose={handleCanceled}
      size="full"
    >
      <Modal.Header closeButton={false}>
        <Modal.Title>
          <span
            onClick={() => setActive(0)}
            className={`title-global-graph ${active == 0 ? "active" : ""}`}
          >
            Global Graph
          </span>
          <span
            onClick={() => setActive(1)}
            className={`title-global-graph ${active == 1 ? "active" : ""}`}
          >
            Global Graph data
          </span>
        </Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <div className={`globalCallGraphPicture ${active == 1 ? "data" : ""}`}>
          {!image.loading ? active == 0  ? (
            <img
              onClick={() =>
                console.log(
                  BASE_URL + image.callGraph,
                  BASE_URL + image.callGraphData
                )
              }
              src={BASE_URL + image.callGraph}
            />
          ) : (
            <img src={BASE_URL + image.callGraphData} />
          ) : null}
          {image.loading && (
            <Loader />
          )}
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

export default GlobalGraphModal;
