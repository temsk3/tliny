import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_router.dart';
import '../../ui/usage_history/history_state.dart';
import '../common/asyncvalue_widget.dart';
import '../common/main_body.dart';
import 'history_view_model.dart';

final logger = Logger();

@RoutePage()
class UsageHistoryDetailsPage extends HookConsumerWidget {
  const UsageHistoryDetailsPage({super.key, required this.list});
  final List<String> list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    // final appMQ = useMediaQuery();
    // final state = ref.watch(ticketStreamStateProvider(list[index]));
    final viewModel = ref.watch(usageHistoryViewModelProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('UsageHistory'),
        leading: const AutoLeadingButton(),
      ),
      body: MainBodyWidget(
        body: ListView.separated(
          padding: const EdgeInsets.all(24),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (_, index) {
            final ticketId = list[index];
            return AsyncValueButtonWidget(
              value: ref.watch(ticketStreamStateProvider(ticketId)),
              data: (data) {
                return ListTile(
                  title: Text(data.name!),
                );
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }
}
