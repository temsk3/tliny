import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../data/model/ticket_model.dart';
import '../../utils/security.dart';
import '../common/asyncvalue_widget.dart';
import 'ticket_list_view_model.dart';

class TicketPdfPage extends HookConsumerWidget {
  const TicketPdfPage({super.key});

  static final _baseFont = PdfGoogleFonts.mPLUSRounded1cRegular();
  static final _boldFont = PdfGoogleFonts.mPLUSRounded1cBold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ticketListViewModelProvider.notifier);
    final selectedTicketIds = viewModel.getSelectedTicketIds();

    return AsyncValueWidget(
      value: ref.watch(ticketsStateProvider),
      data: (tickets) {
        viewModel.generatePdfUuidsForTickets(tickets);

        final selectedTickets =
            tickets
                .where((ticket) => selectedTicketIds.contains(ticket.id))
                .toList();

        return Scaffold(
          appBar: AppBar(title: const Text('Ticket PDF')),
          body: PdfPreview(
            canChangeOrientation: false,
            canChangePageFormat: false,
            allowSharing: false,
            canDebug: false,
            build: (format) => _generatePdf(selectedTickets),
            onPrinted: (event) async {
              await viewModel.printingTickets(tickets);
            },
          ),
        );
      },
    );
  }

  Future<Uint8List> _generatePdf(List<Ticket> tickets) async {
    final font = await _baseFont;
    final boldFont = await _boldFont;

    // テーマを設定
    final myTheme = pw.ThemeData.withFont(base: font, bold: boldFont);

    final pdf = pw.Document(title: tickets.first.eventName, theme: myTheme);

    const ticketsPerPage = 6;

    for (var i = 0; i < tickets.length; i += ticketsPerPage) {
      final subList = tickets.sublist(
        i,
        i + ticketsPerPage > tickets.length
            ? tickets.length
            : i + ticketsPerPage,
      );

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build:
              (context) => pw.Table(
                border: const pw.TableBorder(horizontalInside: pw.BorderSide()),
                children: subList.map(_buildTicketRow).toList(),
              ),
        ),
      );
    }

    return pdf.save();
  }

  pw.TableRow _buildTicketRow(Ticket ticket) {
    final encryptedPdfUuid = Security().encrypt(
      ticket.eventId!,
      ticket.pdfUuid!,
      true,
    );

    final qrCode = pw.BarcodeWidget(
      padding: const pw.EdgeInsets.all(8),
      barcode: pw.Barcode.qrCode(),
      data: encryptedPdfUuid,
      width: 100,
      height: 100,
      drawText: false,
    );

    return pw.TableRow(
      children: [
        pw.Expanded(
          flex: 3,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                ticket.eventName!,
                style: const pw.TextStyle(fontSize: 18),
              ),
              pw.Text(ticket.name!, style: const pw.TextStyle(fontSize: 14)),
            ],
          ),
        ),
        pw.Expanded(child: qrCode),
      ],
    );
  }
}
