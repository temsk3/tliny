import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/l10n/app_localizations.dart';
import 'package:tliny/src/ui/program/program_state.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../settings/routes/routes.dart';
import '../../utils/logger.dart';
import '../common/asyncvalue_widget.dart';
import '../common/main_body.dart';
import 'history_view_model.dart';

// final logger = Logger();

// @RoutePage()
class UsageHistoryPage extends HookConsumerWidget {
  const UsageHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    // final appRoute = useRouter();
    // final appMQ = useMediaQuery();
    final state = ref.watch(usageHistoryViewModelProvider);
    final viewModel = ref.watch(usageHistoryViewModelProvider.notifier);
    return AsyncValueWidget(
      value: state,
      data: (data) {
        if (data.isNotEmpty) {
          data.sort((a, b) => -a.dateOfUse!.compareTo(b.dateOfUse!));
        }
        logger.d(data);
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.usageHistory),
            // leading: const AutoLeadingButton(),
          ),
          body: MainBodyWidget(
            body:
                data.isNotEmpty
                    ? ListView.builder(
                      padding: const EdgeInsets.all(24),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemExtent: 100,
                      itemCount: data.length,
                      itemBuilder: (_, index) {
                        final usageHistory = data[index];
                        final programAsyncValue = ref.watch(
                          programListStateProvider,
                        );
                        final programList = programAsyncValue.value;
                        String name;
                        if (programList == null) {
                          name = '';
                        }
                        final program = programList!.firstWhere(
                          (element) => element.id == usageHistory.eventId,
                        );
                        name = program.name!;
                        return ListTile(
                          title: Text(
                            '${l10n.date(usageHistory.dateOfUse!)} ${l10n.time(usageHistory.dateOfUse!)}',
                          ),
                          subtitle: Text(name),
                          onTap:
                              () =>
                              // appRoute.push(
                              UsageHistoryDetailsRoute(
                                $extra: usageHistory.useTicket!,
                              ).push(context),
                          // ),
                        );
                      },
                    )
                    : _buildEmptyHistoryWidget(context, l10n),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     viewModel.addUsageHistory(UsageHistory.empty());
          //   },
          //   child: const Icon(Icons.add),
          // ),
        );
      },
    );
  }

  Widget _buildEmptyHistoryWidget(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 20),
          Text(
            '使用履歴がありません',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'チケットを使用すると、ここに履歴が表示されます',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
