/* eslint-disable max-len */
// import * as firebaseAdmin from 'firebase-admin'

import {
  onDocumentCreated,
  onDocumentUpdated,
  onDocumentDeleted,
} from 'firebase-functions/v2/firestore'
import { exportFunction } from '../../utils/deploy'
import * as P from '../../utils/function_paths'
import triggerOnce from '../../utils/trigger_once'
import { logger } from '../../utils/logger'
// import { currency, stripe, stripeOptions } from '../stripe/utils/stripe_config'
// import stripeErrors from '../stripe/utils/stripe_error'
// import Stripe from 'stripe'

const _exportFunction = (name: string, f: () => any): void =>
  exportFunction([P.v2, P.firestore, 'product', name], exports, f)

const path = '/v/{version}/price/{productID}'
// _exportFunction('onXxx', () =>
//   functions()
//     .firestore.document(path)
//     .onCreate(
//       // 冪等性の担保(eventIdの重複対策用function)
//       triggerOnce('xxxNotification', async (snapshot, context) => {
//         //

//         console.log(snapshot, context)
//       })
//     )
// )

_exportFunction('onCreate', () =>
  onDocumentCreated(path, async (event) => {
    const snapshot = event.data
    if (!snapshot) return

    await triggerOnce(
      'priceCreateNotification',
      async (data: any, context: any) => {
        logger.info('Price created:', { snapshotId: snapshot.id })
        logger.info('Price data:', { name: snapshot.data()?.name })
        logger.info('Price operation completed', { snapshot, context })
      },
    )
  }),
)

_exportFunction('onUpdate', () =>
  onDocumentUpdated(path, async (event) => {
    const snapshot = event.data
    if (!snapshot) return

    const after = snapshot.after.data()

    await triggerOnce(
      'priceUpdateNotification',
      async (data: any, context: any) => {
        logger.info('Price updated:', { after, context })
      },
    )
  }),
)

_exportFunction('onDelete', () =>
  onDocumentDeleted(path, async (event) => {
    const snapshot = event.data
    if (!snapshot) return

    await triggerOnce(
      'priceDeleteNotification',
      async (data: any, context: any) => {
        logger.info('Price deleted:', { snapshot, context })
      },
    )
  }),
)
