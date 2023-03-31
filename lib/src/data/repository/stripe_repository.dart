import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../general_provider.dart';

part 'stripe_repository.g.dart';

final logger = Logger();

// ProgramRepositoryProvider
@Riverpod(keepAlive: true)
StripeRepository stripeRepository(StripeRepositoryRef ref) {
  return StripeRepository(ref.watch(firebaseFunctionsProvider));
}

class StripeRepository {
  StripeRepository(this._func);
  final FirebaseFunctions _func;

  Future<T?> _call<T>(String name, Map<dynamic, dynamic> params) async {
    logger.i('Service._call, $name, $params');
    final callable = _func.httpsCallable(name);
    try {
      final result = await callable.call<T>(params);
      logger.d(result);
      return result.data;
    } on Exception catch (e, st) {
      logger.e('Service._call Error', [e, st]);
      return null;
    }
  }

// checkout
  Future<Map<String, dynamic>> paymentCheckoutSession(
    String eventId,
  ) async {
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
      logger.e('PaymentCheckoutSessionError', [e, st]);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> retrieveCheckoutSession(String sessionId) async {
    try {
      final checkoutSession = await _call<Map<String, dynamic>>(
        'v1-method-checkout-onRetrieve',
        {'checkoutSessionId': sessionId},
      );
      logger.d(checkoutSession);
      return checkoutSession!;
    } on Exception catch (e, st) {
      logger.e('retrieveCheckoutSessionError', [e, st]);
      rethrow;
    }
  }

  // account
  Future<String> retrieveAccount(String accountId) async {
    try {
      logger.i('retrieveAccount');

      final response = await _call<Map<String, dynamic>>(
        'v1-stripe-account-onRetrieve',
        {'accountId': accountId},
      );
      final chargesEnabled = response!['charges_enabled'].toString();
      return chargesEnabled;
    } on Exception catch (e, st) {
      logger.e('retrieveAccountError', [e, st]);
      rethrow;
    }
  }

  Future<String> getAccountLink(
    String email,
  ) async {
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
      logger.e('getAccountLinkError', [e, st]);
      rethrow;
    }
  }
}
