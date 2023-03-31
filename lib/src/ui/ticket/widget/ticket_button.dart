import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../data/model/ticket_model.dart';
import '../../../settings/hooks/use_l10n.dart';
import '../../../settings/hooks/use_router.dart';
import '../../../settings/routes/app_route.gr.dart';
import '../../common/base_button_widget.dart';

final logger = Logger();

class CreateQRCodeElevatedButton extends HookWidget {
  const CreateQRCodeElevatedButton({
    super.key,
    required this.eventId,
    required this.ticketList,
    required this.ticket,
  });
  final String eventId;
  final Set<String> ticketList;
  final List<Ticket> ticket;
  @override
  Widget build(BuildContext context) {
    final appRoute = useRouter();
    final l10n = useL10n();
    return Consumer(
      builder: (context, ref, child) {
        return BaseElevatedButton(
          // return BaseIconButton(
          onPressed: () {
            // logger.d(ticketList);
            final List<String> list;
            list = [
              for (final element in ticket)
                for (final id in ticketList)
                  if (element.id == id) id
            ];
            if (list.isNotEmpty) {
              appRoute.push(
                CreateQRCodeRoute(
                  eventId: eventId,
                  ticketList: list.toSet(),
                ),
              );
            }
          },
          child: const Icon(Icons.qr_code),
          // icon: const Icon(Icons.qr_code),
          // tooltip: 'QR Code 表示',
        );
      },
    );
  }
}
