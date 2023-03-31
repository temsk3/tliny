import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';

import '../../../data/repository/stripe/stripe_test_repository_impl.dart';

final logger = Logger();

@RoutePage()
class PaymentCheckoutPage extends ConsumerWidget {
  const PaymentCheckoutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final appRoute = useRouter();
    final params = {
      'amount': 990,
      'currency': 'JPY',
    };
    Future<IntentClientSecret> createPaymentIntent() {
      return ref
          .read(stripeRepositoryProvider)
          .createPaymentIntent(params: params);
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CheckoutPage(createPaymentIntent: createPaymentIntent),
        ),
      ),
    );
  }
}
