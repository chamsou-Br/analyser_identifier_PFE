import React from 'react'
import HeaderPage from '../components/headerPage/headerPage'


const PaymentScreen = () => {
  return (
    <div className="payment-page">
        <div className="header">
            <HeaderPage
            title="Payment Group"
            descr="All groups to make the payment"
            />
        <div onClick={()=>{}} className="generate-new-groups" >Generate Groups</div>
        </div>
    </div>
  )
}

export default PaymentScreen