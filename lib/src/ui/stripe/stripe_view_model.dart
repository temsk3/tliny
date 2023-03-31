import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:stripe_sdk/stripe_sdk.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';

import '../../data/general_provider.dart';
import '../../data/repository/stripe/stripe_test_repository_impl.dart';
import '../../utils/progress_bar.dart';

final logger = Logger();

final stripeViewModelProvider = Provider(StripeViewModel.new);

class StripeViewModel {
  StripeViewModel(this._ref);
  final Ref _ref;

  //
  // Card set
  Future<Map> setPaymentMethod(StripeCard card) async {
    try {
      final uid = _ref.watch(firebaseAuthProvider).currentUser?.uid;
      if (uid == null) {
        throw Exception(['no login']);
      }
      final clientSecret = await _ref
          .read(firebaseFirestoreProvider)
          .collection('/v/1/stripe_customer')
          .doc(uid)
          .get()
          .then((value) => value.get('client_secret').toString());
      // カード情報の登録
      final paymentMethodId = await _ref
          .read(stripeRepositoryProvider)
          .createPaymentMethodFromCard(card);
      // 支払い方法の登録
      final params = {
        'metadata': {'user_id': uid},
        'payment_method': paymentMethodId,
      };
      await _ref
          .read(stripeRepositoryProvider)
          .updateSetupIntent(clientSecret: clientSecret, params: params);
      // 登録確認
      final result = await _ref
          .read(stripeRepositoryProvider)
          .retrieveSetupIntent(clientSecret);
      logger.d(result);
      return result;
    } on Exception catch (e, st) {
      logger.e('setPaymentMethodError', [e, st]);
      rethrow;
    }
  }

//
  Future<void> addPaymentMethod(
    BuildContext context,
    StripeCard cardData,
  ) async {
    try {
      final stripeRepository = _ref.read(stripeRepositoryProvider);
      final customerSession = CustomerSession.instance;
      var paymentMethod =
          await stripeRepository.createPaymentMethodFromCard(cardData);
      paymentMethod = await customerSession
          .attachPaymentMethod(paymentMethod['id'].toString());
      final createSetupIntentResponse = await stripeRepository
          .createSetupIntentWithPaymentMethod(paymentMethod['id'], null);
      Navigator.pop(context);

      if (createSetupIntentResponse.status == 'succeeded') {
        Navigator.pop(context, true);
        return;
      }
      final setupIntent = await stripeRepository
          .confirmSetupIntent(createSetupIntentResponse.clientSecret);

      if (setupIntent['status'] == 'succeeded') {
        Navigator.pop(context, true);
        return;
      }
    } catch (e, st) {
      logger.e('setPaymentMethodError', [e, st]);
      rethrow;
    }
  }

//
//
  Future<void> completeSetupIntent(
    BuildContext context,
    String paymentMethod,
  ) async {
    logger.d('completeSetupIntent Start');

    showProgressDialog(context);
    final stripe = Stripe.instance;
    // RouteSettings? routeSettings = ModalRoute.of(context)?.settings;
    // final returnUrl = routeSettings?.name;
    const returnUrl = 'https://tliny.spel1.com';
    final createSetupIntentResponse = await _ref
        .read(stripeRepositoryProvider)
        .createSetupIntentWithPaymentMethod(
          paymentMethod,
          returnUrl,
        );
    final paymentMethods =
        PaymentMethodStore(customerSession: CustomerSession.instance);
    if (createSetupIntentResponse.status == 'succeeded') {
      hideProgressDialog(context);
      Navigator.pop(context, true);

      /// A new payment method has been attached, so refresh the store
      final _ = paymentMethods.refresh();

      logger.d('completeSetupIntent Succeeded');

      return;
    }
    final setupIntent = await stripe.authenticateSetupIntent(
      createSetupIntentResponse.clientSecret,
      webReturnPath: returnUrl,
      context: context,
    );
    hideProgressDialog(context);
    logger.d('completeSetupIntent Succeeded');
    Navigator.pop(context, setupIntent['status'] == 'succeeded');
  }

  Future checkout(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          const amount = 100;
          // ignore: deprecated_member_use
          return CheckoutPage(
//        paymentMethods: paymentMethods.paymentMethods.map((e) => PaymentMethod(e.id, e.last4)),
            createPaymentIntent: _ref
                .read(stripeRepositoryProvider)
                .createAutomaticPaymentIntent,
          );
        },
      ),
    );
  }

  Future<void> createAutomaticPaymentIntent(
    BuildContext context,
    int amount,
  ) async {
    final stripe = Stripe.instance;
    final response = await _ref
        .read(stripeRepositoryProvider)
        .createAutomaticPaymentIntent(amount: amount);
    if (response.status == 'succeeded') {
      // TODO: success
      logger.d('Success before authentication.');
      return;
    }
    final result = await stripe.confirmPayment(
      response.clientSecret,
      context,
      paymentMethodId: 'pm_card_threeDSecure2Required',
    );
    if (result['status'] == 'succeeded') {
      // TODO: success
      logger.d('Success after authentication.');
      return;
    } else {
      logger.e('Error');
    }
  }

  Future<void> createManualPaymentIntent(BuildContext context) async {
    // final stripe = _ref.read(stripeRepositoryProvider).stripeInstance();
    final stripe = Stripe.instance;
    final response =
        await (_ref.read(stripeRepositoryProvider).createManualPaymentIntent(
              10000,
              'pm_card_threeDSecure2Required',
              Stripe.instance
                  .getReturnUrlForSca(webReturnUrl: 'https://google.com'),
            ) as FutureOr<Map<dynamic, dynamic>>);
    if (response['status'] == 'succeeded') {
      // TODO: success
      logger.d('Success before authentication.');
      return;
    }
    final result = await stripe.authenticatePayment(
      response['clientSecret'].toString(),
      context,
    );
    if (result['status'] == 'requires_confirmation') {
      // TODO: make call to server to confirm
      logger.d('Success after authentication.');
      return;
    } else {
      logger.e('Error');
    }
  }
}
