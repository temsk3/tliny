import * as f from 'firebase-functions';

import functions from '../../utils/base_function';
import {exportFunction} from '../../utils/deploy';
import * as P from '../../utils/function_paths';

import {stripe} from './utils/stripe_config';
import stripeErrors from './utils/stripe_error';

const _exportFunction = (name: string, f: () => any) =>
  exportFunction([P.v1, P.stripe, 'extrenalAccount', name], exports, f);

// Create a bank account
_exportFunction('onCreate', () =>
  functions().https.onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    if (!context.auth || !context.auth.uid) {
      throw new f.https.HttpsError(
          'unauthenticated',
          'User is not authenticated.'
      );
    }
    const accountId = data.accountId;
    const externalAccount = data.externalAccount;
    return await stripe.accounts
        .createExternalAccount(accountId, {
          external_account: externalAccount,
        })
        .then(
            (result: any) => {
              const bankAccount = result.id;
              return {bankAccount: bankAccount};
            },
            (error: any) => {
              stripeErrors(error);
            }
        );
  })
);

// Retrieve a bank account
_exportFunction('onRetrieve', () =>
  functions().https.onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    if (!context.auth || !context.auth.uid) {
      throw new f.https.HttpsError(
          'unauthenticated',
          'User is not authenticated.'
      );
    }
    const accountId = data.accountId;
    const bankAccount = data.bankAccount;
    return await stripe.accounts
        .retrieveExternalAccount(accountId, bankAccount)
        .then(
            (result: any) => {
              return result;
            },
            (error: any) => {
              stripeErrors(error);
            }
        );
  })
);

// Update a bank account
_exportFunction('onUpdate', () =>
  functions().https.onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    if (!context.auth || !context.auth.uid) {
      throw new f.https.HttpsError(
          'unauthenticated',
          'User is not authenticated.'
      );
    }
    const accountId = data.accountId;
    const bankAccount = data.bankAccount;
    const metadata = data.metadata; // order_id:"xxx" etc
    const accountHolderName = data.accountHolderName;
    const accountHolderType = 'individual'; // 'individual' or 'company'
    const accountType = 'futsu'; // 'futsu' or 'toza'
    return await stripe.accounts
        .updateExternalAccount(accountId, bankAccount, {
          metadata: metadata,
          account_holder_name: accountHolderName,
          account_holder_type: accountHolderType,
          account_type: accountType,
        })
        .then(
            (result: any) => {
              const bankAccount = result.id;
              return {bank_account: bankAccount};
            },
            (error: any) => {
              stripeErrors(error);
            }
        );
  })
);

// Delete a bank account
_exportFunction('onDelete', () =>
  functions().https.onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    if (!context.auth || !context.auth.uid) {
      throw new f.https.HttpsError(
          'unauthenticated',
          'User is not authenticated.'
      );
    }
    const accountId = data.accountId;
    const bankAccount = data.bankAccount;
    return await stripe.accounts
        .deleteExternalAccount(accountId, bankAccount)
        .then(
            (result: any) => {
              return result;
            },
            (error: any) => {
              stripeErrors(error);
            }
        );
  })
);
