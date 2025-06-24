import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/security.dart';
import '../common/main_body.dart';
import 'ticket_list_view_model.dart';

class QRCodeDisplayPage extends HookConsumerWidget {
  const QRCodeDisplayPage({super.key, required this.uuid});
  final String uuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tickets = ref.watch(ticketsStateProvider);
    final viewModel = ref.read(ticketListViewModelProvider.notifier);
    final selectedTickets = tickets.whenOrNull(
      data: (tickets) => tickets
          .where(
            (ticket) => viewModel.getSelectedTicketIds().contains(ticket.id),
          )
          .toList(),
    );

    final userId = viewModel.getUserId();
    final eventId = selectedTickets?.isNotEmpty == true
        ? selectedTickets!.first.eventId
        : null;

    if (eventId == null || userId == null || selectedTickets == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Your QR Code')),
        body: const Center(child: Text('No tickets selected or invalid data.')),
      );
    }

    final encryptedUuid = Security().encrypt(eventId, uuid, false);

    return Scaffold(
      appBar: AppBar(title: const Text('Your QR Code')),
      body: MainBodyWidget(
        width: 400,
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 24),
              BarcodeWidget(
                barcode: Barcode.qrCode(),
                data: encryptedUuid,
                width: 200,
                height: 200,
                drawText: false,
                padding: const EdgeInsets.all(8),
              ),
              if (selectedTickets.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: selectedTickets.length,
                    itemBuilder: (context, index) {
                      final ticket = selectedTickets[index];
                      return ListTile(
                        title: Text(ticket.name!),
                        leading: ticket.isUsed
                            ? const Icon(
                                Icons.check_circle_outlined,
                                color: Colors.green,
                              )
                            : null,
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
