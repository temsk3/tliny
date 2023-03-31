import * as f from 'firebase-functions'

import functions from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import * as P from '../../utils/function_paths'

import { stripe } from './utils/stripe_config'
import stripeErrors from './utils/stripe_error'

const _exportFunction = (name: string, f: () => any) =>
  exportFunction([P.v1, P.stripe, 'persons', name], exports, f)

// Create a person
_exportFunction('onCreate', () =>
  functions().https.onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    if (!context.auth || !context.auth.uid) {
      throw new f.https.HttpsError(
        'unauthenticated',
        'User is not authenticated.'
      )
    }
    const accountId = data.accountId
    const personToken = data.personToken
    await stripe.accounts
      .createPerson(accountId, {
        person_token: personToken,
      })
      .then(
        (result: any) => {
          const personId = result.id
          return { bank_account: personId }
        },
        (error: any) => {
          stripeErrors(error)
        }
      )
  })
)

// Retrieve a person
_exportFunction('onRetrieve', () =>
  functions().https.onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    if (!context.auth || !context.auth.uid) {
      throw new f.https.HttpsError(
        'unauthenticated',
        'User is not authenticated.'
      )
    }
    const accountId = data.accountId
    const personId = data.personId
    await stripe.accounts.retrievePerson(accountId, personId).then(
      (result: any) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      }
    )
  })
)

// Update a person
_exportFunction('onUpdate', () =>
  functions().https.onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    if (!context.auth || !context.auth.uid) {
      throw new f.https.HttpsError(
        'unauthenticated',
        'User is not authenticated.'
      )
    }
    const accountId = data.accountId
    const personId = data.personId
    const metadata = data.metadata // order_id:"xxx" etc
    await stripe.accounts
      .updatePerson(accountId, personId, {
        metadata: metadata,
      })
      .then(
        (result: any) => {
          const personId = result.id
          return { personId: personId }
        },
        (error: any) => {
          stripeErrors(error)
        }
      )
  })
)

// Delete a person
_exportFunction('onDelete', () =>
  functions().https.onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    if (!context.auth || !context.auth.uid) {
      throw new f.https.HttpsError(
        'unauthenticated',
        'User is not authenticated.'
      )
    }
    const accountId = data.accountId
    const personId = data.personId
    await stripe.accounts.deletePerson(accountId, personId).then(
      (result: any) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      }
    )
  })
)

// List all person
_exportFunction('onList', () =>
  functions().https.onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    if (!context.auth || !context.auth.uid) {
      throw new f.https.HttpsError(
        'unauthenticated',
        'User is not authenticated.'
      )
    }
    const accountId = data.accountId
    await stripe.accounts.listPersons(accountId).then(
      (result: any) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      }
    )
  })
)
