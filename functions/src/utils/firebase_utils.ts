/* eslint-disable max-len */
/* eslint-disable require-jsdoc */
import * as firebaseAdmin from 'firebase-admin';
import {CallableContext} from 'firebase-functions/lib/common/providers/https';
import {UserRecord} from 'firebase-functions/lib/common/providers/identity';
import * as functions from 'firebase-functions';

export const db = firebaseAdmin.firestore();

export function checkAuth(context: functions.https.CallableContext) {
  // 認証済みユーザーかどうかチェックする
  if (!context.auth || !context.auth.uid) {
    throw new functions.https.HttpsError(
        'unauthenticated',
        'User is not authenticated.'
    );
  }
  return context;
}

export function getRequestingUserId(context: CallableContext) {
  // context.auth is undefined when running in the emulator, provide a default uid
  // return context.auth === undefined
  //   ? '2QvgK80vQ3ULLylJSwAxWQZGaRD8'
  //   : context.auth.uid
  if (context.auth === undefined) {
    throw new Error('User is undefined.');
  }
  return context.auth.uid;
}

export async function getUserRecord(userId: string): Promise<UserRecord> {
  const userRecord = await firebaseAdmin.auth().getUser(userId);

  return userRecord;
}

export async function getUserEmail(
    userId: string
): Promise<string | undefined> {
  const userRecord = await getUserRecord(userId);
  return userRecord.email;
}

//
export async function getStripeCustomerId(
    userId: string
): Promise<string | null> {
  const user = await firebaseAdmin.auth().getUser(userId);
  return getStripeCustomerIdForUser(user);
}

export async function getStripeCustomerIdForUser(
    user: UserRecord
): Promise<string | null> {
  if (
    user.customClaims &&
    Object.hasOwnProperty.call(user.customClaims, 'customerId')
  ) {
    return (user.customClaims as any).customerId;
  } else {
    console.error(
        Error(`Missing customClaims.customerID for user: ${user.uid}`)
    );
    return null;
  }
}

//
export async function getStripeConnectAccountId(
    userId: string
): Promise<string | null> {
  const user = await firebaseAdmin.auth().getUser(userId);
  return getStripeConnectAccountIdForUser(user);
}

export async function getStripeConnectAccountIdForUser(
    user: UserRecord
): Promise<string | null> {
  if (
    user.customClaims &&
    Object.hasOwnProperty.call(user.customClaims, 'accountId')
  ) {
    return (user.customClaims as any).accountId;
  } else {
    console.error(Error(`Missing customClaims.accountId for user: ${user.uid}`));
    return null;
  }
}

//
export const chunk = <T extends any[]>(array: T, size: number): T[] =>
  array.reduce(
      (newarr, _, i) =>
      i % size ? newarr : [...newarr, array.slice(i, i + size)],
      []
  );
