import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/l10n/app_localizations.dart';

import '../../data/model/program_model.dart';
import '../../data/model/ticket_model.dart';
import '../../data/repository/program_repository.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/routes/routes.dart';
import '../common/asyncvalue_widget.dart';
import '../common/main_body.dart';
import '../image/image_screen.dart';
import 'ticket_list_view_model.dart';

class TicketListPage extends HookConsumerWidget {
  const TicketListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final sortOrder = useState(SortOrder.expirationFrom);
    final ticketsAsyncValue = ref.watch(ticketsStateProvider);
    final viewModel = ref.read(ticketListViewModelProvider.notifier);

    return MainBodyWidget(
      width: 400,
      body: AsyncValueWidget(
        value: ticketsAsyncValue,
        data: (tickets) {
          if (tickets.isEmpty) {
            debugPrint('TicketListPage: No tickets found');
            return _buildEmptyTicketsWidget(context, l10n);
          }

          debugPrint('TicketListPage: Found ${tickets.length} tickets');
          final sortedTickets = sortTickets(tickets, sortOrder.value);
          final groupedTickets = groupTicketsByEvent(sortedTickets);
          debugPrint(
            'TicketListPage: Grouped into ${groupedTickets.length} events',
          );

          return Scaffold(
            body: Column(
              children: [
                _buildSortMenu(l10n, sortOrder),
                Expanded(
                  child: Consumer(
                    builder: (context, ref, child) {
                      final viewModel = ref.read(
                        ticketListViewModelProvider.notifier,
                      );
                      // 期限切れの表示状態の変更を監視
                      ref.watch(ticketListViewModelProvider);
                      final filteredTickets = viewModel.filterExpiredTickets(
                        sortedTickets,
                      );
                      debugPrint(
                        'TicketListPage: After expired filter: ${filteredTickets.length} tickets',
                      );

                      final filteredGroupedTickets = groupTicketsByEvent(
                        filteredTickets,
                      );
                      debugPrint(
                        'TicketListPage: After grouping: ${filteredGroupedTickets.length} events',
                      );

                      // 使用可能なチケットが無いイベントをフィルタリング
                      final finalGroupedTickets = viewModel
                          .filterEventsWithNoValidTickets(
                            filteredGroupedTickets,
                          );
                      debugPrint(
                        'TicketListPage: Final events: ${finalGroupedTickets.length} events',
                      );

                      // 使用可能なチケットがない場合のメッセージ表示
                      if (finalGroupedTickets.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.event_busy,
                                size: 80,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                viewModel.isExpiredTicketsVisible
                                    ? l10n.noTickets
                                    : l10n.noAvailableTickets,
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(color: Colors.grey[600]),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                viewModel.isExpiredTicketsVisible
                                    ? l10n.pleasePurchaseNewTicket
                                    : l10n.showExpiredOrPurchaseNewTicket,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.grey[500]),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      return Column(
                        children: [
                          // ボタンを独立したConsumerで監視
                          Consumer(
                            builder: (context, ref, child) {
                              final selectedState = ref.watch(
                                ticketListViewModelProvider,
                              );
                              final selectedTicketIds =
                                  selectedState.value ?? {};
                              final hasSelectedTickets =
                                  selectedTicketIds.isNotEmpty;

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.picture_as_pdf),
                                      onPressed:
                                          hasSelectedTickets
                                              ? () => const TicketPdfRoute()
                                                  .push(context)
                                              : null,
                                      tooltip: l10n.generatePdf,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.qr_code),
                                      onPressed:
                                          hasSelectedTickets
                                              ? () => QRCodeDisplayRoute(
                                                uuid: viewModel.getSharedUuid(
                                                  filteredTickets,
                                                ),
                                              ).push(context)
                                              : null,
                                      tooltip: l10n.displayQrCode,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: finalGroupedTickets.length,
                              itemBuilder: (context, index) {
                                final eventId = finalGroupedTickets.keys
                                    .elementAt(index);
                                final eventTickets =
                                    finalGroupedTickets[eventId]!;

                                return AsyncValueWidget(
                                  value: ref.watch(
                                    programStreamProvider(eventId),
                                  ),
                                  data: (event) {
                                    return _buildEventExpansionTile(
                                      l10n,
                                      ref,
                                      event,
                                      eventTickets,
                                      viewModel,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSortMenu(
    AppLocalizations l10n,
    ValueNotifier<SortOrder> sortOrder,
  ) {
    return Padding(
      // Add padding for better visuals
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ), // Adjust values as needed
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 両端に配置
        children: [
          // 期限切れチケットの表示・非表示ボタン
          Consumer(
            builder: (context, ref, child) {
              final viewModel = ref.read(ticketListViewModelProvider.notifier);
              // 期限切れの表示状態を監視するために、状態をwatchする
              ref.watch(ticketListViewModelProvider);
              final isExpiredVisible = viewModel.isExpiredTicketsVisible;

              return TextButton.icon(
                onPressed: viewModel.toggleExpiredTicketsVisibility,
                icon: Icon(
                  isExpiredVisible ? Icons.visibility : Icons.visibility_off,
                  size: 20,
                ),
                label: Text(
                  isExpiredVisible ? l10n.hideExpired : l10n.showExpired,
                  style: const TextStyle(fontSize: 12),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                ),
              );
            },
          ),
          // ソートボタン
          PopupMenuButton<SortOrder>(
            onSelected: (sort) => sortOrder.value = sort,
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: SortOrder.eventName,
                    child: Text(l10n.sortByEventName),
                  ),
                  PopupMenuItem(
                    value: SortOrder.expirationFrom,
                    child: Text(l10n.sortByEventDate),
                  ),
                ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventExpansionTile(
    AppLocalizations l10n,
    WidgetRef ref,
    Program event,
    List<Ticket> eventTickets,
    TicketListViewModel viewModel,
  ) {
    final selectedTicketIds =
        ref.watch(ticketListViewModelProvider).value ?? {};
    final selectedEventId =
        ref.read(ticketListViewModelProvider.notifier).selectedEventId;

    return ExpansionTile(
      leading: PictureView(
        picture: event.pictureURL ?? [],
        index: 0,
        height: 45,
        width: 80,
        tap: false,
      ),
      title: Text(event.name!),
      subtitle: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Text(
          event.eventFrom != null && event.eventTo != null
              ? '  ${l10n.periods} : ${l10n.date(event.eventFrom!)}〜${l10n.date(event.eventTo!)}'
              : '  ${l10n.periods} : 期間未設定',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ),
      initiallyExpanded: eventTickets.any(
        (ticket) => selectedTicketIds.contains(ticket.id),
      ),
      onExpansionChanged: (isExpanded) {
        if (!isExpanded) {
          for (final ticket in eventTickets) {
            if (selectedTicketIds.contains(ticket.id)) {
              viewModel.toggleTicketSelection(ticket);
            }
          }
        }
      },
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Location: ${event.place}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'desc: ${event.message}',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        ...eventTickets.map((ticket) {
          final ticketKey = ValueKey(ticket.id);
          var isSelected = selectedTicketIds.contains(ticket.id);
          if (ticket.isUsed) isSelected = false;

          // 期限切れかどうかを判定（期限切れチケットは常に選択不可）
          final isExpired = viewModel.isTicketExpired(ticket);
          if (isExpired) isSelected = false;

          return _buildTicketCard(
            l10n,
            ref,
            ticketKey,
            ticket,
            viewModel,
            isSelected,
            selectedEventId,
          );
        }),
      ],
    );
  }

  Widget _buildTicketCard(
    AppLocalizations l10n,
    WidgetRef ref,
    Key ticketKey,
    Ticket ticket,
    TicketListViewModel viewModel,
    bool isSelected,
    String? selectedEventId,
  ) {
    // 選択状態をリアルタイムで監視
    final selectedTicketIds =
        ref.watch(ticketListViewModelProvider).value ?? {};
    final currentIsSelected = selectedTicketIds.contains(ticket.id);

    final isDisabled =
        selectedEventId != null && selectedEventId != ticket.eventId;
    final isUsed = ticket.isUsed;
    if (isUsed) {
      viewModel.toggleTicketSelection(ticket);
    }

    // 期限切れかどうかを判定
    final isExpired = viewModel.isTicketExpired(ticket);

    return CheckboxListTile(
      key: ticketKey,
      title: Text(ticket.name!),
      subtitle: Text(ticket.code!),
      value: currentIsSelected,
      onChanged:
          isUsed || isDisabled || isExpired
              ? null
              : (_) => viewModel.toggleTicketSelection(ticket),

      secondary: Stack(
        children: [
          PictureView(
            picture: ticket.pictureURL ?? [],
            index: 0,
            height: 45,
            width: 80,
            tap: false,
          ),
          if (ticket.isPrinting)
            const Icon(Icons.print_outlined, color: Colors.green),
          if (isExpired) // 期限切れの場合（印刷アイコンの上に重ねる）
            Icon(
              Icons.access_time,
              color: Colors.orange,
              semanticLabel: l10n.expiredTicket,
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyTicketsWidget(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.confirmation_number_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            l10n.noTickets,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            l10n.purchasedTicketsDisplayedHere,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          // const SizedBox(height: 30),
          // ElevatedButton.icon(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const AvailableEventsPage(),
          //       ),
          //     );
          //   },
          //   icon: const Icon(Icons.event),
          //   label: const Text('イベントを見る'),
          //   style: ElevatedButton.styleFrom(
          //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// チケットをイベント別にグループ化する関数
Map<String, List<Ticket>> groupTicketsByEvent(List<Ticket> tickets) {
  return tickets.fold(<String, List<Ticket>>{}, (map, ticket) {
    map.putIfAbsent(ticket.eventId!, () => []).add(ticket);
    return map;
  });
}

// チケットをソートする関数
List<Ticket> sortTickets(List<Ticket> tickets, SortOrder sortOrder) {
  final now = DateTime.now();
  switch (sortOrder) {
    case SortOrder.eventName:
      tickets.sort((a, b) => a.eventName!.compareTo(b.eventName!));
    case SortOrder.expirationFrom:
      tickets.sort((a, b) {
        final aDate = a.expirationFrom!;
        final bDate = b.expirationFrom!;
        final aIsFuture = aDate.isAfter(now);
        final bIsFuture = bDate.isAfter(now);
        if (aIsFuture && bIsFuture) {
          return aDate.compareTo(bDate);
        } else if (!aIsFuture && !bIsFuture) {
          return bDate.compareTo(aDate);
        } else {
          return aIsFuture ? -1 : 1;
        }
      });
  }
  return tickets;
}
