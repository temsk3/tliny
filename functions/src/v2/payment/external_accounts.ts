import { onCall } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import { getStripe, stripeOptions, stripeErrors } from './utils'
import { checkAuth, getRequestingUserId } from '../../utils/firebase_utils'
import Stripe from 'stripe'

const _exportFunction = (name: string, f: () => any) =>
  exportFunction(['v2', 'payment', 'external_accounts', name], exports, f)

// Create an External Account
_exportFunction('onCreate', () =>
  onCall(async (request) => {
    const uid = getRequestingUserId(request)
    const accountId: string = request.data.accountId
    const externalAccount = request.data.externalAccount
    const defaultForCurrency = request.data.defaultForCurrency
    const expand = request.data.expand
    const metadata = request.data.metadata

    const params: Stripe.AccountCreateExternalAccountParams = {
      external_account: externalAccount,
      default_for_currency: defaultForCurrency,
      expand: expand,
      metadata: metadata,
    }

    stripeOptions.idempotencyKey = `create_external_account_${uid}_${accountId}`

    const account = await getStripe().accounts.createExternalAccount(
      accountId,
      params,
      stripeOptions,
    )

    return account
  }),
)

// Retrieve an External Account
_exportFunction('onRetrieve', () =>
  onCall(async (request) => {
    checkAuth(request)
    const uid = getRequestingUserId(request)
    const accountId: string = request.data.accountId
    const externalAccountId: string = request.data.externalAccountId
    const expand = request.data.expand

    const params: Stripe.AccountRetrieveExternalAccountParams = {
      expand: expand,
    }

    stripeOptions.idempotencyKey = `retrieve_external_account_${uid}_${accountId}_${externalAccountId}`

    return await getStripe()
      .accounts.retrieveExternalAccount(
        accountId,
        externalAccountId,
        params,
        stripeOptions,
      )
      .then(
        (result: Stripe.Response<Stripe.ExternalAccount>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)

// Update an External Account
_exportFunction('onUpdate', () =>
  onCall(async (request) => {
    checkAuth(request)
    const uid = getRequestingUserId(request)
    const accountId: string = request.data.accountId
    const externalAccountId: string = request.data.externalAccountId
    const accountHolderName = request.data.accountHolderName
    const accountHolderType = request.data.accountHolderType
    const defaultForCurrency = request.data.defaultForCurrency
    const expand = request.data.expand
    const metadata = request.data.metadata

    const params: Stripe.AccountUpdateExternalAccountParams = {
      account_holder_name: accountHolderName,
      account_holder_type: accountHolderType,
      default_for_currency: defaultForCurrency,
      expand: expand,
      metadata: metadata,
    }

    stripeOptions.idempotencyKey = `update_external_account_${uid}_${accountId}_${externalAccountId}`

    return await getStripe()
      .accounts.updateExternalAccount(
        accountId,
        externalAccountId,
        params,
        stripeOptions,
      )
      .then(
        (result: Stripe.Response<Stripe.ExternalAccount>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)

// Delete an External Account
_exportFunction('onDelete', () =>
  onCall(async (request) => {
    checkAuth(request)
    const uid = getRequestingUserId(request)
    const accountId: string = request.data.accountId
    const externalAccountId: string = request.data.externalAccountId

    stripeOptions.idempotencyKey = `delete_external_account_${uid}_${accountId}_${externalAccountId}`

    const deleted = await getStripe().accounts.deleteExternalAccount(
      accountId,
      externalAccountId,
      stripeOptions,
    )

    return deleted
  }),
)

// List all External Accounts
_exportFunction('onList', () =>
  onCall(async (request) => {
    checkAuth(request)
    const uid = getRequestingUserId(request)
    const accountId: string = request.data.accountId
    const limit = request.data.limit
    const startingAfter = request.data.starting_after
    const endingBefore = request.data.ending_before

    const params: Stripe.AccountListExternalAccountsParams = {
      limit: limit,
      starting_after: startingAfter,
      ending_before: endingBefore,
    }

    stripeOptions.idempotencyKey = `list_external_accounts_${uid}_${accountId}`

    return await getStripe()
      .accounts.listExternalAccounts(accountId, params, stripeOptions)
      .then(
        (result: Stripe.ApiList<Stripe.ExternalAccount>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)
