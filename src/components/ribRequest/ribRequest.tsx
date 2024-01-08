import React, { useState } from 'react'
import { EntityStatus, IRipRequests, ISellerBase } from '../../helper/types'
import LigneInfoInCard from '../LignInfoCard/lignInfoIncard'
import Status from '../TransactionStatus/status'
import { IoMdTime } from 'react-icons/io'
import { getFullFormatDate } from '../../helper/constant'
import { FaBehance } from 'react-icons/fa'
import "./ribReques.css"
import { Button, Modal } from 'rsuite'
import TransactionActionConfirmation from "../ActionConfirmation/ActionConfirmation";
import { acceptRibRequestAPI, rejectRibRequest } from '../../helper/callsApi'
import Alert from '../Alert/alert'

type Props = {
    request : IRipRequests;
    email : string;
    reviewRibRequest : (status : EntityStatus , id: number , seller : ISellerBase) => void

}

const RibRequest = ({request,email , reviewRibRequest}: Props) => {

    const [modalOfOfficialDocs, setModalOfOfficialDocs] = useState(false);
    const [docs, setDocs] = useState({
      type: 0,
      images: request.official?.identity_urls,
    });
    const onCloseModalOfOfficialDocs = () => {
        setModalOfOfficialDocs(false)
    }
    const onOpenModalOfOfficialDocs = () => {
        setModalOfOfficialDocs(true)
    }

    const [isModalConfirmOfAcceptRibRequest , setIsModalConfirmOfAcceptRibRequest ] = useState(false)

    const handleOpenModalOfAcceptRibRequest = () => {
        setModalOfOfficialDocs(false)
        setIsModalConfirmOfAcceptRibRequest(true)
    }

    const handleCanceledModalOfAcceptRibRequest = () => {
        setIsModalConfirmOfAcceptRibRequest(false)
        setModalOfOfficialDocs(true)
    }

    const handleSubmitAcceptRibRequest = async () => {
        setIsModalConfirmOfAcceptRibRequest(false)
        const res = await acceptRibRequestAPI(email , request.id)
        if (res.error) {
            onAlert(false , res.error , true)
        }else {
            onAlert(true ,'',true)
            reviewRibRequest(EntityStatus.Accepted , request.id , res.seller!)
        }
        
    }

    const [isModalConfirmOfRejectRibRequest , setIsModalConfirmOfRejectRibRequest ] = useState(false)

    const handleOpenModalOfRejectRibRequest = () => {
        setModalOfOfficialDocs(false)
        setIsModalConfirmOfRejectRibRequest(true)
    }

    const handleCanceledModalOfRejectRibRequest = () => {
        setIsModalConfirmOfRejectRibRequest(false)
        setModalOfOfficialDocs(true)
    }

    const handleSubmitRejectRibRequest = async () => {
        setIsModalConfirmOfRejectRibRequest(false)
        const res = await rejectRibRequest(email)
        console.log(res , "gf")
        if (res.error) {
            onAlert(false , res.error , true)
        }else {
            onAlert(true ,'',true)
            reviewRibRequest(EntityStatus.Rejected , request.id , res.seller!)
        }
    }

    
  const [alert, setAlert] = React.useState({
    isSucess: false,
    message: "",
    show: false,
  });

  const onAlert = (isSucess: boolean, message: string, show: boolean) => {
    setAlert({
      isSucess,
      message,
      show,
    });
  };

    

  return (
    <div className="rib-request">
    <div className="rib-request-header">
      <div onClick={onOpenModalOfOfficialDocs} className="details">see documents</div>
      <Status status={request.status} />
    </div>
    <LigneInfoInCard
      title="Rib"
      value={request.rib}
      icon={<FaBehance />}
    />
    <LigneInfoInCard
      title="Date"
      value={getFullFormatDate(request.createdAt)}
      icon={<IoMdTime />}
    />
    <Modal
        open={modalOfOfficialDocs}
        onClose={onCloseModalOfOfficialDocs}
        size="full"
        className="seller-docs"
      >
        <div className="docs-header">
          {" "}
          <span
            onClick={() => {
              setDocs({
                type: 0,
                images: request.official.identity_urls,
              });
            }}
            className={docs.type == 0 ? "active" : ""}
          >
            {" "}
            Identity Docs
          </span>{" "}
          <span
            onClick={() => {
              setDocs({
                type: 1,
                images: request.official?.rib_urls,
              });
            }}
            className={docs.type == 1 ? "active" : ""}
          >
            Rib Docs
          </span>
        </div>
        <Modal.Body className="content">
          <div className="docs-gallery">
          <div className="img-doc-container" >
              {docs.images!.map((img, i) => (
                <img key={i} src={img} className="img-doc" />
              ))}
            </div>
          </div>
        </Modal.Body>
        <Modal.Footer>
                {request.status == EntityStatus.Pending && (
                    <>
                              <Button
            className="button"
            onClick={handleOpenModalOfAcceptRibRequest}
            appearance="primary"
          >
            Accept documents
          </Button>
          <Button
            className="button block"
            onClick={handleOpenModalOfRejectRibRequest}
            appearance="primary"
          >
            Rejects documents
          </Button>
                    </>
                )}
          <Button
            className="button"
            onClick={onCloseModalOfOfficialDocs}
            appearance="subtle"
          >
            Cancel
          </Button>
        </Modal.Footer>
      </Modal>
      
      <TransactionActionConfirmation
          isOpen={isModalConfirmOfAcceptRibRequest}
          handleCanceled={handleCanceledModalOfAcceptRibRequest}
          handleSubmit={handleSubmitAcceptRibRequest}
          confirmationText="Are you sure that you want to accept this rib request ?"
        />
        <TransactionActionConfirmation
          isOpen={isModalConfirmOfRejectRibRequest}
          handleCanceled={handleCanceledModalOfRejectRibRequest}
          handleSubmit={handleSubmitRejectRibRequest}
          confirmationText="Are you sure that you want to reject this rib request ?"
        />
        <Alert alert={alert} onAlert={onAlert} />
  </div>
  )
}

export default RibRequest