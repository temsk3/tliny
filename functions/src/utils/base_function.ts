import {
  onRequest as v2OnRequest,
  onCall as v2OnCall,
  HttpsOptions,
  CallableRequest,
} from 'firebase-functions/v2/https'
import { Request, Response } from 'express'

const defaultOptions: HttpsOptions = {
  memory: '512MiB',
  secrets: [
    //   'STRIPE_SECRET',
    //   'STRIPE_PUBLIC',
    //   'STRIPE_EP',
    'STRIPE_DEV_SK',
    'STRIPE_DEV_PK',
    'STRIPE_DEV_EP',
  ],
  region: 'asia-northeast1',
}

const functions = (options: Partial<HttpsOptions> = {}) => {
  return { ...defaultOptions, ...options }
}

export default functions

export const onCall = (
  handler: (request: CallableRequest<unknown>) => unknown | Promise<unknown>,
  options?: Partial<HttpsOptions>,
) =>
  v2OnCall(
    options ? { ...defaultOptions, ...options } : defaultOptions,
    handler,
  )

export const onRequest = (
  handler: (req: Request, res: Response) => unknown,
  options?: Partial<HttpsOptions>,
) =>
  v2OnRequest(
    options ? { ...defaultOptions, ...options } : defaultOptions,
    handler,
  )
