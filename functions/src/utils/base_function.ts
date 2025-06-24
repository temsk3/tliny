import * as f from 'firebase-functions'
import { SUPPORTED_REGIONS } from 'firebase-functions'

const functions = (
  runtimeOptions: f.RuntimeOptions = {
    memory: '512MB',
    secrets: [
      //   'STRIPE_SECRET',
      //   'STRIPE_PUBLIC',
      //   'STRIPE_EP',
      'STRIPE_DEV_SK',
      'STRIPE_DEV_PK',
      'STRIPE_DEV_EP',
    ],
  },
  region: (typeof SUPPORTED_REGIONS)[number] = 'asia-northeast1',
) => f.runWith(runtimeOptions).region(region)

export default functions

export const onCall = (
  handler: (data: any, context: f.https.CallableContext) => any,
) => functions().https.onCall(handler)

export const onRequest = (
  handler: (request: f.https.Request, response: f.Response<any>) => any,
) => functions().https.onRequest(handler)
