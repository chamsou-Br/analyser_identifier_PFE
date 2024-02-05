export interface IAdmin {
  id: number , 
  name : string,
  createdAt: Date,
  updatedAt: Date,
}

export interface IPayment {
  id: string,
  rib: string,
  type: PaymentType,
  executed: boolean,
  fullAmount : number,
  createdAt: Date,
  updatedAt: Date,
}

export interface IPaymentWithGroup extends IPayment {
  PaymentGroup : IPaymentGroup
}

export interface IPaymentGroup {
  id: string,
  rib: string,
  state: PaymentGroupStatus ,
  AdminLockedId : number,
  fullAmount : number,
  createdAt: Date,
  updatedAt: Date,

}

export interface IFullPayment extends IPayment {
  Seller: ISellerBase , 
  Buyer : IBuyerBase , 
  Transaction : ITransaction
}

export interface IFullPaymentGroup extends IPaymentGroup{
  Payments : IFullPayment[],
  Admin : IAdmin
}


export enum PaymentGroupStatus {
PENDING = "Pending" ,
LOCKED = "Locked" , 
APPROVED = 'approved',
}





export interface IInvitation {
    uuid: string,
    product: string,
    description: string,
    price: number,
    storeWilaya : string,
    storeLocation: string,
    deliveryType: DeliveryType,
    localDeliveryPrice: number,
    active: EntityStatus,
    autoAccept: boolean,
    deliveryDelayHours: number,
    date: Date,
    images?: string[],
    createdAt: Date,
    updatedAt: Date,
  }
  
  
  export interface ITransaction {
    uuid: string,
    deliveryPlace: string,
    deliveryType: DeliveryType,
    deliveryPrice: number,
    deliveryDate?: Date,
    state: TransactionStatus,
    outcome: TransactionOutcome,
    activationKey: string,
    paymentDate?: Date,
    satimOrderNumber: string, //?
    satimOrderId: string, // ?
    // TO-DO: add maybe satimFullConfirmationJson
    // date validation
    validationDate: Date, // ?
    // without counting the transfer fee 0.7% [+delivery]
    fullAmountIn: number,
    // without counting transfer fees [+delivery]
    fullAmountOut: number,
    createdAt: Date,
    updatedAt: Date,
    certifiedDelivery: boolean,
    certifiedCompany: string,
    BuyerPaymentId : number , 
    SellerPaymentId : number
  }

  
  // Seller interfaces
  export interface IInvitationTransaction extends IInvitation {
    InvitationTransactions: ITransaction[]
  }
  
  export interface ITransactionSellerSide extends ITransaction {
    Invitation: IInvitation,
    Buyer: IBuyerBase
  }
  
  // Buyer interfaces
  export interface IInvitationComplete extends IInvitation {
    Seller: ISellerBase
  }
  
  export interface ITransactionWithSeller extends ITransaction {
    Invitation: IInvitationComplete
  }
  
  export interface ITransactionNoSeller extends ITransaction {
    Invitation: IInvitation
  }
  
  // admin interface
  export interface IAdminTransaction extends ITransaction {
    Invitation: IInvitationComplete,
    Buyer: IBuyerBase
  }
  
  export interface IAdminFullTransaction extends IAdminTransaction {
    Claims: IClaim[],
    Histories: IHistory[],
    DeliveryOffice?: IDeliveryOffice
  }
  
  export interface IClaim {
    id: number,
    sender: string,
    reason: string,
    text: string,
    createdAt: Date
  }

  export interface IHistory {
    id: number,
    action: string,
    uuid: string,
    actionType: string,
    reason: string,
    createdAt: Date
  }

 export interface IBuyerBase {
  id: number,
  name: string,
  firstName: string,
  birthDay: Date,
  gender: Gender,
  phoneNumber: string,
  wilaya: string;
  address: string,
  status: EntityStatus,
  email: string,
  rib: string
}

  
export interface ISellerBase {
  id: number,
  name: string,
  phoneNumber: string,
  email: string,
  firstName: string,
  businessName: string,
  location: string,
  wilaya: string
  description: string,
  status: EntityStatus,
  createdAt: Date,
  rib: string,
  official? : IOfficialDocuments , 

}

export interface ISellerWithRibRequests extends ISellerBase {
  ChangeRibRequests : IRipRequests[]
}

