import { CallableRequest } from 'firebase-functions/v2/https'
import Stripe from 'stripe'

/**
 * 基本的なリクエストデータの型
 */
export interface BaseRequestData {
  [key: string]: unknown
}

/**
 * 認証情報を含むリクエストの型
 */
export interface AuthenticatedRequest {
  auth?: {
    uid?: string
  }
}

/**
 * 顧客関連のリクエストデータ型
 */
export interface CustomerRequestData extends BaseRequestData {
  customerId?: string
  email?: string
  name?: string
  phone?: string
  address?: any
  shipping?: Stripe.CustomerCreateParams.Shipping
  tax?: Stripe.CustomerCreateParams.Tax
  source?: string
  tax_exempt?: Stripe.CustomerCreateParams.TaxExempt
  apiVersion?: string
  query?: string
  limit?: number
  page?: string
}

/**
 * 決済関連のリクエストデータ型
 */
export interface PaymentRequestData extends BaseRequestData {
  amount?: number
  currency?: string
  customer?: string
  paymentMethodId?: string
  returnUrl?: string
  params?: Record<string, unknown>
}

/**
 * アカウント関連のリクエストデータ型
 */
export interface AccountRequestData extends BaseRequestData {
  accountId?: string
  externalAccount?: Record<string, unknown>
  externalAccountId?: string
  defaultForCurrency?: boolean
  expand?: string[]
  metadata?: Record<string, unknown>
  accountHolderName?: string
  accountHolderType?: string
  limit?: number
  starting_after?: string
  ending_before?: string
}

/**
 * 商品関連のリクエストデータ型
 */
export interface ProductRequestData extends BaseRequestData {
  productId?: string
  name?: string
  description?: string
  price?: number
  currency?: string
  metadata?: Record<string, unknown>
}

/**
 * 注文関連のリクエストデータ型
 */
export interface OrderRequestData extends BaseRequestData {
  orderId?: string
  customerId?: string
  items?: Array<Record<string, unknown>>
  status?: string
  metadata?: Record<string, unknown>
}

/**
 * チケット関連のリクエストデータ型
 */
export interface TicketRequestData extends BaseRequestData {
  ticketId?: string
  eventId?: string
  customerId?: string
  quantity?: number
  status?: string
  metadata?: Record<string, unknown>
}

/**
 * 型安全なCallableRequestのヘルパー型
 */
export type TypedCallableRequest<T extends BaseRequestData> = CallableRequest<T>
