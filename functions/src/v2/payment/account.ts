/* eslint-disable max-len */
import { onCall } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import * as P from '../../utils/function_paths'
import { logger } from 'firebase-functions'
import { ErrorHandler } from '../../utils/error_handler'
import { requireAuth } from '../../utils/auth-guard'
import { HttpsError } from 'firebase-functions/v2/https'
import Stripe from 'stripe'

import { getStripe, stripeOptions, stripeErrors } from './utils'
import { accountType } from './utils/stripe_config'
import { db, getStripeConnectAccountId } from '../../utils/firebase_utils'
import paths from '../firestore/utils/db_paths'

const _exportFunction = (name: string, f: () => any) =>
  exportFunction([P.v2, P.payment, 'account', name], exports, f)

// MARK: - ConnectAccountを作成し、accountIdを返す
_exportFunction('onCreate', () =>
  onCall(async (request) => {
    const uid = requireAuth(request)
    const requestAccountType = request.data.accountType || accountType

    try {
      stripeOptions.idempotencyKey = `create_account_${uid}`

      // Stripe Connect Accountを作成
      const account = await getStripe().accounts.create(
        {
          type: requestAccountType,
          country: 'JP',
          email: request.data.email,
          business_type: 'individual',
          capabilities: {
            card_payments: { requested: true },
            transfers: { requested: true },
          },
          settings: {
            payouts: {
              schedule: {
                interval: 'manual',
              },
            },
          },
        },
        stripeOptions,
      )

      const accountId = account.id

      // Firestoreに保存
      await db.collection(paths.connectAccountsCollectionPath).doc(uid).set({
        stripeAccountId: accountId,
        accountType: requestAccountType,
        createdAt: new Date(),
        updatedAt: new Date(),
      })

      logger.info('Stripe Connect account setup completed')
      return { accountId: accountId }
    } catch (error: unknown) {
      ErrorHandler.logError(
        error,
        error instanceof Error ? error.stack : undefined,
        'payment/account.ts',
      )
      const appEx = ErrorHandler.convertToAppException(
        error,
        'payment/account.ts',
      )
      throw ErrorHandler.convertToHttpsError(appEx)
    }
  }),
)

// MARK: ConnectAccountのretrieve
_exportFunction('onRetrieve', () =>
  onCall(async (request) => {
    const uid = requireAuth(request)
    const accountId = request.data.accountId

    stripeOptions.idempotencyKey = `retrieve_account_${uid}_${accountId}`

    return await getStripe()
      .accounts.retrieve(accountId, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.Account>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
          throw new HttpsError('unknown', error)
        },
      )
  }),
)