export interface IRipRequests {
  id : number,
  rib: string,
  official: IOfficialDocuments,
  status : EntityStatus; 
  SellerId : number,
  AcceptDate : Date,
  createdAt : Date,
  updatedAt : Date,
  deletedAt : Date,
 }


  export interface IClientBase {
    phoneNumber: string ,
    email: string ,
    birthDay: Date | null | undefined,
    gender: Gender | null | undefined,
    firstName: string ,
    businessName: string | null | undefined,
    location: string | null | undefined,
    wilaya: string ,
    address: string | null | undefined,
    description: string | null | undefined,
    status: EntityStatus ,
    client? : Client
    createdAt? : Date,
    rib?: string,
    official? : IOfficialDocuments , 

  }


  export interface IColumnsForTable {
    uuid: string;
    deliveryDate: string;
    deliveryPlace: string;
    deliveryType?: string;
    updateDate? : string;
    deliveryPrice: string;
    Buyer?: string;
    Seller?: string;
    ProductName: string;
    ProductPrice: string;
    paymentDate: string;
    claims?: number;
    state? : TransactionStatus,
    name?: string,
    firstName?: string,
    email?: string,
    phoneNumber?: string,
    businessName?: string,
    ribRequest?: number,
    rib?: string,
    // Add other properties you need
  }

  export interface IDeliveryOffice {
    id: number
    userName: string,
    company: string,
    email: string,
    phoneNumber : string,
    password: string,
    adminLevel: number,
    createdAt: Date,
  }

  export interface IRowsTable {
    headerCell : string,
    dataKey : string , 
    size : number
    // Add other properties you need
  }

  export enum Client {
    BUYER  = "BUYER" , 
    SELLER = "SELLER"
  }

  
  // TO-DO: remove IBuyer & ISeller
  export interface IBuyer extends IBuyerBase {
    transactions: ITransaction[],
  }
  
  export interface ISeller extends ISellerBase {
    invitations : IInvitation[],
    transactions: ITransactionSellerSide[]
  }



  export enum TransactionStatus {
    // initiated by the Buyer
    OPENED = 'opened',
    // accepted by the seller
    ACCEPTED = 'accepted',
    // payed by the buyer
    PAYED = 'payed',
    // validated by the seller -> to be sent
    FULFILLED = 'fulfilled',
    // validated but with reserve | activated when claim is submitted after validation
    FULFILLED_HOLD = 'fulfilled-hold',
    // decision : the hold is lifted no more claims
    FULFILLED_CONTINUE = 'fulfilled-continue',
    // canceled no process
    CANCELED = 'canceled',
    // cancel directly by buyer change mind
    PAYED_BUYER_CANCEL_EARLY = 'payed-buyer-cancel-early',
    PAYED_BUYER_CANCEL_MID = 'payed-buyer-cancel-mid',
    // decision + state of cancelation
    PAYED_BUYER_CANCEL_LATE = 'payed-buyer-cancel-late',
    // decision : buyer did not show up
    PAYED_GHOSTED = 'payed-ghosted',
    // decision : seller requested the cancelation
    PAYED_SELLER_CANCEL ='payed-seller-cancel',
    // decision
    PAYED_REIMBURSED = 'payed-reimbursed',
    // decision
    PAYED_COMPLEX_CANCEL = 'payed-reimbursed-complex',
    
  }

  
export enum TransactionOutcome {
    CLOSED_FAILED = 'closed-failed',
    CLOSED_SUCCESS = 'closed-success',
    CANCELED = 'canceled',
    ONGOING = 'ongoing'
  }

  export enum PaymentType {
    REIMBURSEMENT = 'Reimbursement',
    FULFILLMENT = 'Fulfillment',
    COMPENSATION_FOR_GHOSTING = 'Compensation-for-Ghosting',
  }
  
  export enum Gender {
    MAN = 'man',
    WOMAN = 'woman'
  }
  
  export enum DeliveryType {
    LOCAL_WILAYA_ONLY = 'local-wilaya-only',
    BETWEEN_WILAYAS = 'between-wilayas',
    PICK_FROM_SHOP = 'pick-from-shop',
    NOT_NEEDED = 'not-needed',
  }
  
  
  export enum EntityStatus {
    Pending = 'pending',
    Started = 'started',
    Accepted = 'accepted',
    Rejected = 'rejected',
    Active = "active"
  }


  export interface ITransactionClosing  {
    commission_money: number;
    buyer_money: number;
    seller_money: number;
    payed_money: number;
}
  
export interface IOfficialDocuments {
  rib_urls: string[],
  identity_urls: string[],
}