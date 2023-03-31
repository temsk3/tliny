import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:stripe_sdk/stripe_sdk.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';

import '../../../data/general_provider.dart';
import '../../../data/repository/stripe/stripe_test_repository_impl.dart';

final logger = Logger();

final stripeSetupIntentViewModelProvider =
    Provider(StripeSetupIntentViewModel.new);

class StripeSetupIntentViewModel {
  StripeSetupIntentViewModel(this._ref);
  final Ref _ref;

  //
  // Card set
  Future<Map> setPaymentMethod(StripeCard card) async {
    try {
      final uid = _ref.watch(firebaseAuthProvider).currentUser?.uid;
      if (uid == null) {
        throw Exception(['no uid']);
      }
      final clientSecret = await _ref
          .read(firebaseFirestoreProvider)
          .collection('/v/1/stripe_customer')
          .doc(uid)
          .get()
          .then((value) => value.get('client_secret').toString());
      // カード情報の登録
      final paymentMethod = await _ref
          .read(stripeRepositoryProvider)
          .createPaymentMethodFromCard(card);
      // 支払い方法の登録
      final params = {
        'paymentMethod': paymentMethod['id'],
      };
      await _ref
          .read(stripeRepositoryProvider)
          .updateSetupIntent(clientSecret: clientSecret, params: params);
      //
      await _ref
          .read(stripeRepositoryProvider)
          .attachPaymentMethod(paymentMethod['id'].toString());
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

  Future<void> invoiceSetting(StripeCard card) async {
    await _ref.read(stripeRepositoryProvider).invoiceSetting(card);
  }

  Future<void> completeSetupIntent(
    BuildContext context,
    String paymentMethod,
  ) async {
    logger.d('completeSetupIntent Start');

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
      Navigator.pop(context, true);

      /// A new payment method has been attached, so refresh the store
      final _ = paymentMethods.refresh();

      logger.d('completeSetupIntent Succeeded');

      return;
    }
    final stripe = Stripe.instance;
    final setupIntent = await stripe.authenticateSetupIntent(
      createSetupIntentResponse.clientSecret,
      webReturnPath: returnUrl,
      context: context,
    );
    logger.d('completeSetupIntent Succeeded');
    Navigator.pop(context, setupIntent['status'] == 'succeeded');
  }
}
