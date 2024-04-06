import React, { useState } from "react";
import { Button, Input, Modal } from "rsuite";

type Props = {
  isOpen: boolean;
  handleCanceled: () => void;
  handleSubmit: (company: string, email: string, phoneNumber: string , rib : string) => void;
};

function DeliveryCompanyForm({ isOpen, handleCanceled, handleSubmit }: Props) {
  const onHandleNewCompany = () => {
    handleSubmit(company, email, phoneNumber , rib);
    setCompany("");
    setEmail("");
    setPhoneNumber("");
  };
  const [company, setCompany] = useState("");
  const [email, setEmail] = useState("");
  const [phoneNumber, setPhoneNumber] = useState("");
  const [rib, setRib] = useState("");
  return (
    <Modal
      className="delivery-company-form"
      open={isOpen}
      backdrop="static"
      onClose={handleCanceled}
    >
      <Modal.Body className="body">
        <div className="label">Company Name : </div>
        <Input
          className="input"
          value={company}
          onChange={(v: string) => setCompany(v)}
          placeholder="Name of company"
        />
        <div className="label">Email : </div>
        <Input
          className="input"
          value={email}
          onChange={(v: string) => setEmail(v)}
          placeholder="Email of company "
        />
        <div className="label">Phone number : </div>
        <Input
          className="input"
          value={phoneNumber}
          onChange={(v: string) => setPhoneNumber(v)}
          placeholder="Phone number of company "
        />
        <div className="label">Rib : </div>
        <Input
          className="input"
          value={rib}
          onChange={(v: string) => setRib(v)}
          placeholder="Rib of company "
        />
      </Modal.Body>
      <Modal.Footer>
        <Button
          className="button"
          onClick={onHandleNewCompany}
          appearance="primary"
        >
          Add company
        </Button>
        <Button className="button" onClick={handleCanceled} appearance="subtle">
          Cancel
        </Button>
      </Modal.Footer>
    </Modal>
  );
}

export default DeliveryCompanyForm;
