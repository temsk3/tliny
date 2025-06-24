import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';

part 'stripe_repository.g.dart';

// StripeRepositoryProvider
@Riverpod(keepAlive: true)
StripeRepository stripeRepository(StripeRepositoryRef ref) {
  return StripeRepository(
    ref.watch(firebaseFunctionsProvider),
    ref.watch(firebaseFirestoreProvider),
  );
}

class StripeRepository {
  StripeRepository(this._func, this._db);
  final FirebaseFunctions _func;
  final FirebaseFirestore _db;

  /// Cloud Functions を呼び出すためのヘルパー関数
  Future<T?> _call<T>(String name, Map<dynamic, dynamic> params) async {
    logger.i('Service._call, $name, $params');
    final callable = _func.httpsCallable(name);
    try {
      final result = await callable.call<T>(params);
      logger.d(result);
      return result.data;
    } on FirebaseFunctionsException catch (e, st) {
      logger.e(
        'Service._call Error: FirebaseFunctionsException',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      return Future.error(e, st);
    } on Exception catch (e, st) {
      logger.e(
        'Service._call Error: Exception',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      return Future.error(e, st);
    }
  }

  // checkout
  /// チェックアウトセッションを作成する
  Future<Map<String, dynamic>> paymentCheckoutSession(
    String eventId,
  ) async {
    logger.d('paymentCheckoutSession: eventId=$eventId');
    try {
      final params = {
        'eventId': eventId,
        'successUrl': dotenv.get('CHECKOUT_SUCCESS_URL'),
        'cancelUrl': dotenv.get('CHECKOUT_CANCEL_URL'),
      };
      final response = await _call<Map<String, dynamic>>(
        'v1-method-checkout-onPayment',
        params,
      );
      // return response['url'];
      return response!;
    } on Exception catch (e, st) {
      logger.e(
        'paymentCheckoutSessionError',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// チェックアウトセッションを取得する
  Future<Map<String, dynamic>> retrieveCheckoutSession(
    String sessionId,
    String accountId,
  ) async {
    logger.d(
        'retrieveCheckoutSession: sessionId=$sessionId, accountId=$accountId');
    try {
      final checkoutSession = await _call<Map<String, dynamic>>(
        'v1-method-checkout-onRetrieve',
        {'checkoutSessionId': sessionId, 'accountId': accountId},
      );
      logger.d(checkoutSession);
      return checkoutSession!;
    } on Exception catch (e, st) {
      logger.e(
        'retrieveCheckoutSessionError',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// 注文をキャンセルする
  Future<void> cancelOrder(String orderId) async {
    logger.d('cancelOrder: orderId=$orderId');
    try {
      await _call<void>(
        'v1-method-checkout-onCancel',
        {'orderId': orderId},
      );
    } on Exception catch (e, st) {
      logger.e(
        'order cancel Error',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  // account
  /// Stripe アカウント情報を取得する
  Future<String> retrieveAccount(String accountId) async {
    logger.d('retrieveAccount: accountId=$accountId');
    try {
      logger.i('retrieveAccount');

      final response = await _call<Map<String, dynamic>>(
        'v1-stripe-account-onRetrieve',
        {'accountId': accountId},
      );
      final chargesEnabled = response!['charges_enabled'].toString();
      return chargesEnabled;
    } on Exception catch (e, st) {
      logger.e(
        'retrieveAccountError',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// Stripe アカウント作成用のリンクを取得する
  Future<String> getAccountLink(
    String email,
  ) async {
    logger.d('getAccountLink: email=$email');
    logger.i('getAccountLink');

    try {
      final params = {
        'email': email,
        'refreshUrl': dotenv.get('ACCOUNT_REFRESH_URL'),
        'returnUrl': dotenv.get('ACCOUNT_RETURN_URL'),
      };
      final response = await _call<Map<String, dynamic>>(
        'v1-method-stripeAccount-onCreate',
        params,
      );
      final accountLink = response!['accountUrl'].toString();
      return accountLink;
    } on Exception catch (e, st) {
      logger.e(
        'getAccountLinkError',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// ユーザーの決済情報を取得する
  Future<Map<String, dynamic>> getSettlement(
    String uid,
    String sessionId,
  ) async {
    logger.d('getSettlement: uid=$uid, sessionId=$sessionId');
    try {
      final docRef = await _db
          .collection('users')
          .doc(uid)
          .collection('settlement')
          .doc(sessionId)
          .get();
      return docRef.data()!;
    } on Exception catch (e, st) {
      logger.e(
        'getSettlementError',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// Stripe アカウントログイン用のリンクを取得する
  Future<String> createLoginLink() async {
    logger.d('createLoginLink');
    try {
      logger.i('createLoginLink');

      final response = await _call<Map<String, dynamic>>(
        'v1-stripe-account-onCreateLoginLink',
        {},
      );
      final loginUrl = response!['loginUrl'].toString();
      return loginUrl;
    } on Exception catch (e, st) {
      logger.e(
        'createLoginLinkError',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }
}
