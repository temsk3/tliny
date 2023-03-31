import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../data/model/ticket_model.dart';
import '../../../settings/hooks/use_l10n.dart';
import '../../../settings/hooks/use_media_query.dart';
import '../../../settings/hooks/use_router.dart';
import '../../../settings/theme/app_theme.dart';
import '../../../ui/ticket/ticket_view_model.dart';

final logger = Logger();

class TicketCard extends HookConsumerWidget {
  const TicketCard({
    super.key,
    required this.ticket,
    required this.checkList,
  });
  final Ticket ticket;
  final TicketCheckList checkList;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final appMediaQuery = useMediaQuery();

    // final now = DateTime.now();
    // final formatter = NumberFormat.simpleCurrency(
    //   locale: Localizations.localeOf(context).toString(),
    // );

    final flag = useState(checkList.state.contains(ticket.id));
    // final state = ref.watch(productStreamProvider(cart.productDocRef!));
    // final viewModel = ref.watch(cartViewModelProvider.notifier);

    // return AsyncValueButtonWidget(
    //   value: state,
    //   data: (product) {
    //     logger.d(product);
    final bool enable;
    final Icon? secondary;
    final now = DateTime.now();
    if (now.isAfter(ticket.expirationFrom!) &
        now.isBefore(ticket.expirationTo!)) {
      enable = ticket.isPrinting ? false : ticket.isActive;
      secondary = enable
          ? null
          : Icon(
              Icons.block_outlined,
              color: theme.appColors.primary,
            );
    } else {
      enable = false;
      secondary = null;
    }
    return Card(
      child:
          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: <Widget>[
          //   Stack(
          // alignment: AlignmentDirectional.center,
          // children: [
          CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        enabled: enable,
        title: Text(ticket.eventName.toString()), //
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ticket.name!),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '使用期限 : ${l10n.dataTime(ticket.expirationFrom!)}〜${l10n.dataTime(ticket.expirationTo!)}',
                style: theme.textTheme.h10,
              ),
            ),
          ],
        ),
        secondary: secondary,
        value: flag.value,
        onChanged: (bool? value) {
          flag.value = value!;
          value
              ? checkList.addTicketCheckList(ticket.id!)
              : checkList.deleteTicketCheckList(ticket.id!);
        },
      ),
      // ),
      // Container(
      //   child: ticket.isPrinting
      //       ? Text(
      //           '印刷済み',
      //           style: TextStyle(color: theme.appColors.primary),
      //         )
      //       : ticket.isActive
      //           ? Text(
      //               '',
      //               style: TextStyle(color: theme.appColors.primary),
      //             )
      //           : Text(
      //               '使用済み',
      //               style: TextStyle(color: theme.appColors.primary),
      //             ),
      // ),
      // ],
      //   ],
      // ),
    );
    //   },
    // );
  }
}
