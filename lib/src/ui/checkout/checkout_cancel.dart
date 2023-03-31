import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class CheckoutCancelPage extends HookConsumerWidget {
  const CheckoutCancelPage({
    super.key,
    @QueryParam('session_id') required this.sessionId,
  });

  final String? sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.read(stripeViewModelProvider);
    String text;
    if (sessionId != null) {
      text = sessionId as String;
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
