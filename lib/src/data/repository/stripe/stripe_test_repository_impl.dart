import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:stripe_sdk/stripe_sdk.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/remove_nulls.dart';
import '../../general_provider.dart';
import 'stripe_repository.dart';

final logger = Logger();

final stripeRepositoryProvider =
    Provider<StripeRepository>(StripeTestRepositoryImpl.new);

//
final publishableKey = dotenv.get('STRIPE_PUBLIC');
String apiVersion = dotenv.get('STRIPE_API_VERSION');
// Stripe stripe = Stripe(
//   publishableKey,
//   // stripeAccount: stripeAccount,
// );
Stripe stripe = Stripe.instance;
// StripeApi stripeApi = StripeApi(publishableKey, apiVersion: apiVersion);
StripeApi stripeApi = StripeApi.instance;

//
final country = dotenv.get('COUNTRY');
final currency = dotenv.get('CURRENCY');
final fee = double.parse(dotenv.get('FEE'));
int calculateFee(int amount) {
  final result = amount * fee;
  return result.floor();
}

//generateIdempotencyKey
String generateIdempotencyKey() {
  final idempotencyKey = const Uuid().v4();
  return idempotencyKey;
}

class StripeTestRepositoryImpl implements StripeRepository {
  StripeTestRepositoryImpl(this._ref);
  final Ref _ref;

  /// Utility function to call a Firebase Function
  Future<T?> _call<T>(String name, Map<dynamic, dynamic> params) async {
    logger.i('Service._call, $name, $params');
    final callable = _ref.read(firebaseFunctionsProvider).httpsCallable(name);
    try {
      final result = await callable.call<T>(params);
      logger.d(result);
      // logger.d(result.data);
      return result.data;
    } on Exception catch (e, st) {
      logger.e('Service._call Error', [e, st]);
      return null;
    }
  }

  // @override
  // stripeInstance() {
  //   // return Stripe(publishableKey);
  //   Stripe.init(publishableKey);
  // }

  // @override
  // stripeApiInstance() {
  //   StripeApi.init(publishableKey, apiVersion: apiVersion);
  // }

  @override
  void customerSession() {
    CustomerSession.initCustomerSession((version) => getEphemeralKey());
  }

