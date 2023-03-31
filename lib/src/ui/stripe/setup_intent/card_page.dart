import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';

import '../../../settings/hooks/use_router.dart';
import 'setup_intent_view_model.dart';

@RoutePage()
class InvoiceSettingPage extends HookConsumerWidget {
  const InvoiceSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    // final l10n = useL10n();
    final appRoute = useRouter();
    // final appMQ = useMediaQuery();

    // var screenSize = appMQ.size;

    final formKey = GlobalKey<FormState>();
    final card = StripeCard();

    return Scaffold(
      appBar: AppBar(
        title: const Text('card'),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    // child: CardField(),
                  ),
                  const SizedBox(height: 100),
                  CardForm(
                    formKey: formKey,
                    card: card,
                    displayAnimatedCard: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      // onPressed: _handlePayPress,
                      onPressed: () async {
                        formKey.currentState!.validate();
                        formKey.currentState!.save();
                        await ref
                            .read(stripeSetupIntentViewModelProvider)
                            .invoiceSetting(card);
                        await appRoute.pop();
                      },
                      child: const Text('setup'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // floatingActionButton: Visibility(
      //   child: FloatingActionButton(
      //     onPressed: () async {},
      //     child: const Icon(Icons.add_sharp),
      //   ),
      // ),
    );
  }
}
