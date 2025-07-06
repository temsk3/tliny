import {
  onRequest as v2OnRequest,
  onCall as v2OnCall,
  HttpsOptions,
  CallableRequest,
} from 'firebase-functions/v2/https'
import { Request } from 'firebase-functions/v2/https'

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

/**
 * Firebase Functions v2 onCall関数のラッパー
 * @param handler ハンドラー関数
 * @param options オプション設定
 * @returns Firebase Functions v2 onCall関数
 */
export function onCall<T = unknown, R = unknown>(
  handler: (request: CallableRequest<T>) => R | Promise<R>,
  options?: Partial<HttpsOptions>,
) {
  return v2OnCall(
    options ? { ...defaultOptions, ...options } : defaultOptions,
    handler,
  )
}

export const onRequest = (
  handler: (req: Request, res: any) => void | Promise<void>,
  options?: Partial<HttpsOptions>,
) =>
  v2OnRequest(
    options ? { ...defaultOptions, ...options } : defaultOptions,
    handler,
  )
