import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../settings/hooks/use_router.dart';
import '../../../settings/routes/app_route.gr.dart';
import '../stripe_view_model.dart';

@RoutePage()
class SetupIntentWithScaPage extends HookConsumerWidget {
  const SetupIntentWithScaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRoute = useRouter();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Test Cards'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: const Text('pm_card_authenticationRequiredOnSetup'),
              onTap: () async =>
                  await ref.read(stripeViewModelProvider).completeSetupIntent(
                        context,
                        'pm_card_authenticationRequiredOnSetup',
                      ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('pm_card_authenticationRequired'),
              onTap: () async =>
                  await ref.read(stripeViewModelProvider).completeSetupIntent(
                        context,
                        'pm_card_authenticationRequired',
                      ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text(
                'pm_card_authenticationRequiredChargeDeclinedInsufficientFunds',
              ),
              onTap: () async =>
                  await ref.read(stripeViewModelProvider).completeSetupIntent(
                        context,
                        'pm_card_authenticationRequiredChargeDeclinedInsufficientFunds',
                      ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('setup intent'),
              onTap: () => appRoute.push(const InvoiceSettingRoute()),
            ),
          ),
        ],
      ),
    );
  }
}
