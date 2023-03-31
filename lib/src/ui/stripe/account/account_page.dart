import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../settings/hooks/use_router.dart';
import '../../../settings/routes/app_route.gr.dart';
import 'account_view_model.dart';

final logger = Logger();

const email = 'temsk3@gmail.com';

@RoutePage()
class AccountPage extends HookConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRoute = useRouter();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ConnectAccount'),
      ),
      body: SafeArea(
        // child: Center(
        child:
            //  Column(children: [
            //
            ListView(
          children: <Widget>[
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    appRoute.pop(const StripeRoute());
                  },
                  child: const Text('pop'),
                ),
              ],
            ),
            Card(
              child: ListTile(
                title: const Text('ConnectAccount create link'),
                onTap: () => ref
                    .read(stripeAccountViewModelProvider)
                    .getAccountLink(email),
              ),
            ),
            Card(
              child: ListTile(title: const Text(''), onTap: () {}),
            ),
            // ]),
          ],
        ),
        // ),
      ),
    );
  }
}
