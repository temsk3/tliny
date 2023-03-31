import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../settings/hooks/use_router.dart';
import '../common/asyncvalue_widget.dart';
import '../common/main_body.dart';
import 'ticket_state.dart';
import 'ticket_view_model.dart';
import 'widget/ticket_button.dart';
import 'widget/ticket_card.dart';

final logger = Logger();

@RoutePage()
class TicketPage extends HookConsumerWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    // final l10n = useL10n();
    final appRoute = useRouter();
    // final appMQ = useMediaQuery();
    final state = ref.watch(ticketsStateProvider);
    // final state = ref.watch(ticketViewModelProvider);
    final viewModel = ref.watch(ticketViewModelProvider.notifier);
    final checkList = ref.watch(ticketCheckListProvider.notifier);
    return AsyncValueWidget(
      value: state,
      data: (data) {
        // logger.d(data);
        // final list = data.where((ticket) => ticket.isActive == true).toList();
        // final list = data;
        // return Scaffold(
        //   body: MainBodyWidget(
        //     body: list.isNotEmpty
        //         ? ListView.builder(
        //             padding: const EdgeInsets.all(24),
        //             physics: const AlwaysScrollableScrollPhysics(),
        //             itemExtent: 100,
        //             itemCount: list.length,
        //             itemBuilder: (_, index) {
        //               final ticket = list[index];
        //               return TicketCard(
        //                 ticket: ticket,
        //                 checkList: checkList,
        //               );
        //             },
        //           )
        //         : Container(),
        // ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     appRoute.push(
        //     CreateQRCodeRoute(eventId: eventId,
        //       ticketList: checkList.state,
        //     ),
        //     );
        //   },
        //   child: const Icon(Icons.qr_code),
        // ),
        // );
        return Scaffold(
          body: MainBodyWidget(
            body: data.isNotEmpty
                ? GroupedListView(
                    elements: data,
                    groupBy: (element) => element.eventName!,
                    groupComparator: (value1, value2) =>
                        value2.compareTo(value1),
                    itemComparator: (item1, item2) => item1.productId
                        .toString()
                        .compareTo(item2.productId.toString()),
                    useStickyGroupSeparators: true,
                    groupHeaderBuilder: (element) {
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              element.eventName.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                              child: CreateQRCodeElevatedButton(
                                ticket: data
                                    .where((e) => e.eventId == element.eventId)
                                    .toList(),
                                eventId: element.eventId!,
                                ticketList: checkList.state,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    indexedItemBuilder: (context, element, index) {
                      return TicketCard(
                        ticket: element,
                        checkList: checkList,
                      );
                    },
                  )
                : Container(),
          ),
        );
      },
    );
  }
}
