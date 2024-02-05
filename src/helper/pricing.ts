import { DeliveryType, ITransactionNoSeller, TransactionStatus } from "./types";


export function fullAmountsInOutCalculator(productPrice: number, deliveryType: DeliveryType, deliveryPrice: number) : {
  fullAmountIn: number,
  fullAmountOut: number
}
{
  if (deliveryType === DeliveryType.PICK_FROM_SHOP) {
    return { fullAmountIn: productPrice * 1.01 + 60, fullAmountOut: productPrice * 0.975}
  }
  else {
    // delivery is included
    return { fullAmountIn: (productPrice + deliveryPrice) * 1.01 + 60, fullAmountOut: (productPrice + deliveryPrice) * 0.975}
  }
}

export const productPriceCalculator = (fullAmountIn : number , deliveryPrice: number) => {
    return ( fullAmountIn - 60 ) / 1.01 - deliveryPrice
} 

export default function priceCalculator(transaction: ITransactionNoSeller) : { 
  commission_money: number,
  buyer_money: number,
  seller_money: number,
  payed_money: number
}
{
  const total_price = (transaction.deliveryPrice + transaction.Invitation.price)
  const total_commissioned_input_money = (transaction.deliveryPrice + transaction.Invitation.price) * 1.015
  let delivery_return = 0
  if (transaction.certifiedDelivery) {
    delivery_return = transaction.deliveryPrice
  }

  switch(transaction.state) { 
    case TransactionStatus.PAYED_GHOSTED: { 
      //statements; 
      return { 
        commission_money: total_commissioned_input_money - transaction.Invitation.price - delivery_return,
        buyer_money: transaction.Invitation.price,
        seller_money: delivery_return,
        payed_money: total_commissioned_input_money
      }
    } 
    case TransactionStatus.PAYED_BUYER_CANCEL_LATE: { 
      //statements; 

      return { 
        commission_money: total_commissioned_input_money - transaction.Invitation.price - delivery_return,
        buyer_money: transaction.Invitation.price,
        seller_money: delivery_return,
        payed_money: total_commissioned_input_money
      } 
    }
    case TransactionStatus.PAYED_BUYER_CANCEL_MID: { 
      //statements; 

      return { 
        commission_money: total_commissioned_input_money - total_price,
        buyer_money: total_price,
        seller_money: 0,
        payed_money: total_commissioned_input_money
      } 
    }
    case TransactionStatus.PAYED_BUYER_CANCEL_EARLY: { 
      //statements; 

      return { 
        commission_money: total_commissioned_input_money - total_price,
        buyer_money: total_price,
        seller_money: 0,
        payed_money: total_commissioned_input_money
      }  
    }
    case TransactionStatus.PAYED_REIMBURSED: { 
      //statements; 

      return { 
        commission_money: total_commissioned_input_money - total_price,
        buyer_money: total_price,
        seller_money: 0,
        payed_money: total_commissioned_input_money
      } 
    }
    case TransactionStatus.PAYED_SELLER_CANCEL: { 
      //statements;

      return { 
        commission_money: total_commissioned_input_money - total_price,
        buyer_money: total_price,
        seller_money: 0,
        payed_money: total_commissioned_input_money
      }  
    }
    case TransactionStatus.PAYED_COMPLEX_CANCEL: { 
      //statements; 

      return { 
        commission_money: total_commissioned_input_money - total_price,
        buyer_money: total_price,
        seller_money: 0,
        payed_money: total_commissioned_input_money
      }  
    }
    case TransactionStatus.FULFILLED: { 
      //statements; 
      return { 
        commission_money:  total_commissioned_input_money - total_price * 0.98,
        buyer_money: 0,
        seller_money: total_price * 0.98,
        payed_money: total_commissioned_input_money
      }
    }
    case TransactionStatus.FULFILLED_CONTINUE: { 
      //statements;
      return { 
        commission_money:  total_commissioned_input_money - total_price * 0.98,
        buyer_money: 0,
        seller_money: total_price * 0.98,
        payed_money: total_commissioned_input_money
      }
    }
  } 
  return { 
    commission_money: 0,
    buyer_money: 0,
    seller_money: 0,
    payed_money: 0
  }
}