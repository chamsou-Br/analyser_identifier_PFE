import React, { useEffect, useState } from 'react'
import HeaderPage from '../components/headerPage/headerPage'
import "../styles/payment.css"
import { IFullPaymentGroup } from '../helper/types'
import { fetchPaymentGroupsApprovedAPI } from '../helper/callsApi'
import PaymentGroupCard from '../components/paymentCard/paymentGroupCard'
import { useNavigate } from 'react-router'
import { MdPending } from 'react-icons/md'


const PaymentApprovedScreen : React.FC = () => {

  const [groups , setGroups ] = useState<IFullPaymentGroup[]>([])

  const navigate = useNavigate()

  const fetchGroups = async () => {
    const res = await fetchPaymentGroupsApprovedAPI()
    if (res.groups) {
      setGroups(res.groups)
    }
  }

  const onNavigateToPaymentGroupDetails = (id : number) => {
    navigate("/payment/" + id)
  }

  const onNavigateToPaymentPending = () => {
    navigate("/payment/" )
  }

  useEffect(()=>{
     fetchGroups()
  },[])
  return (
    <div className="payment-page">
        <div className="header">
            <HeaderPage
            title="Payment Group Approved"
            descr=""
            />
       
        </div>
        <div
            className="payment-approved"
            onClick={onNavigateToPaymentPending}
          >
            <div className="left">
              <MdPending className="icon" />
            </div>
            <div className="right">
              <div className="title">
              View pending payments  
              </div>
              <div className="description">
              You can consult the payments pending
              </div>
            </div>
          </div>
        <div className="list">
        {groups.map((item) => (
          <div className="admin" key={item.id}>
            <PaymentGroupCard paymentGroup={item} onLock={onNavigateToPaymentGroupDetails} />
          </div>
        ))}
        {groups.length == 0 && (
          <div className="empty">
            There is no approved payment to display ...
          </div>
        )}
      </div>

    </div>
  )
}

export default PaymentApprovedScreen