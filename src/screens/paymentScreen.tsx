import React, { useEffect, useState } from 'react'
import HeaderPage from '../components/headerPage/headerPage'
import "../styles/payment.css"
import { IFullPaymentGroup } from '../helper/types'
import { fetchPaymentGroupsAPI, generatePaymentGroupsAPI, lockPaymentGroupsAPI } from '../helper/callsApi'
import PaymentGroupCard from '../components/paymentCard/paymentGroupCard'
import ActionConfirmation from '../components/ActionConfirmation/ActionConfirmation'
import Alert from '../components/Alert/alert'
import { useNavigate } from 'react-router'


const PaymentScreen : React.FC = () => {

  const [groups , setGroups ] = useState<IFullPaymentGroup[]>([])
  const [modalOfGenerateNewGroups , setModalOfGenerateNewGroups] = useState(false)
  const [modalOfLockGroup , setModalOfLockGroup] = useState(false)
  const [groupToLock , setGroupToLock] = useState(-1)
  const navigate = useNavigate()
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

  const onCancelModalOfLockGroup = () => {
    setModalOfLockGroup(false)
  }
  const onOpenModalOfLockGroup = (id : number) => {
    setModalOfLockGroup(true)
    setGroupToLock(id)
  }

  const onHandleLockGroup = async () => {
    setModalOfLockGroup(false)
    const res = await lockPaymentGroupsAPI(groupToLock)
    if (res.error) {
      onAlert(false , res.error  , true)
    }else {
      navigate("/payment/" + groupToLock)
    }
  

  }

  const onCancelModalOfGenerateNewGroups = () => {
    setModalOfGenerateNewGroups(false)
  }
  const onOpenModalOfGenerateNewGroups = () => {
    setModalOfGenerateNewGroups(true)
  }

  const fetchGroups = async () => {
    const res = await fetchPaymentGroupsAPI()
    if (res.groups) {
      setGroups(res.groups)
    }
  }

  const onHandleGenerateGroups = async () => {
    setModalOfGenerateNewGroups(false)
    const res = await generatePaymentGroupsAPI();
    if (res.success) {
      onAlert(true , "new groups are generated with success ",true)
      fetchGroups()
    }else {
      onAlert(true , "the process of generation of new groups are failed ",true)
    }

  }

  useEffect(()=>{
     fetchGroups()
  },[])
  return (
    <div className="payment-page">
        <div className="header">
            <HeaderPage
            title="Payment Group"
            descr="All groups to make the payment"
            />
        <div onClick={onOpenModalOfGenerateNewGroups} className="generate-new-groups" >Generate Groups</div>
        </div>
        <div className="list">
        {groups.map((item) => (
          <div className="admin" key={item.id}>
            <PaymentGroupCard paymentGroup={item} onLock={onOpenModalOfLockGroup} />
          </div>
        ))}
        {groups.length == 0 && (
          <div className="empty">
            There is no admin to display ...
          </div>
        )}
      </div>
      <ActionConfirmation 
      handleCanceled={onCancelModalOfGenerateNewGroups}
      handleSubmit={onHandleGenerateGroups}
      isOpen={modalOfGenerateNewGroups}
      submitButton='generate'
      confirmationText='Are you sure that you want to generate new payment groups !'/>
      <ActionConfirmation 
      handleCanceled={onCancelModalOfLockGroup}
      handleSubmit={onHandleLockGroup}
      isOpen={modalOfLockGroup}
      submitButton="Lock"
      confirmationText='Are you sure that you want to lock this payment groups !'/>
      <Alert alert={alert} onAlert={onAlert} />
    </div>
  )
}

export default PaymentScreen