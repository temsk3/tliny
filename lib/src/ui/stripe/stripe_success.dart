import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SuccessPage extends HookConsumerWidget {
  const SuccessPage({
    super.key,
    @QueryParam('payment_intent_client_secret') required this.clientSecret,
  });

  final String? clientSecret;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.read(stripeViewModelProvider);
    String text;
    if (clientSecret != null) {
      text = clientSecret as String;
    } else {
      text = 'null';
    }
    return Scaffold(
      body: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
