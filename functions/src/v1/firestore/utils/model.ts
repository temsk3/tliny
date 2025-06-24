export interface User {
  id: string
  displayName: string
  name: string
  email: string
  phone: string
}

export interface Customer {
  customer_id: string
  setup_secret: string
}

export interface Account {
  accountId: string
}

export interface CartItem {
  productDocRef: FirebaseFirestore.DocumentReference
  quantity: number
  productId: string
  programId: string
}

export interface LineItem {
  // priceId: string
  price_data: PriceData
  quantity: number
}

export interface PriceData {
  currency: string
  unit_amount: number
  product_data: ProductData
}

export interface ProductData {
  name: string
  description: string
  images: string[]
  meta_data: { product_id: string }
}

export interface Event {
  organizerId: string
  name: string
  message: string
  salesStart: FirebaseFirestore.Timestamp
  salesEnd: FirebaseFirestore.Timestamp
  eventFrom: FirebaseFirestore.Timestamp
  eventTo: FirebaseFirestore.Timestamp
  place: string
}

export interface Product {
  // 商品情報
  id: string
  exchangeNumber: number
  code: string
  name: string
  genre: string
  desc: string
  stock: number
  price: number
  pictureURL: string[]
  expirationFrom: FirebaseFirestore.Timestamp
  expirationTo: FirebaseFirestore.Timestamp
  isActive: boolean
  // Stripe
  priceId: string
  // 登録者
  register: string
  // 開催者
  organizerDocRef: FirebaseFirestore.DocumentReference
  organizerId: string
  // イベント情報
  eventDocRef: FirebaseFirestore.DocumentReference
  eventId: string
  eventName: string
  expirationLink: boolean
}

export interface SnapshotProduct {
  // cart情報
  productDocRef: FirebaseFirestore.DocumentReference
  quantity: number
  // 購入者
  userId: string
  userName: string
  // 商品情報
  productId: string
  exchangeNumber: number
  code: string
  name: string
  // genre: string
  desc: string
  price: number
  pictureURL: string[]
  expirationFrom: FirebaseFirestore.Timestamp
  expirationTo: FirebaseFirestore.Timestamp
  // 登録者
  register: string
  // 開催者
  organizerDocRef: FirebaseFirestore.DocumentReference
  organizerId: string
  // イベント情報
  eventDocRef: FirebaseFirestore.DocumentReference
  eventId: string
  eventName: string
  expirationLink: boolean
  // Stripe
  priceId: string
}

// export interface PreOrder {
//   userId: string
//   eventDocRef: FirebaseFirestore.DocumentReference
//   productDocRef: FirebaseFirestore.DocumentReference
//   quantity: number
//   createdAt: FirebaseFirestore.Timestamp
// }

export interface Order {
  status: OrderStatus
  paymentIntentId?: string
  checkoutSessionId?: string
  userId: string
  eventId: string
  purchaseTime: FirebaseFirestore.Timestamp
  createdAt: FirebaseFirestore.Timestamp
  snapshotProducts: SnapshotProduct[]
}

export const OrderStatus = {
  pre: 'pre',
  cancel: 'cancel',
  order: 'order',
} as const
export type OrderStatus = (typeof OrderStatus)[keyof typeof OrderStatus]
// export const AllOrderStatus = Object.values(OrderStatus)

export interface Ticket {
  // 購入者
  paidUserId: string
  paidUserName: string
  purchaseTime: FirebaseFirestore.Timestamp
  // 所有者
  ownerId: string
  ownerName: string
  assignment: Assignment[]
  // isActive: boolean
  isPrinting: boolean
  isUsed: boolean
  uuid: null
  pdfUuid: null
  // 商品情報
  productDocRef: FirebaseFirestore.DocumentReference
  productId: string
  // exchangeNumber: number
  code: string
  name: string
  // genre: string
  desc: string
  price: number
  pictureURL: string[]
  expirationFrom: FirebaseFirestore.Timestamp
  expirationTo: FirebaseFirestore.Timestamp
  // 登録者
  register?: string
  // 開催者
  organizerDocRef: FirebaseFirestore.DocumentReference
  organizerId: string
  // イベント情報
  eventDocRef: FirebaseFirestore.DocumentReference
  eventId: string
  eventName: string
  // expirationLink: boolean
  // Stripe
  // priceId: string
}

export interface Assignment {
  from: string
  to: string
  assignmentDate: FirebaseFirestore.Timestamp
}
