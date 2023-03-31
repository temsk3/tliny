import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:stripe_sdk/stripe_sdk.dart';

import '../../../settings/hooks/use_router.dart';
import '../../../settings/routes/app_route.gr.dart';
import '../stripe_view_model.dart';

final logger = Logger();

@RoutePage()
class PaymentPage extends HookConsumerWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRoute = useRouter();

    Stripe.instance.getReturnUrlForSca(webReturnUrl: 'https://tliny.spel1.com');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: const Text('Automatic confirmation (3DS2)'),
              onTap: () => ref
                  .read(stripeViewModelProvider)
                  .createAutomaticPaymentIntent(context, 500),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Manual confirmation (3DS2)'),
              onTap: () => ref
                  .read(stripeViewModelProvider)
                  .createManualPaymentIntent(context),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Checkout (WIP)'),
              onTap: () => appRoute.push(const PaymentCheckoutRoute()),
            ),
          ),
        ],
      ),
    );
  }
}