  @override
  Future<String> getEphemeralKey() async {
    try {
      final result = await _call<Map<String, dynamic>>(
          'v1-stripe-customer-getEphemeralKey', {
        'apiVersion': apiVersion,
        'idempotencyKey': generateIdempotencyKey(),
      });
      final key = result!['key'];
      final jsonKey = json.encode(key);
      // logger.d('getEphemeralKey', jsonKey);
      return jsonKey;
    } on Exception catch (e, st) {
      logger.e('createCustomerError', [e, st]);
      rethrow;
    }
  }

// Customer
  @override
  Future<String> createCustomer(String email) async {
    try {
      logger.i('createCustomer');

      final params = {
        {
          'email': email,
          // 'metadata': {'uid': uid}
        }
      };

      final result = await _call<Map<String, dynamic>>(
        'v1-stripe-customer-onCreate',
        {
          'params': params,
          'idempotencyKey': generateIdempotencyKey(),
        },
      );

      final customerId = result!['customerId'].toString();
      logger.d(customerId);
      return customerId;
    } on Exception catch (e, st) {
      logger.e('createCustomerError', [e, st]);
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> retrieveCustomer({
    required String customerId,
  }) async {
    try {
      logger.i('retrieveCustomer');

      final callable = _ref
          .read(firebaseFunctionsProvider)
          .httpsCallable('v1-stripe-customer-onRetrieve');
      final functionResult = await callable.call<Map<String, dynamic>>({
        'customerId': customerId,
        'idempotencyKey': generateIdempotencyKey(),
      });

      final data = functionResult.data;
      logger.d(data);
      return data;
    } on Exception catch (e, st) {
      logger.e('retrieveCustomerError', [e, st]);
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> updateCustomer({
    required String customerId,
    required Map<String, dynamic> params,
  }) async {
    try {
      logger.i('updateCustomer');

      logger.d(params);
      params = params.removeNulls() as Map<String, dynamic>;
      logger.d(params);

      final callable = _ref
          .read(firebaseFunctionsProvider)
          .httpsCallable('v1-stripe-customer-onUpdate');
      final functionResult = await callable.call<Map<String, dynamic>>({
        'customerId': customerId,
        'params': params,
        'idempotencyKey': generateIdempotencyKey(),
      });

      final data = functionResult.data;
      logger.d(data);
      return data;
    } on Exception catch (e, st) {
      logger.e('updateCustomerError', [e, st]);
      rethrow;
    }
  }

  @override
  Future<void> deleteCustomer({required String customerId}) async {
    try {
      logger.i('deleteCustomer');

      final callable = _ref
          .read(firebaseFunctionsProvider)
          .httpsCallable('v1-stripe-customer-onDelete');
      final functionResult = await callable.call<Map<String, dynamic>>({
        'customerId': customerId,
        'idempotencyKey': generateIdempotencyKey(),
      });

      final data = functionResult.data;
      final id = data['customerId'].toString();
      logger.d(id);
      // return id;
    } on Exception catch (e, st) {
      logger.e('deleteCustomerError', [e, st]);
      rethrow;
    }
  }

// Account
  @override
  Future<String> createAccount(String email) async {
    try {
      logger.i('createAccount');

      final params = {
        'email': email,
        'settings': {
          'payouts': {
            'schedule': {
              'interval': 'monthly',
              'monthly_anchor': 28,
            },
          },
        },
      };

      final callable = _ref
          .read(firebaseFunctionsProvider)
          .httpsCallable('v1-stripe-account-onCreate');
      final functionResult = await callable.call<Map<String, dynamic>>({
        'params': params,
        'idempotencyKey': generateIdempotencyKey(),
      });

      final data = functionResult.data;
      final accountId = data['accountId'].toString();
      logger.d(accountId);
      return accountId;
    } on Exception catch (e, st) {
      logger.e('createAccountError', [e, st]);
      rethrow;
    }
  }

  @override
  Future<String> retrieveAccount(String accountId) async {
    try {
      logger.i('retrieveAccount');

      final callable = _ref
          .read(firebaseFunctionsProvider)
          .httpsCallable('v1-stripe-account-onRetrieve');
      final functionResult = await callable.call<String>({
        'accountId': accountId,
        'idempotencyKey': generateIdempotencyKey(),
      });

      final data = functionResult.data;
      logger.d(data);
      return data;
    } on Exception catch (e, st) {
      logger.e('retrieveAccountError', [e, st]);
      rethrow;
    }
  }

  @override
  Future<String> updateAccount({
    required String accountId,
    required Map<String, dynamic> params,
  }) async {
    try {
      logger.i('updateAccount');

      final callable = _ref
          .read(firebaseFunctionsProvider)
          .httpsCallable('v1-stripe-account-onUpdate');
      final functionResult = await callable.call<String>({
        'accountId': accountId,
        'params': params,
        'idempotencyKey': generateIdempotencyKey(),
      });

      final data = functionResult.data;
      logger.d(data);
      return data;
    } on Exception catch (e, st) {
      logger.e('updateAccountError', [e, st]);
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount(String accountId) async {
    try {
      logger.i('deleteAccount');

      final callable = _ref
          .read(firebaseFunctionsProvider)
          .httpsCallable('v1-stripe-account-onDelete');
      final functionResult = await callable.call<Map<String, dynamic>>({
        'accountId': accountId,
        'idempotencyKey': generateIdempotencyKey(),
      });

      final data = functionResult.data;
      logger.d(data);
      // return data;
    } on Exception catch (e, st) {
      logger.e('deleteAccountError', [e, st]);
      rethrow;
    }
  }

  @override
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

  // @override
  // Future<String> createBankAccountToken({
  //   required String accountHolderName,
  //   required String accountHolderType,
  //   required String routingNumber,
  //   required String accountNumber,
  // }) async {
  //   // TODO: implement createBankAccountToken
  //   try {
  //     final result = await stripeAPI.createToken(
  //       {
  //         'bank_account': {
  //           'country': country, // 2-letter country code
  //           'currency': currency, // 日本円
  //           'account_holder_name': accountHolderName,
  //           'account_holder_type': accountHolderType,
  //           'routing_number': routingNumber,
  //           'account_number': accountNumber,
  //         },
  //       },
  //     );
  //     final accountBankToken = result['id'];
  //     return accountBankToken;
  //   } catch (e, s) {
  //     logger.e(e, [e, s]);
  //     rethrow;
  //   }
  // }

  @override
  Future<String> createPaymentIntents({required String xxx}) {
    // TODO: implement createPaymentIntents
    throw UnimplementedError();
  }

  // @override
  // Future<String> createPersonToken({
  //   required String firstNameKana,
  //   required String firstNameKanji,
  //   required String lastNameKana,
  //   required String lastNameKanji,
  //   required String dob,
  //   required String addressKana,
  //   required String addressKanji,
  //   required String email,
  //   required String phone,
  //   required String verification,
  //   required String director,
  //   required String owner,
  //   required String representative,
  // }) async {
  //   // TODO: implement createPersonToken
  //   try {
  //     // representative ＆ director
  //     final firstNameKana = firstNameKana;
  //     final firstNameKanji = firstNameKanji;
  //     final lastNameKana = lastNameKana;
  //     final lastNameKanji = lastNameKanji;
  //     final dob = {day: day, month: month, year: year};
  //     final director = director; // 'true' or 'false'

  //     // representative
  //     final country = 'JP'; // 2-letter country code
  //     final addressKana = {
  //       country: country,
  //       // 半角
  //       postal_code: zipKana,
  //       state: stateKana,
  //       city: cityKana,
  //       town: townKana,
  //       line1: line1Kana,
  //       line2: line2Kana,
  //     };
  //     final addressKanji = {
  //       country: country,
  //       // 全角
  //       postal_code: zipKanji,
  //       state: stateKanji,
  //       city: cityKanji,
  //       town: townKanji,
  //       line1: line1Kanji,
  //       line2: line2Kanji,
  //     };
  //     final result = await stripeAPI.createToken({
  //       'person': {
  //         'first_name_kana': firstNameKana,
  //         'first_name_kanji': firstNameKanji,
  //         'last_name_kana': lastNameKana,
  //         'last_name_kanji': lastNameKanji,
  //         'dob': dob,
  //         'address_kana': addressKana,
  //         'address_kanji': addressKanji,
  //         'email': email,
  //         'phone': phone,
  //         'verification': {
  //           'document': verification,
  //         },
  //         'relationship': {
  //           'director': director,
  //           'owner': owner,
  //           'representative': representative,
  //         },
  //       },
  //     });
  //     final personToken = result['id'];
  //     return personToken;
  //   } catch (e, s) {
  //     logger.e(e, [e, s]);
  //     rethrow;
  //   }
  // }
  @override
  Future<Map> createPaymentMethod(Map params) async {
    logger.i('createPaymentMethod');
    try {
      // final params = {
      //   "type": "card",
      //   "card": {
      //     "number": stripeCard.number,
      //     "exp_month": stripeCard.expMonth,
      //     "exp_year": stripeCard.expYear,
      //     "cvc": stripeCard.cvc,
      //   },
      // };
      final paymentMethod = await _call<Map<String, dynamic>>(
          'v1-stripe-paymentMethod-onCreate', {
        'params': params,
      });
      final paymentMethodId = paymentMethod!['id'];
      logger.d(paymentMethodId);
      return paymentMethod;
    } on Exception catch (e, st) {
      logger.e('createPaymentMethodError', [e, st]);
      rethrow;
    }
  }

  @override
  Future<Map> createPaymentMethodFromCard(StripeCard card) async {
    logger.i('createPaymentMethod');

    try {
      final stripeCard = card;

      if (!stripeCard.validateCVC()) {
        throw 'Error CVC not valid.';
      }
      if (!stripeCard.validateDate()) {
        throw 'Error Date not valid.';
      }
      if (!stripeCard.validateNumber()) {
        throw 'Error Number not valid.';
      }

      final paymentMethod =
          await stripeApi.createPaymentMethodFromCard(stripeCard);
      // final params = {
      //   "type": "card",
      //   "card": {
      //     "number": stripeCard.number,
      //     "exp_month": stripeCard.expMonth,
      //     "exp_year": stripeCard.expYear,
      //     "cvc": stripeCard.cvc,
      //   },
      // };
      // final callable = _ref
      //     .read(firebaseFunctionsProvider)
      //     .httpsCallable('v1-stripe-paymentMethod-onCreate');
      // final functionResult = await callable.call<Map<String, dynamic>>({
      //   'params': params,
      // });
      // final data = functionResult.data;
      // final String paymentMethodId = data['paymentMethodId'];
      final paymentMethodId = paymentMethod['id'];
      logger.d(paymentMethodId);
      return paymentMethod;
    } on Exception catch (e, st) {
      logger.e('createPaymentMethodError', [e, st]);
      rethrow;
    }
  }

  @override
  Future<String> attachPaymentMethod(String paymentMethodId) async {
    try {
      final response = await _call<Map<String, dynamic>>(
          'v1-stripe-paymentMethod-onAttach', {
        'paymentMethodId': paymentMethodId,
      });
      return response!['id'].toString();
    } on Exception catch (e, st) {
      logger.e('attachPaymentMethod', [e, st]);
      rethrow;
    }
  }

  @override
  Future<IntentClientSecret> createSetupIntent() async {
    try {
      final params = {
        'idempotencyKey': generateIdempotencyKey(),
      };
      final response = await _call<Map<String, dynamic>>(
        'v1-stripe-setupIntent-onCreate',
        params,
      );
      return IntentClientSecret(
        response!['status'].toString(),
        response['clientSecret'].toString(),
      );
    } on Exception catch (e, st) {
      logger.e('createPaymentIntentError', [e, st]);
      rethrow;
    }
  }

  @override
  Future<IntentClientSecret> createSetupIntentWithPaymentMethod(
    paymentMethod,
    String? returnUrl,
  ) async {
    final params = {
      'confirm': true,
      'paymentMethod': paymentMethod,
      'idempotencyKey': generateIdempotencyKey(),
    };
    if (returnUrl != null) {
      params.addAll({
        'returnUrl': stripe.getReturnUrlForSca(webReturnUrl: returnUrl),
        // 'returnUrl':
        //     stripe.getReturnUrlForSca(webReturnUrl: 'https://tliny.spel1.com')
      });
      logger.d(stripe.getReturnUrlForSca(webReturnUrl: returnUrl));
    }
    final response = await _call<Map<String, dynamic>>(
      'v1-stripe-setupIntent-onCreate',
      params,
    );
    return IntentClientSecret(
      response!['status'].toString(),
      response['clientSecret'].toString(),
    );
  }

  @override
  Future<Map> retrieveSetupIntent(String clientSecret) async {
    try {
      final result = await stripeApi.retrieveSetupIntent(clientSecret);
      // final callable = _ref
      //     .read(firebaseFunctionsProvider)
      //     .httpsCallable('v1-stripe-setupIntent-onRetrieve');
      // final functionResult = await callable.call<Map<String, dynamic>>({
      //   'clientSecret': clientSecret,
      //   'idempotencyKey': generateIdempotencyKey(),
      // });
      // final data = functionResult.data;
      return result;
    } on Exception catch (e, st) {
      logger.e('createPaymentIntentError', [e, st]);
      rethrow;
    }
  }

  @override
  Future<String> updateSetupIntent({
    required String clientSecret,
    required Map params,
  }) async {
    try {
      final callable = _ref
          .read(firebaseFunctionsProvider)
          .httpsCallable('v1-stripe-setupIntent-onUpdate');
      final functionResult = await callable.call<Map<String, dynamic>>(params);
      final data = functionResult.data;
      final clientSecret = data['clientSecret'].toString();
      return clientSecret;
    } on Exception catch (e, st) {
      logger.e('createPaymentIntentError', [e, st]);
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> confirmSetupIntent(String clientSecret) async {
    final result =
        await _call<Map<String, dynamic>>('v1-stripe-setupIntent-onConfirm', {
      'clientSecret': clientSecret,
      'idempotencyKey': generateIdempotencyKey(),
    });
    return result!;
  }

  @override
  Future<IntentClientSecret> createAutomaticPaymentIntent({
    int? amount,
    String? returnUrl,
  }) async {
    final response = await _call<Map<String, dynamic>>(
        'v1-stripe-paymentIntent-onCreateAutomatic', {
      'amount': amount,
      'currency': currency,
      'returnUrl': returnUrl,
    });
    return IntentClientSecret(
      response!['status'].toString(),
      response['client_secret'].toString(),
    );
  }

  @override
  Future<Map<String, dynamic>> createManualPaymentIntent(
    int amount,
    String paymentMethod,
    // String email,
    String returnUrl,
  ) async {
    final response = await _call<Map<String, dynamic>>(
        'v1-stripe-paymentIntent-onCreateManual', {
      'amount': amount,
      'paymentMethod': paymentMethod,
      'returnUrl': returnUrl,
      // 'returnUrl': stripe.getReturnUrlForSca(webReturnUrl: returnUrlForSca),
      // 'email': email,
      'currency': currency,
    });
    return response!;
  }

  @override
  Future<Map<String, dynamic>> confirmPayment(
    String paymentId,
    String paymentMethodId,
  ) async {
    // final response= await stripe.confirmPayment(clientSecret, context,paymentMethodId: paymentMethodId,);
    final response =
        await _call<Map<String, dynamic>>('v1-stripe-paymentIntent-onConfirm', {
      'paymentId': paymentId,
      'paymentMethodId': paymentMethodId,
    });
    return response!;
  }

  @override
  Future<IntentClientSecret> createPaymentIntent({Map? params}) async {
    try {
      // final params = {'amount': 123, 'currency': 'JPY'};
      // final params = {
      //   'amount': amount,
      //   'currency': currency,
      //   'setup_future_usage': 'off_session',
      //   'payment_method_types': ['card'],
      //   'payment_method' : payment_method_id,
      //   'transfer_group': '{ORDER_NO}',
      //
      //   'customer': customer,
      //   'receipt_email': email,
      //
      //   'application_fee_amount': calculateFee(amount),
      //
      //   'confirm': True
      // };
      // final callable = _ref
      //     .read(firebaseFunctionsProvider)
      //     .httpsCallable('v1-stripe-paymentIntent-onCreate');
      final functionResult = await _call<Map<String, dynamic>>(
          'v1-stripe-paymentIntent-onCreate', {
        'params': params,
      });
      // final data = functionResult.data;
      // final String clientSecret = data['clientSecret'];
      return IntentClientSecret(
        functionResult!['status'].toString(),
        functionResult['client_secret'].toString(),
      );
    } on Exception catch (e, st) {
      logger.e('createPaymentIntentError', [e, st]);
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> retrievePaymentIntent({
    required String clientSecret,
  }) async {
    final paymentIntentRes =
        await stripeApi.retrievePaymentIntent(clientSecret);
    return paymentIntentRes;
  }

  @override
  Future<Map<String, dynamic>> confirmPaymentIntent({
    required String clientSecret,
    String? paymentMethodId,
  }) async {
    try {
      final paymentIntentRes =
          await stripeApi.confirmPaymentIntent(clientSecret);
      return paymentIntentRes;
    } on Exception catch (e, st) {
      logger.e('confirmPaymentIntentError', [e, st]);
      rethrow;
    }
  }

  @override
  Future<String> setupCheckoutSession() async {
    try {
      final params = {
        'successUrl': dotenv.get('CHECKOUT_SUCCESS_URL'),
        'cancelUrl': dotenv.get('CHECKOUT_CANCEL_URL'),
      };
      final response = await _call<Map<String, dynamic>>(
        'v1-method-checkout-onSetup',
        params,
      );
      return response!['url'].toString();
    } on Exception catch (e, st) {
      logger.e('SetupCheckoutSessionError', [e, st]);
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> paymentCheckoutSession(
    String organizerId,
    String orderId,
    List lineItems,
  ) async {
    try {
      final params = {
        'organizerId': organizerId,
        'orderId': orderId,
        'lineItems': lineItems,
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

  @override
  Future<Map<String, dynamic>> retrieveCheckoutSession(String sessionId) async {
    try {
      final checkoutSession = await _call<Map<String, dynamic>>(
        'v1-method-checkout-onRetrieve',
        {'checkoutSessionId': sessionId},
      );
      logger.i(checkoutSession);
      return checkoutSession!;
    } on Exception catch (e, st) {
      logger.e('retrieveCheckoutSessionError', [e, st]);
      rethrow;
    }
  }

  @override
  Future<Map> invoiceSetting(StripeCard card) async {
    logger.i('invoiceSetting');

    try {
      final stripeCard = card;

      if (!stripeCard.validateCVC()) {
        throw 'Error CVC not valid.';
      }
      if (!stripeCard.validateDate()) {
        throw 'Error Date not valid.';
      }
      if (!stripeCard.validateNumber()) {
        throw 'Error Number not valid.';
      }
      final uid = _ref.watch(firebaseAuthProvider).currentUser?.uid;

      final paymentMethod =
          await stripeApi.createPaymentMethodFromCard(stripeCard);
      final paymentMethodId = paymentMethod['id'];
      logger.d(paymentMethodId);

      if (uid == null) {
        throw Exception(['no uid']);
      }
      final clientSecret = await _ref
          .read(firebaseFirestoreProvider)
          .collection('/v/1/stripe_customers')
          .doc(uid)
          .get()
          .then((value) => value.get('setup_secret').toString());
      logger.d(clientSecret);

      final setupIntent = await stripeApi.retrieveSetupIntent(clientSecret);
      final setupIntentId = setupIntent['id'];
      logger.d(setupIntent);
      //
      // await _call<Map<String, dynamic>>(
      //     'v1-stripe-setupIntent-onCancel', {"setupIntentId": setupIntentId});

      // final updateSetupIntentResponse =
      //     await _call<Map<String, dynamic>>('v1-stripe-setupIntent-onUpdate', {
      //   "paymentMethodId": paymentMethodId,
      //   "setupIntentId": setupIntentId,
      // });
      // logger.d(updateSetupIntentResponse);
      final createSetupIntent = await _call<Map<String, dynamic>>(
        'v1-stripe-setupIntent-onCreate',
        {'paymentMethod': paymentMethodId, 'usage': 'off_session'},
      );
//
      final setupConfirm = await stripeApi
          .confirmSetupIntent(createSetupIntent!['clientSecret'].toString());
      logger.d(setupConfirm);

      await _call<Map<String, dynamic>>(
        'v1-stripe-paymentMethod-onAttach',
        {'paymentMethodId': paymentMethodId},
      );

      final response = await _call<Map<String, dynamic>>(
        'v1-method-invoiceSetting-onCreate',
        {'paymentMethodId': paymentMethodId},
      );

      await _ref
          .read(firebaseFirestoreProvider)
          .collection('/v/1/stripe_customers')
          .doc(uid)
          .update({'setup_secret': createSetupIntent['clientSecret']});

      return response!;
      // await _call<Map<String, dynamic>>('v1-stripe-paymentMethod-onAttach',
      //     {"paymentMethodId": 'pm_1MWRlSLwja1iacqrWw3OuypY'});
      // return {};
    } on Exception catch (e, st) {
      logger.e('createPaymentMethodError', [e, st]);
      rethrow;
    }
  }
}
