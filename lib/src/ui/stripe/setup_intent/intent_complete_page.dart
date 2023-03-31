import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class IntentCompletePage extends StatelessWidget {
  const IntentCompletePage({
    super.key,
    @QueryParam('payment_intent_client_secret') required this.clientSecret,
  });

  final String? clientSecret;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3DS intent completed'),
      ),
      body: const Text('complete'),
    );
  }
}