// ConnectAccountのupdate
_exportFunction('onUpdate', () =>
  onCall(async (request) => {
    const uid = requireAuth(request)
    const accountId = request.data.accountId
    const params: Stripe.AccountUpdateParams = request.data.params

    stripeOptions.idempotencyKey = `update_account_${uid}_${accountId}`

    return await getStripe()
      .accounts.update(accountId, params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.Account>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)

// MARK: stripeのConnectAccountを削除
_exportFunction('onDelete', () =>
  onCall(async (request) => {
    const uid = requireAuth(request)
    const accountId = request.data.accountId

    stripeOptions.idempotencyKey = `delete_account_${uid}_${accountId}`

    return await getStripe()
      .accounts.del(accountId, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.DeletedAccount>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
          throw new HttpsError('unknown', error)
        },
      )
  }),
)

// ConnectAccountを検索
_exportFunction('onList', () =>
  onCall(async (request) => {
    const uid = requireAuth(request)

    const params: Stripe.AccountListParams = {}

    stripeOptions.idempotencyKey = `list_accounts_${uid}`

    return await getStripe()
      .accounts.list(params, stripeOptions)
      .then(
        (result: any) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
          throw new HttpsError('unknown', error)
        },
      )
  }),
)

// MARK: Account Links の登録(account_onboarding)
_exportFunction('onCreateAccountLink', () =>
  onCall(async (request) => {
    const uid = requireAuth(request)
    const returnUrl =
      request.data.returnUrl || 'https://tliny-sample.spel1.com/user'
    const refreshUrl =
      request.data.refreshUrl || 'https://tliny-sample.spel1.com/user'

    logger.info('=== onCreateAccountLink START ===')
    logger.info('Request data:', { data: request.data })
    logger.info('Using URLs:', { returnUrl, refreshUrl })

    try {
      // 既存のアカウントIDを取得
      let accountId = await getStripeConnectAccountId(uid)

      if (accountId) {
        logger.info('Using existing account:', { accountId })

        // アカウントの状態を確認
        try {
          const account = await getStripe().accounts.retrieve(
            accountId,
            stripeOptions,
          )
          logger.info('Account status:', {
            accountId: account.id,
            detailsSubmitted: account.details_submitted,
            chargesEnabled: account.charges_enabled,
            payoutsEnabled: account.payouts_enabled,
          })

          // アカウントが完全にオンボーディングされている場合は更新リンクを作成
          if (account.details_submitted && account.charges_enabled) {
            logger.info('Account is fully onboarded, creating update link...')
            stripeOptions.idempotencyKey = `update_account_link_${uid}_${accountId}_${Date.now()}`
            const updateLink = await getStripe().accountLinks.create(
              {
                account: accountId,
                refresh_url: refreshUrl,
                return_url: returnUrl,
                type: 'account_update',
              },
              stripeOptions,
            )
            logger.info('Account update link created:', { url: updateLink.url })
            return { accountUrl: updateLink.url }
          } else {
            // アカウントがまだオンボーディング中の場合、新しいオンボーディングリンクを作成
            logger.info(
              'Account is still onboarding, creating new onboarding link...',
            )
            stripeOptions.idempotencyKey = `create_onboarding_link_${uid}_${accountId}_${Date.now()}`
            const onboardingLink = await getStripe().accountLinks.create(
              {
                account: accountId,
                refresh_url: refreshUrl,
                return_url: returnUrl,
                type: 'account_onboarding',
              },
              stripeOptions,
            )
            logger.info('New onboarding link created:', {
              url: onboardingLink.url,
            })
            return { accountUrl: onboardingLink.url }
          }
        } catch (error) {
          logger.error('Failed to retrieve account, creating new account...', {
            error,
          })
          // アカウントの取得に失敗した場合、新しいアカウントを作成
          accountId = null
        }
      }

      // アカウントが存在しない場合、または取得に失敗した場合
      if (!accountId) {
        logger.info('No existing account found, creating new one...')

        // 新しいアカウントを作成
        stripeOptions.idempotencyKey = `create_account_for_link_${uid}_${Date.now()}`
        const account = await getStripe().accounts.create(
          {
            type: accountType,
            country: 'JP',
            email: request.data.email,
            business_type: 'individual',
            capabilities: {
              card_payments: { requested: true },
              transfers: { requested: true },
            },
            settings: {
              payouts: {
                schedule: {
                  interval: 'manual',
                },
              },
            },
          },
          stripeOptions,
        )

        accountId = account.id

        // Firestoreに保存
        await db.collection(paths.connectAccountsCollectionPath).doc(uid).set({
          stripeAccountId: accountId,
          accountType: accountType,
          createdAt: new Date(),
          updatedAt: new Date(),
        })

        logger.info('New account created:', { accountId })

        // アカウントオンボーディングリンクを作成
        logger.info('Creating account onboarding link...')
        stripeOptions.idempotencyKey = `create_onboarding_link_${uid}_${accountId}_${Date.now()}`
        const onboardingLink = await getStripe().accountLinks.create(
          {
            account: accountId,
            refresh_url: refreshUrl,
            return_url: returnUrl,
            type: 'account_onboarding',
          },
          stripeOptions,
        )
        logger.info('Account onboarding link created:', {
          url: onboardingLink.url,
        })

        return { accountUrl: onboardingLink.url }
      }

      // この行は実行されないはずだが、TypeScriptの型チェックのために追加
      throw new Error('Unexpected state: no account ID available')
    } catch (error: unknown) {
      ErrorHandler.logError(
        error,
        error instanceof Error ? error.stack : undefined,
        'payment/account.ts',
      )
      const appEx = ErrorHandler.convertToAppException(
        error,
        'payment/account.ts',
      )
      throw ErrorHandler.convertToHttpsError(appEx)
    }
  }),
)

// MARK: Account Links の更新(account_update)
_exportFunction('onUpdateAccountLink', () =>
  onCall(async (request) => {
    const uid = requireAuth(request)

    const accountId = await getStripeConnectAccountId(uid)
    if (accountId === null) {
      throw new HttpsError(
        'failed-precondition',
        'User has no Stripe ConnectAccount ID',
      )
    }

    // parameters
    //  request.data.params // {account: "xxx",refresh_url: "xxx",return_url: "xxx",type: "xxx"}
    const params: Stripe.AccountLinkCreateParams = {
      account: request.data.accountId,
      refresh_url:
        request.data.refreshUrl || 'https://tliny-sample.spel1.com/user',
      return_url:
        request.data.returnUrl || 'https://tliny-sample.spel1.com/user',
      type: 'account_update',
    }

    stripeOptions.idempotencyKey = `update_account_link_${uid}_${request.data.accountId}`

    return await getStripe()
      .accountLinks.create(params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.AccountLink>) => {
          const accountUrl = result.url
          logger.info('Account URL created:', { accountUrl })
          return { accountUrl: accountUrl }
        },
        (error: any) => {
          stripeErrors(error)
          throw new HttpsError('unknown', error)
        },
      )
  }),
)

// MARK: 管理画面へのリンク
_exportFunction('onCreateLoginLink', () =>
  onCall(async (request) => {
    const uid = requireAuth(request)

    try {
      const accountId = await getStripeConnectAccountId(uid)
      if (!accountId) {
        throw new HttpsError('not-found', 'Stripe account not found')
      }

      const loginLink = await getStripe().accounts.createLoginLink(
        accountId,
        stripeOptions,
      )

      logger.info('Login link created:', { loginUrl: loginLink.url })
      return { loginUrl: loginLink.url }
    } catch (error: unknown) {
      ErrorHandler.logError(
        error,
        error instanceof Error ? error.stack : undefined,
        'payment/account.ts',
      )
      const appEx = ErrorHandler.convertToAppException(
        error,
        'payment/account.ts',
      )
      throw ErrorHandler.convertToHttpsError(appEx)
    }
  }),
)
