import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:tliny/src/ui/program/program_state.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_router.dart';
import '../../settings/routes/app_route.gr.dart';
import '../common/asyncvalue_widget.dart';
import '../common/main_body.dart';
import 'history_view_model.dart';

final logger = Logger();

@RoutePage()
class UsageHistoryPage extends HookConsumerWidget {
  const UsageHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    // final appMQ = useMediaQuery();
    final state = ref.watch(usageHistoryViewModelProvider);
    final viewModel = ref.watch(usageHistoryViewModelProvider.notifier);
    return AsyncValueWidget(
      value: state,
      data: (data) {
        logger.d(data);
        return Scaffold(
          appBar: AppBar(
            title: const Text('UsageHistory'),
            leading: const AutoLeadingButton(),
          ),
          body: MainBodyWidget(
            body: data.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(24),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemExtent: 100,
                    itemCount: data.length,
                    itemBuilder: (_, index) {
                      final usageHistory = data[index];
                      final programAsyncValue =
                          ref.watch(programListStateProvider);
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
                        title: Text(l10n.dataTime(usageHistory.dateOfUse!)),
                        subtitle: Text(name),
                        onTap: () => appRoute.push(
                          UsageHistoryDetailsRoute(
                            list: usageHistory.useTicket!,
                          ),
                        ),
                      );
                    },
                  )
                : Container(),
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
}
