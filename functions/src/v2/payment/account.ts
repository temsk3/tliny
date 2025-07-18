import { onCall } from '../../utils/base_function'
import { logger } from 'firebase-functions'
import { ErrorHandler } from '../../utils/error_handler'
import { requireAuth } from '../../utils/auth-guard'
import { HttpsError } from 'firebase-functions/v2/https'
import Stripe from 'stripe'
import * as firebaseAdmin from 'firebase-admin'

import { getStripe, stripeOptions, stripeErrors } from './utils'
import { accountType, country } from './utils/stripe_config'
import { db, getStripeConnectAccountId } from '../../utils/firebase_utils'
import paths from '../firestore/utils/db_paths'

// MARK: - ConnectAccountを作成し、accountIdを返す
export const v2_payment_account_onCreate = onCall(async (request) => {
  const uid = requireAuth(request)
  const requestAccountType = (request.data as any).accountType || accountType

  try {
    stripeOptions.idempotencyKey = `create_account_${uid}`

    // Stripe Connect Accountを作成
    const account = await getStripe().accounts.create(
      {
        type: requestAccountType,
        country: 'JP',
        email: (request.data as any).email,
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
    await db.collection(paths.connectAccountsCollectionPath).doc(uid).set(
      {
        account_id: accountId,
        accountType: requestAccountType,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      { merge: true },
    )

    // カスタムクレームも更新（後方互換性のため）
    try {
      const user = await firebaseAdmin.auth().getUser(uid)
      const currentClaims = user.customClaims || {}
      const updatedClaims = { ...currentClaims, accountId }
      await firebaseAdmin.auth().setCustomUserClaims(uid, updatedClaims)
      logger.info('Custom claims updated for user:', { uid, accountId })
    } catch (error) {
      logger.error('Failed to update custom claims:', { uid, accountId, error })
      // カスタムクレームの更新に失敗しても処理は継続
    }

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
})

// MARK: ConnectAccountのretrieve
export const v2_payment_account_onRetrieve = onCall(async (request) => {
  const uid = requireAuth(request)
  const accountId = (request.data as any).accountId

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
})

// ConnectAccountのupdate
export const v2_payment_account_onUpdate = onCall(async (request) => {
  const uid = requireAuth(request)
  const accountId = (request.data as any).accountId
  const params: Stripe.AccountUpdateParams = (request.data as any).params

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
})

// MARK: stripeのConnectAccountを削除
export const v2_payment_account_onDelete = onCall(async (request) => {
  const uid = requireAuth(request)
  const accountId = (request.data as any).accountId

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
})

// ConnectAccountを検索
export const v2_payment_account_onList = onCall(async (request) => {
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
})

// MARK: Account Links の登録(account_onboarding)
export const v2_payment_account_onCreateAccountLink = onCall(
  async (request) => {
    const uid = requireAuth(request)
    const email = (request.data as any).email
    const returnUrl =
      (request.data as any).returnUrl || 'https://tliny-sample.spel1.com/user'
    const refreshUrl =
      (request.data as any).refreshUrl || 'https://tliny-sample.spel1.com/user'

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
            stripeOptions.idempotencyKey = `create_account_link_${uid}_${accountId}_${Date.now()}`
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
        } catch (error) {
          logger.error('Failed to retrieve account:', { error })

          // Stripeエラーの種類を確認
          if (error instanceof Stripe.errors.StripeError) {
            if (error.code === 'resource_missing') {
              // アカウントが存在しない場合のみ新規作成
              logger.info(
                'Account not found in Stripe, creating new account...',
              )
              accountId = null
            } else {
              // その他のStripeエラー（ネットワークエラーなど）の場合は既存アカウントを使用
              logger.warn(
                'Stripe error occurred, but keeping existing accountId:',
                {
                  errorCode: error.code,
                  accountId,
                },
              )
              // accountIdは既存の値のまま保持
            }
          } else {
            // Stripe以外のエラーの場合も既存アカウントを使用
            logger.warn(
              'Non-Stripe error occurred, but keeping existing accountId:',
              {
                error: error instanceof Error ? error.message : error,
                accountId,
              },
            )
            // accountIdは既存の値のまま保持
          }
        }
      }

      // 新しいアカウントを作成
      // 新規アカウントを作成
      const params: Stripe.AccountCreateParams = {
        type: accountType as Stripe.AccountCreateParams.Type,
        country: country,
        email: email,
        metadata: { uid },
        business_type: 'individual',
        business_profile: {
          url: 'https://web.tliny.jp/#/terms?uid=' + uid,
          mcc: '8398',
          product_description:
            '学校のPTAが主催するチャリティーバザー。保護者から提供された手作り品や中古品を販売し、収益は学校の備品（図書やスポーツ用品など）の購入費用に充当します。',
          support_email: email,
        },
        individual: {
          email: email,
        },
        capabilities: {
          card_payments: { requested: true },
          transfers: { requested: true },
          jcb_payments: { requested: true },
        },
        settings: {
          payouts: {
            schedule: {
              interval: 'manual',
            },
          },
        },
      }
      if (!accountId) {
        logger.info('Creating new Stripe Connect account...')
        stripeOptions.idempotencyKey = `create_account_${uid}_${Date.now()}`

        const account = await getStripe().accounts.create(
          // {
          //   type: accountType,
          //   country: 'JP',
          //   email: (request.data as any).email,
          //   business_type: 'individual',
          //   metadata: { uid },
          //   capabilities: {
          //     card_payments: { requested: true },
          //     transfers: { requested: true },
          //   },
          //   settings: {
          //     payouts: {
          //       schedule: {
          //         interval: 'manual',
          //       },
          //     },
          //   },
          // },
          params,
          stripeOptions,
        )

        accountId = account.id

        // Firestoreに保存
        await db.collection(paths.connectAccountsCollectionPath).doc(uid).set(
          {
            account_id: accountId,
            accountType: accountType,
            createdAt: new Date(),
            updatedAt: new Date(),
          },
          { merge: true },
        )

        // カスタムクレームも更新（後方互換性のため）
        try {
          const user = await firebaseAdmin.auth().getUser(uid)
          const currentClaims = user.customClaims || {}
          const updatedClaims = { ...currentClaims, accountId }
          await firebaseAdmin.auth().setCustomUserClaims(uid, updatedClaims)
          logger.info('Custom claims updated for user:', { uid, accountId })
        } catch (error) {
          logger.error('Failed to update custom claims:', {
            uid,
            accountId,
            error,
          })
          // カスタムクレームの更新に失敗しても処理は継続
        }

        logger.info('New Stripe Connect account created:', { accountId })
      }

      // オンボーディングリンクを作成
      logger.info('Creating onboarding link for account:', { accountId })
      stripeOptions.idempotencyKey = `create_account_link_${uid}_${accountId}_${Date.now()}`
      const accountLink = await getStripe().accountLinks.create(
        {
          account: accountId,
          refresh_url: refreshUrl,
          return_url: returnUrl,
          type: 'account_onboarding',
        },
        stripeOptions,
      )

      logger.info('Account onboarding link created:', { url: accountLink.url })
      return { accountUrl: accountLink.url }
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
  },
)

// MARK: Account Links の更新(account_update)
export const v2_payment_account_onUpdateAccountLink = onCall(
  async (request) => {
    const uid = requireAuth(request)
    const returnUrl =
      (request.data as any).returnUrl || 'https://web.tliny.jp/user'
    const refreshUrl =
      (request.data as any).refreshUrl || 'https://web.tliny.jp/user'

    logger.info('=== onUpdateAccountLink START ===')
    logger.info('Request data:', { data: request.data })
    logger.info('Using URLs:', { returnUrl, refreshUrl })

    try {
      const accountId = await getStripeConnectAccountId(uid)
      if (!accountId) {
        throw new HttpsError(
          'failed-precondition',
          'No Stripe Connect account found for user',
        )
      }

      logger.info('Creating update link for account:', { accountId })
      stripeOptions.idempotencyKey = `update_account_link_${uid}_${accountId}_${Date.now()}`

      const accountLink = await getStripe().accountLinks.create(
        {
          account: accountId,
          refresh_url: refreshUrl,
          return_url: returnUrl,
          type: 'account_update',
        },
        stripeOptions,
      )

      logger.info('Account update link created:', { url: accountLink.url })
      return { accountUrl: accountLink.url }
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
  },
)

// MARK: Login Links の作成
export const v2_payment_account_onCreateLoginLink = onCall(async (request) => {
  const uid = requireAuth(request)

  logger.info('=== onCreateLoginLink START ===')
  logger.info('Request data:', { data: request.data })

  try {
    const accountId = await getStripeConnectAccountId(uid)
    if (!accountId) {
      throw new HttpsError(
        'failed-precondition',
        'No Stripe Connect account found for user',
      )
    }

    logger.info('Creating login link for account:', { accountId })
    stripeOptions.idempotencyKey = `create_login_link_${uid}_${accountId}_${Date.now()}`

    const loginLink = await getStripe().accounts.createLoginLink(
      accountId,
      stripeOptions,
    )

    logger.info('Login link created:', { url: loginLink.url })
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
})
