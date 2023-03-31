import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/ui/common/asyncvalue_widget.dart';
import 'package:tliny/src/ui/ticket/ticket_state.dart';
import 'package:tliny/src/ui/usage_history/history_view_model.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../../settings/hooks/use_router.dart';
import '../../settings/theme/app_theme.dart';
import '../ticket/ticket_view_model.dart';
import 'qr_scan_page.dart';

@RoutePage()
class QRDetailPage extends HookConsumerWidget {
  const QRDetailPage({
    super.key,
    required this.eventId,
  });
  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final appMediaQuery = useMediaQuery();

    final qrContents = ref.watch(qrContentsProvider);
    final data = qrContents as List<String>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QRコード詳細'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              ref
                  .watch(ticketViewModelProvider.notifier)
                  .usageTicket(qrContents);

              ref
                  .watch(usageHistoryViewModelProvider.notifier)
                  .addUsageHistory(eventId, data);
            },
            child: const Text('完了'),
          ),
          // const Divider(),
          Expanded(
            child: data.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.all(24),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (_, index) {
                      final id = data.toList()[index];

                      return AsyncValueWidget(
                        value: ref.watch(ticketStateProvider(id)),
                        data: (ticket) {
                          return ListTile(
                            title: Text(ticket.name!),
                          );
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
