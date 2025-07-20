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
    final theme = Theme.of(context);
    final l10n = useL10n();
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
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            title: Text(
              l10n.usageHistory,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            surfaceTintColor: Colors.transparent,
          ),
          body: MainBodyWidget(
            body:
                data.isNotEmpty
                    ? _buildHistoryList(context, ref, data, l10n, theme)
                    : _buildEmptyHistoryWidget(context, l10n, theme),
          ),
        );
      },
    );
  }

  Widget _buildHistoryList(
    BuildContext context,
    WidgetRef ref,
    List<dynamic> data,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (_, index) {
        final usageHistory = data[index];
        logger.d('Processing usage history: ${usageHistory.eventId}');

        final programAsyncValue = ref.watch(programsStateProvider);
        final programList = programAsyncValue.value;
        logger.d('Program list: ${programList?.length ?? 0} items');

        var name = '';
        if (programList != null && usageHistory.eventId != null) {
          try {
            final program = programList.firstWhere(
              (element) => element.id == usageHistory.eventId,
            );
            name = program.name ?? '不明なイベント';
            logger.d('Found program: ${program.name}');
          } catch (e) {
            logger.w('Event not found for eventId: ${usageHistory.eventId}');
            name = '不明なイベント (ID: ${usageHistory.eventId})';
          }
        } else {
          logger.w(
            'ProgramList is null or eventId is null: programList=${programList != null}, eventId=${usageHistory.eventId}',
          );
          name = '不明なイベント (ID: ${usageHistory.eventId})';
        }

        logger.d(
          'UsageHistory item: dateOfUse=${usageHistory.dateOfUse}, eventId=${usageHistory.eventId}, name=$name, useTicket=${usageHistory.useTicket}',
        );

        return _buildHistoryCard(
          context,
          usageHistory,
          name,
          l10n,
          theme,
          index,
        );
      },
    );
  }

  Widget _buildHistoryCard(
    BuildContext context,
    dynamic usageHistory,
    String eventName,
    AppLocalizations l10n,
    ThemeData theme,
    int index,
  ) {
    final dateOfUse = usageHistory.dateOfUse as DateTime;
    final useTicket = usageHistory.useTicket as List<String>?;
    final isToday = _isToday(dateOfUse);
    final isYesterday = _isYesterday(dateOfUse);

    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (index * 100)),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 4,
        shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap:
              () => UsageHistoryDetailsRoute(
                $extra: useTicket ?? [],
              ).push(context),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.surface,
                  theme.colorScheme.surface.withValues(alpha: 0.8),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _getStatusColor(dateOfUse, theme),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.history,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            eventName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getDateText(dateOfUse, l10n, isToday, isYesterday),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.7,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.confirmation_number,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${useTicket?.length ?? 0}枚のチケット',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                          dateOfUse,
                          theme,
                        ).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _getStatusText(isToday, isYesterday),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: _getStatusColor(dateOfUse, theme),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(DateTime dateOfUse, ThemeData theme) {
    final now = DateTime.now();
    final difference = now.difference(dateOfUse).inDays;

    if (difference == 0) {
      return Colors.green;
    } else if (difference == 1) {
      return Colors.orange;
    } else if (difference <= 7) {
      return Colors.blue;
    } else {
      return Colors.grey;
    }
  }

  String _getStatusText(bool isToday, bool isYesterday) {
    if (isToday) return '今日';
    if (isYesterday) return '昨日';
    return '過去';
  }

  String _getDateText(
    DateTime dateOfUse,
    AppLocalizations l10n,
    bool isToday,
    bool isYesterday,
  ) {
    if (isToday) {
      return '今日 ${l10n.time(dateOfUse)}';
    } else if (isYesterday) {
      return '昨日 ${l10n.time(dateOfUse)}';
    } else {
      return '${l10n.date(dateOfUse)} ${l10n.time(dateOfUse)}';
    }
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool _isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  Widget _buildEmptyHistoryWidget(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.history_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '使用履歴がありません',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'チケットを使用すると、ここに履歴が表示されます',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
