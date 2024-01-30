import React, { useState } from "react";
import { Button, Input, Modal } from "rsuite";
import "./newAdmin.css"

type Props = {
  isOpen: boolean;
  handleCanceled: () => void;
  handleSubmit: (name: string) => void;
};

function NewAdminForm({ isOpen, handleCanceled, handleSubmit }: Props) {



  const onHandleNewAdmin = () => {
    handleSubmit(name);
    setName("");
  };
  const [name, setName] = useState("");
  return (
    <Modal
      className="new-user-form"
      open={isOpen}
      backdrop="static"
      onClose={handleCanceled}
    >
      <Modal.Body className="body">
        <div className="label">Admin name : </div>
        <Input
          className="input"
          value={name}
          onChange={(v: string) => setName(v)}
          placeholder="Name of admin"
        />
      </Modal.Body>
      <Modal.Footer>
        <Button
          className="button"
          onClick={onHandleNewAdmin}
          appearance="primary"
        >
          Add Admin
        </Button>
        <Button className="button" onClick={handleCanceled} appearance="subtle">
          Cancel
        </Button>
      </Modal.Footer>
    </Modal>
  );
}

export default NewAdminForm;
