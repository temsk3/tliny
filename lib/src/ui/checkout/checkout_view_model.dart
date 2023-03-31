import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';

import '../../data/repository/stripe_repository.dart';
import '../../settings/routes/app_route.gr.dart';

final logger = Logger();

final stripeCheckoutViewModelProvider = Provider(StripeCheckoutViewModel.new);

class StripeCheckoutViewModel {
  StripeCheckoutViewModel(this._ref);
  final Ref _ref;

  Future<void> sendUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), webOnlyWindowName: '_self');
    } else {
      logger.e('Could not launch URL');
      final Error error = ArgumentError('Error launching $url');
      throw error;
    }
  }

  //
  Future<void> getCheckoutPaymentLink(
    StackRouter appRoute,
    BuildContext context,
    String eventId,
  ) async {
    try {
      logger.i('getCheckoutPaymentLink');
      final response =
          await _ref.read(stripeRepositoryProvider).paymentCheckoutSession(
                eventId,
              );
      final url = response['url'].toString();
      final sessionId = response['checkoutSessionId'].toString();
      logger.i(url);
      if (context.mounted) {
        await paymentWithBrowser(appRoute, context, url, sessionId);
      }
      return;
      // return [url, sessionId];
    } on Exception catch (e, st) {
      logger.e('getCheckoutPaymentLinkError', [e, st]);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> paymentWithBrowser(
    StackRouter appRoute,
    BuildContext context,
    String url,
    String sessionId,
  ) async {
    final completer = Completer<Map<String, dynamic>>();

    late StreamSubscription<html.Event> subscription;
    subscription = html.window.onFocus.listen((event) async {
      final intent = await _ref
          .read(stripeRepositoryProvider)
          .retrieveCheckoutSession(sessionId);
      if (intent['payment_status'] != 'unpaid') {
        await appRoute.replace(CheckoutSuccessRoute(sessionId: sessionId));
        await subscription.cancel();
        await Future.delayed(const Duration(seconds: 1));
        completer.complete(intent);
        return;
      }
    });
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => SimpleDialog(
        title: const Text(
          'awaiting payment. Complete the payment in the window that opens.',
        ),
        children: [
          SimpleDialogOption(
            child: const Text('Cancel'),
            onPressed: () {
              // appRoute.pop()

              // キャンセル処理

              appRoute.replace(CheckoutCancelRoute(sessionId: sessionId));
              subscription.cancel();
              completer.complete(
                _ref
                    .read(stripeRepositoryProvider)
                    .retrieveCheckoutSession(sessionId),
              );
              logger.d('cancel');
            },
          ),
          SimpleDialogOption(
            child: const Text('Open new window'),
            onPressed: () {
              launchUrl(Uri.parse(url));
              logger.d('open new window');
            },
          )
        ],
      ),
    );

    await launchUrl(Uri.parse(url));

    return completer.future;
  }
}
