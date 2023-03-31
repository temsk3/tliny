import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:stripe_sdk/stripe_sdk.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';

final logger = Logger();

@RoutePage()
class PaymentMethodPage extends HookConsumerWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaymentMethodsScreen(
      paymentMethodStore:
          PaymentMethodStore(customerSession: CustomerSession.instance),
    );
  }
}
