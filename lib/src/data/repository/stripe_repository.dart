import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';
import 'base_repository.dart';

part 'stripe_repository.g.dart';

// StripeRepositoryProvider
@Riverpod(keepAlive: true)
StripeRepository stripeRepository(Ref ref) {
  return StripeRepository(
    ref.watch(firebaseFunctionsProvider),
    ref.watch(firebaseFirestoreProvider),
  );
}

class StripeRepository extends BaseRepository {
  StripeRepository(this._func, this._db);
  final FirebaseFunctions _func;
  final FirebaseFirestore _db;

  @override
  FirebaseFunctions getFunctions() => _func;

  // checkout
  /// チェックアウトセッションを作成する
  Future<Map<String, dynamic>> paymentCheckoutSession(String eventId) async {
    logger.d('paymentCheckoutSession: eventId=$eventId');
    try {
      final params = {
        'eventId': eventId,
        'successUrl': dotenv.get('CHECKOUT_SUCCESS_URL'),
        'cancelUrl': dotenv.get('CHECKOUT_CANCEL_URL'),
      };
      logger.i('paymentCheckoutSession params: $params');

      final response = await callFunction<Map<String, dynamic>>(
        'v2_payment_checkout_createPaymentSession',
        params,
        context: 'paymentCheckoutSession',
      );

      logger.i('paymentCheckoutSession response: $response');
      logger.d('paymentCheckoutSession success - eventId: $eventId');

      return response!;
    } on Exception catch (e, st) {
      logger.e(
        'paymentCheckoutSessionError - eventId: $eventId',
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
      'retrieveCheckoutSession: sessionId=$sessionId, accountId=$accountId',
    );
    try {
      final params = {'checkoutSessionId': sessionId, 'accountId': accountId};
      logger.i('retrieveCheckoutSession params: $params');

      final checkoutSession = await callFunction<Map<String, dynamic>>(
        'v2_payment_checkout_retrieveSession',
        params,
        context: 'retrieveCheckoutSession',
      );

      logger.i('retrieveCheckoutSession response: $checkoutSession');
      logger.d('retrieveCheckoutSession success - sessionId: $sessionId');

      return checkoutSession!;
    } on Exception catch (e, st) {
      logger.e(
        'retrieveCheckoutSessionError - sessionId: $sessionId, accountId: $accountId',
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
      await callFunction<void>('v2_payment_checkout_cancelOrder', {
        'orderId': orderId,
      }, context: 'cancelOrder');
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
  /// Stripe アカウント作成用のリンクを取得する
  Future<String> getAccountLink(String email) async {
    logger.d('getAccountLink: email=$email');
    logger.i('getAccountLink');

    try {
      final params = {
        'email': email,
        'refreshUrl': dotenv.get('ACCOUNT_REFRESH_URL'),
        'returnUrl': dotenv.get('ACCOUNT_RETURN_URL'),
      };
      final response = await callFunction<Map<String, dynamic>>(
        'v2_payment_account_onCreateAccountLink',
        params,
        context: 'getAccountLink',
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
      final docRef =
          await _db
              .collection('v/1/users') // パスを統一
              .doc(uid)
              .collection('settlement')
              .doc(sessionId)
              .get();

      if (!docRef.exists) {
        throw Exception(
          'Settlement document not found for sessionId: $sessionId',
        );
      }

      final data = docRef.data();
      if (data == null) {
        throw Exception(
          'Settlement document data is null for sessionId: $sessionId',
        );
      }

      return data;
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

      final response = await callFunction<Map<String, dynamic>>(
        'v2_payment_account_onCreateLoginLink',
        {},
        context: 'createLoginLink',
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

  // /// アカウントタイプをテストする
  // Future<void> testAccountType(String accountId) async {
  //   logger.d('testAccountType: accountId=$accountId');
  //   try {
  //     await _call<void>('v2-payment-account-onRetrieve', {
  //       'accountId': accountId,
  //     });
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'testAccountTypeError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // customer
  // /// 顧客を作成する
  // Future<Map<String, dynamic>> createCustomer(String email) async {
  //   logger.d('createCustomer: email=$email');
  //   try {
  //     // TODO: v2-payment-customer-onCreate が実装されていません
  //     // final response = await _call<Map<String, dynamic>>(
  //     //   'v2-payment-customer-onCreate',
  //     //   {'email': email},
  //     // );
  //     // return response!;
  //     throw UnimplementedError(
  //       'v2-payment-customer-onCreate is not implemented yet',
  //     );
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'createCustomerError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// 顧客を取得する
  // Future<Map<String, dynamic>> getCustomer(String customerId) async {
  //   logger.d('getCustomer: customerId=$customerId');
  //   try {
  //     // TODO: v2-payment-customer-onRetrieve が実装されていません
  //     // final response = await _call<Map<String, dynamic>>(
  //     //   'v2-payment-customer-onRetrieve',
  //     //   {'customerId': customerId},
  //     // );
  //     // return response!;
  //     throw UnimplementedError(
  //       'v2-payment-customer-onRetrieve is not implemented yet',
  //     );
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'getCustomerError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// 顧客を更新する
  // Future<Map<String, dynamic>> updateCustomer(
  //   String customerId,
  //   Map<String, dynamic> data,
  // ) async {
  //   logger.d('updateCustomer: customerId=$customerId, data=$data');
  //   try {
  //     // TODO: v2-payment-customer-onUpdate が実装されていません
  //     // final response = await _call<Map<String, dynamic>>(
  //     //   'v2-payment-customer-onUpdate',
  //     //   {'customerId': customerId, 'data': data},
  //     // );
  //     // return response!;
  //     throw UnimplementedError(
  //       'v2-payment-customer-onUpdate is not implemented yet',
  //     );
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'updateCustomerError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// 顧客を削除する
  // Future<void> deleteCustomer(String customerId) async {
  //   logger.d('deleteCustomer: customerId=$customerId');
  //   try {
  //     await _call<void>('v2-payment-customer-onDelete', {
  //       'customerId': customerId,
  //     });
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'deleteCustomerError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // paymentIntent
  // /// 支払い意図を作成する
  // Future<Map<String, dynamic>> createPaymentIntent(
  //   int amount,
  //   String currency,
  //   String customerId,
  // ) async {
  //   logger.d(
  //     'createPaymentIntent: amount=$amount, currency=$currency, customerId=$customerId',
  //   );
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-payment-payment-intent-onCreate',
  //       {'amount': amount, 'currency': currency, 'customerId': customerId},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'createPaymentIntentError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// 支払い意図を取得する
  // Future<Map<String, dynamic>> getPaymentIntent(String paymentIntentId) async {
  //   logger.d('getPaymentIntent: paymentIntentId=$paymentIntentId');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-payment-payment-intent-onRetrieve',
  //       {'paymentIntentId': paymentIntentId},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'getPaymentIntentError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// 支払い意図を更新する
  // Future<Map<String, dynamic>> updatePaymentIntent(
  //   String paymentIntentId,
  //   Map<String, dynamic> data,
  // ) async {
  //   logger.d(
  //     'updatePaymentIntent: paymentIntentId=$paymentIntentId, data=$data',
  //   );
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-payment-payment-intent-onUpdate',
  //       {'paymentIntentId': paymentIntentId, 'data': data},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'updatePaymentIntentError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// 支払い意図をキャンセルする
  // Future<Map<String, dynamic>> cancelPaymentIntent(
  //   String paymentIntentId,
  // ) async {
  //   logger.d('cancelPaymentIntent: paymentIntentId=$paymentIntentId');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-payment-payment-intent-onCapture',
  //       {'paymentIntentId': paymentIntentId},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'cancelPaymentIntentError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // paymentMethod
  // /// 支払い方法を作成する
  // Future<Map<String, dynamic>> createPaymentMethod(
  //   String type,
  //   Map<String, dynamic> card,
  // ) async {
  //   logger.d('createPaymentMethod: type=$type, card=$card');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-payment-payment-method-onCreate',
  //       {'type': type, 'card': card},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'createPaymentMethodError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// 支払い方法を取得する
  // Future<Map<String, dynamic>> getPaymentMethod(String paymentMethodId) async {
  //   logger.d('getPaymentMethod: paymentMethodId=$paymentMethodId');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-payment-payment-method-onRetrieve',
  //       {'paymentMethodId': paymentMethodId},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'getPaymentMethodError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// 支払い方法を更新する
  // Future<Map<String, dynamic>> updatePaymentMethod(
  //   String paymentMethodId,
  //   Map<String, dynamic> data,
  // ) async {
  //   logger.d(
  //     'updatePaymentMethod: paymentMethodId=$paymentMethodId, data=$data',
  //   );
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-payment-payment-method-onUpdate',
  //       {'paymentMethodId': paymentMethodId, 'data': data},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'updatePaymentMethodError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// 支払い方法を削除する
  // Future<void> deletePaymentMethod(String paymentMethodId) async {
  //   logger.d('deletePaymentMethod: paymentMethodId=$paymentMethodId');
  //   try {
  //     await _call<void>('v2-payment-payment-method-onDelete', {
  //       'paymentMethodId': paymentMethodId,
  //     });
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'deletePaymentMethodError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // setupIntent
  // /// セットアップ意図を作成する
  // Future<Map<String, dynamic>> createSetupIntent(String customerId) async {
  //   logger.d('createSetupIntent: customerId=$customerId');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-payment-setup-intent-onCreate',
  //       {'customerId': customerId},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'createSetupIntentError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// セットアップ意図を取得する
  // Future<Map<String, dynamic>> getSetupIntent(String setupIntentId) async {
  //   logger.d('getSetupIntent: setupIntentId=$setupIntentId');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-payment-setup-intent-onRetrieve',
  //       {'setupIntentId': setupIntentId},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'getSetupIntentError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// セットアップ意図をキャンセルする
  // Future<Map<String, dynamic>> cancelSetupIntent(String setupIntentId) async {
  //   logger.d('cancelSetupIntent: setupIntentId=$setupIntentId');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-payment-setup-intent-onCancel',
  //       {'setupIntentId': setupIntentId},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'cancelSetupIntentError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // externalAccounts
  // /// 外部アカウントを作成する
  // Future<Map<String, dynamic>> createExternalAccount(
  //   String accountId,
  //   Map<String, dynamic> externalAccount,
  // ) async {
  //   logger.d(
  //     'createExternalAccount: accountId=$accountId, externalAccount=$externalAccount',
  //   );
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-payment-external-accounts-onCreate',
  //       {'accountId': accountId, 'externalAccount': externalAccount},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'createExternalAccountError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// 外部アカウントを取得する
  // Future<Map<String, dynamic>> getExternalAccount(
  //   String accountId,
  //   String externalAccountId,
  // ) async {
  //   logger.d(
  //     'getExternalAccount: accountId=$accountId, externalAccountId=$externalAccountId',
  //   );
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-payment-external-accounts-onRetrieve',
  //       {'accountId': accountId, 'externalAccountId': externalAccountId},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'getExternalAccountError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// 外部アカウントを更新する
  // Future<Map<String, dynamic>> updateExternalAccount(
  //   String accountId,
  //   String externalAccountId,
  //   Map<String, dynamic> data,
  // ) async {
  //   logger.d(
  //     'updateExternalAccount: accountId=$accountId, externalAccountId=$externalAccountId, data=$data',
  //   );
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-payment-external-accounts-onUpdate',
  //       {
  //         'accountId': accountId,
  //         'externalAccountId': externalAccountId,
  //         'data': data,
  //       },
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'updateExternalAccountError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// 外部アカウントを削除する
  // Future<void> deleteExternalAccount(
  //   String accountId,
  //   String externalAccountId,
  // ) async {
  //   logger.d(
  //     'deleteExternalAccount: accountId=$accountId, externalAccountId=$externalAccountId',
  //   );
  //   try {
  //     await _call<void>('v2-payment-external-accounts-onDelete', {
  //       'accountId': accountId,
  //       'externalAccountId': externalAccountId,
  //     });
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'deleteExternalAccountError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // business logic
  // /// アカウントを作成する
  // Future<Map<String, dynamic>> createAccount(Map<String, dynamic> data) async {
  //   logger.d('createAccount: data=$data');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       '// TODO: v2-business-account-onCreate が実装されていません',
  //       {'data': data},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'createAccountError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// アカウントを取得する
  // Future<Map<String, dynamic>> getAccount(String accountId) async {
  //   logger.d('getAccount: accountId=$accountId');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       '// TODO: v2-business-account-onRetrieve が実装されていません',
  //       {'accountId': accountId},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'getAccountError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// アカウントを更新する
  // Future<Map<String, dynamic>> updateAccount(
  //   String accountId,
  //   Map<String, dynamic> data,
  // ) async {
  //   logger.d('updateAccount: accountId=$accountId, data=$data');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       '// TODO: v2-business-account-onUpdate が実装されていません',
  //       {'accountId': accountId, 'data': data},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'updateAccountError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// アカウントを削除する
  // Future<void> deleteAccount(String accountId) async {
  //   logger.d('deleteAccount: accountId=$accountId');
  //   try {
  //     await _call<void>('// TODO: v2-business-account-onDelete が実装されていません', {
  //       'accountId': accountId,
  //     });
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'deleteAccountError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// 商品を作成する
  // Future<Map<String, dynamic>> createProduct(Map<String, dynamic> data) async {
  //   logger.d('createProduct: data=$data');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-business-product-onCreate',
  //       {'data': data},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'createProductError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// 商品を取得する
  // Future<Map<String, dynamic>> getProduct(String productId) async {
  //   logger.d('getProduct: productId=$productId');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-business-product-onRetrieve',
  //       {'productId': productId},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'getProductError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// 商品を更新する
  // Future<Map<String, dynamic>> updateProduct(
  //   String productId,
  //   Map<String, dynamic> data,
  // ) async {
  //   logger.d('updateProduct: productId=$productId, data=$data');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-business-product-onUpdate',
  //       {'productId': productId, 'data': data},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'updateProductError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// 商品を削除する
  // Future<void> deleteProduct(String productId) async {
  //   logger.d('deleteProduct: productId=$productId');
  //   try {
  //     await _call<void>('v2-business-product-onDelete', {
  //       'productId': productId,
  //     });
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'deleteProductError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  /// 注文を作成する
  // Future<Map<String, dynamic>> createOrder(Map<String, dynamic> data) async {
  //   logger.d('createOrder: data=$data');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-business-order-onCreate',
  //       {'data': data},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'createOrderError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  /// 注文を取得する
  // Future<Map<String, dynamic>> getOrder(String orderId) async {
  //   logger.d('getOrder: orderId=$orderId');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-business-order-onRetrieve',
  //       {'orderId': orderId},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e('getOrderError', time: DateTime.now(), error: e, stackTrace: st);
  //     rethrow;
  //   }
  // }

  /// 注文を更新する
  // Future<Map<String, dynamic>> updateOrder(
  //   String orderId,
  //   Map<String, dynamic> data,
  // ) async {
  //   logger.d('updateOrder: orderId=$orderId, data=$data');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-business-order-onUpdate',
  //       {'orderId': orderId, 'data': data},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'updateOrderError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  /// 注文を削除する
  // Future<void> deleteOrder(String orderId) async {
  //   logger.d('deleteOrder: orderId=$orderId');
  //   try {
  //     await _call<void>('v2-business-order-onDelete', {'orderId': orderId});
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'deleteOrderError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  /// チケットを作成する
  // Future<Map<String, dynamic>> createTicket(Map<String, dynamic> data) async {
  //   logger.d('createTicket: data=$data');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-business-ticket-onCreate',
  //       {'data': data},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'createTicketError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  /// チケットを取得する
  // Future<Map<String, dynamic>> getTicket(String ticketId) async {
  //   logger.d('getTicket: ticketId=$ticketId');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-business-ticket-onRetrieve',
  //       {'ticketId': ticketId},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'getTicketError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  /// チケットを更新する
  // Future<Map<String, dynamic>> updateTicket(
  //   String ticketId,
  //   Map<String, dynamic> data,
  // ) async {
  //   logger.d('updateTicket: ticketId=$ticketId, data=$data');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-business-ticket-onUpdate',
  //       {'ticketId': ticketId, 'data': data},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'updateTicketError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  /// チケットを削除する
  // Future<void> deleteTicket(String ticketId) async {
  //   logger.d('deleteTicket: ticketId=$ticketId');
  //   try {
  //     await _call<void>('v2-business-ticket-onDelete', {'ticketId': ticketId});
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'deleteTicketError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // firestore
  // /// 価格を作成する
  // Future<Map<String, dynamic>> createPrice(Map<String, dynamic> data) async {
  //   logger.d('createPrice: data=$data');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-firestore-price-onCreate',
  //       {'data': data},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'createPriceError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// 価格を取得する
  // Future<Map<String, dynamic>> getPrice(String priceId) async {
  //   logger.d('getPrice: priceId=$priceId');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-firestore-price-onRetrieve',
  //       {'priceId': priceId},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e('getPriceError', time: DateTime.now(), error: e, stackTrace: st);
  //     rethrow;
  //   }
  // }

  // /// 価格を更新する
  // Future<Map<String, dynamic>> updatePrice(
  //   String priceId,
  //   Map<String, dynamic> data,
  // ) async {
  //   logger.d('updatePrice: priceId=$priceId, data=$data');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-firestore-price-onUpdate',
  //       {'priceId': priceId, 'data': data},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'updatePriceError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// 価格を削除する
  // Future<void> deletePrice(String priceId) async {
  //   logger.d('deletePrice: priceId=$priceId');
  //   try {
  //     await _call<void>('v2-firestore-price-onDelete', {'priceId': priceId});
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'deletePriceError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// Firestore商品を作成する
  // Future<Map<String, dynamic>> createFirestoreProduct(
  //   Map<String, dynamic> data,
  // ) async {
  //   logger.d('createFirestoreProduct: data=$data');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-firestore-product-onCreate',
  //       {'data': data},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'createFirestoreProductError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// Firestore商品を取得する
  // Future<Map<String, dynamic>> getFirestoreProduct(String productId) async {
  //   logger.d('getFirestoreProduct: productId=$productId');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-firestore-product-onRetrieve',
  //       {'productId': productId},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'getFirestoreProductError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// Firestore商品を更新する
  // Future<Map<String, dynamic>> updateFirestoreProduct(
  //   String productId,
  //   Map<String, dynamic> data,
  // ) async {
  //   logger.d('updateFirestoreProduct: productId=$productId, data=$data');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-firestore-product-onUpdate',
  //       {'productId': productId, 'data': data},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'updateFirestoreProductError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // /// Firestore商品を削除する
  // Future<void> deleteFirestoreProduct(String productId) async {
  //   logger.d('deleteFirestoreProduct: productId=$productId');
  //   try {
  //     await _call<void>('v2-firestore-product-onDelete', {
  //       'productId': productId,
  //     });
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'deleteFirestoreProductError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  // invoice settings
  // /// 請求設定を作成する
  // Future<Map<String, dynamic>> createInvoiceSetting(
  //   Map<String, dynamic> data,
  // ) async {
  //   logger.d('createInvoiceSetting: data=$data');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-payment-invoice-settings-onCreate',
  //       {'data': data},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'createInvoiceSettingError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  /// 請求設定を取得する
  // Future<Map<String, dynamic>> getInvoiceSetting(String customerId) async {
  //   logger.d('getInvoiceSetting: customerId=$customerId');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-payment-invoice-settings-onRetrieve',
  //       {'customerId': customerId},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'getInvoiceSettingError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  /// 請求設定を更新する
  // Future<Map<String, dynamic>> updateInvoiceSetting(
  //   String customerId,
  //   Map<String, dynamic> data,
  // ) async {
  //   logger.d('updateInvoiceSetting: customerId=$customerId, data=$data');
  //   try {
  //     final response = await _call<Map<String, dynamic>>(
  //       'v2-payment-invoice-settings-onUpdate',
  //       {'customerId': customerId, 'data': data},
  //     );
  //     return response!;
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'updateInvoiceSettingError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }

  /// 請求設定を削除する
  // Future<void> deleteInvoiceSetting(String customerId) async {
  //   logger.d('deleteInvoiceSetting: customerId=$customerId');
  //   try {
  //     await _call<void>('v2-payment-invoice-settings-onDelete', {
  //       'customerId': customerId,
  //     });
  //   } on Exception catch (e, st) {
  //     logger.e(
  //       'deleteInvoiceSettingError',
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //     );
  //     rethrow;
  //   }
  // }
}
