import { useState } from "react";
import { Button, Input, Loader, Modal } from "rsuite";

type Props = {
  isOpen: boolean;
  loading:boolean;
  handleCanceled: () => void;
  handleSubmit: (alpha : number , beta : number) => void;
};

function MsIdentificationForm({ isOpen, handleCanceled, handleSubmit , loading }: Props) {
  const onHandleIdentifyMicroservices = () => {
    handleSubmit(alpha,beta);
  };
  const [alpha, setAlpha] = useState<number>(0.5);
  const [beta, setBeta] = useState(0.5);

  return (
    <Modal
      className="delivery-company-form"
      open={isOpen}
      backdrop="static"
      onClose={handleCanceled}
    >
      <Modal.Body className="body">
        <div className="label">Data cohesion : </div>
        <Input
          type="number"
          className="input"
          value={beta}
          onChange={(v: string) => setBeta(parseFloat(v))}
          placeholder="Name of company"
        />
        <div className="label">Structural cohesion : </div>
        <Input
          type="number"
          className="input"
          value={alpha}
          onChange={(v: string) => setAlpha(parseFloat(v))}
          placeholder="Email of company "
        />
      </Modal.Body>
      <Modal.Footer>
        <Button
          className="button"
          onClick={onHandleIdentifyMicroservices}
          appearance="primary"
        >
          {loading ? <Loader /> : "Identify microservices"}
        </Button>
        <Button className="button" onClick={handleCanceled} appearance="subtle">
          Cancel
        </Button>
      </Modal.Footer>
    </Modal>
  );
}

export default MsIdentificationForm;
