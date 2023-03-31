import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../data/repository/stripe/stripe_test_repository_impl.dart';
import '../../settings/hooks/use_router.dart';
import '../../settings/routes/app_route.gr.dart';

final logger = Logger();

@RoutePage()
class StripePage extends HookConsumerWidget {
  const StripePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRoute = useRouter();
    useEffect(
      () {
        ref.read(stripeRepositoryProvider).customerSession();
        return null;
        // return CustomerSession.instance.isDisposed;
      },
      [],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe SDK Demo'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: const Text('Customer Details'),
              onTap: () => appRoute.push(const EditCustomerRoute()),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Payment Methods Screen'),
              onTap: () => appRoute.push(const PaymentMethodRoute()),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Add Stripe Test Card'),
              onTap: () => appRoute.push(const SetupIntentWithScaRoute()),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Payments'),
              onTap: () => appRoute.push(const PaymentRoute()),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Account'),
              onTap: () => appRoute.push(const AccountRoute()),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Checkout'),
              onTap: () => appRoute.push(const CheckoutRoute()),
            ),
          ),
        ],
      ),
    );
  }
}
