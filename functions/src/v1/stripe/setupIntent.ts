import * as functions from 'firebase-functions';
import {Stripe} from 'stripe';
import {v4 as uuidv4} from 'uuid';
// import functions from '../../utils/base_function'
import {exportFunction} from '../../utils/deploy';
import * as P from '../../utils/function_paths';

import {stripe, stripeOptions} from './utils/stripe_config';
import stripeErrors from './utils/stripe_error';
import {getStripeCustomerId} from './utils/stripe_utils';
import {getRequestingUserId} from '../../utils/firebase_utils';
import {onCall} from '../../utils/base_function';

const _exportFunction = (name: string, f: () => any) =>
  exportFunction([P.v1, P.stripe, 'setupIntent', name], exports, f);

// Create a SetupIntent
_exportFunction('onCreate', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    // if (!context.auth || !context.auth.uid) {
    //   throw new functions.https.HttpsError(
    //     'unauthenticated',
    //     'User is not authenticated.'
    //   )
    // }
    const customerId = await getStripeCustomerId(getRequestingUserId(context));
    if (customerId === null) {
      throw new functions.https.HttpsError(
          'failed-precondition',
          'User has no Stripe ID'
      );
    }

    const params: Stripe.SetupIntentCreateParams = {
      customer: customerId,
      usage: 'on_session',
    };
    if (data.usage) params.usage = data.usage;
    if (data.confirm) params.usage = data.usage;
    if (data.paymentMethod) params.payment_method = data.paymentMethod;
    if (data.confirm) params.confirm = data.confirm;
    if (data.returnUrl) params.return_url = data.returnUrl;

    stripeOptions.idempotencyKey = uuidv4();

    // console.log(params)
    return await stripe.setupIntents.create(params, stripeOptions).then(
        (result: Stripe.Response<Stripe.SetupIntent>) => {
        // console.log(result)
          const status = result.status;
          const clientSecret = result.client_secret;
          return {status: status, clientSecret: clientSecret};
        },
        (error: any) => {
          stripeErrors(error);
        }
    );
  })
);

// Retrieve a SetupIntent
//

// update a SetupIntent
_exportFunction('onUpdate', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    if (!context.auth || !context.auth.uid) {
      throw new functions.https.HttpsError(
          'unauthenticated',
          'User is not authenticated.'
      );
    }

    const customerId = await getStripeCustomerId(getRequestingUserId(context));
    if (customerId === null) {
      throw new functions.https.HttpsError(
          'failed-precondition',
          'User has no Stripe ID'
      );
    }

    const setupIntentId: string = data.setupIntentId;
    const params: Stripe.SetupIntentUpdateParams = {
      customer: customerId,
      payment_method: data.paymentMethodId,
    };

    stripeOptions.idempotencyKey = uuidv4();

    return await stripe.setupIntents
        .update(setupIntentId, params, stripeOptions)
        .then(
            (result: Stripe.Response<Stripe.SetupIntent>) => {
              const status = result.status;
              const clientSecret = result.client_secret;
              return {status: status, clientSecret: clientSecret};
            },
            (error: any) => {
              stripeErrors(error);
            }
        );
  })
);

// Confirm a SetupIntent
_exportFunction('onConfirm', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    if (!context.auth || !context.auth.uid) {
      throw new functions.https.HttpsError(
          'unauthenticated',
          'User is not authenticated.'
      );
    }
    const setupIntentId: string = data.setupIntentId;

    stripeOptions.idempotencyKey = uuidv4();

    return await stripe.setupIntents.confirm(setupIntentId, stripeOptions).then(
        (result: Stripe.Response<Stripe.SetupIntent>) => {
          const status = result.status;
          const clientSecret = result.client_secret;
          return {status: status, clientSecret: clientSecret};
        },
        (error: any) => {
          stripeErrors(error);
        }
    );
  })
);

// Cancel a SetupIntent
_exportFunction('onCancel', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    if (!context.auth || !context.auth.uid) {
      throw new functions.https.HttpsError(
          'unauthenticated',
          'User is not authenticated.'
      );
    }
    const setupIntentId: string = data.setupIntentId;

    stripeOptions.idempotencyKey = uuidv4();

    return await stripe.setupIntents.cancel(setupIntentId, stripeOptions).then(
        (result: Stripe.Response<Stripe.SetupIntent>) => {
          const status = result.status;
          const clientSecret = result.client_secret;
          return {status: status, clientSecret: clientSecret};
        },
        (error: any) => {
          stripeErrors(error);
        }
    );
  })
);
