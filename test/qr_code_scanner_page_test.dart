import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/data/model/ticket_model.dart';
import 'package:tliny/src/data/repository/ticket_repository.dart';
import 'package:tliny/src/ui/ticket/qr_code_scanner_page.dart';
import 'package:tliny/src/ui/ticket/qrcode_scanner_view_model.dart';

void main() {
  testWidgets(
    'should call updateDatabaseTickets when confirm button is pressed',
    (WidgetTester tester) async {
      final mockTickets = [
        const Ticket(name: 'Test Ticket', uuid: 'test-uuid'),
      ];
      final mockRepository = MockTicketRepository(mockTickets);
      final mockViewModel = MockQRCodeScannerViewModel(
        mockRepository,
        mockTickets,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            qrCodeScannerViewModelProvider.overrideWith((ref) => mockViewModel),
          ],
          child: const MaterialApp(
            home: QRCodeScannerPage(currentEventID: 'eventId'),
          ),
        ),
      );

      // Simulate QR code scan
      mockViewModel.setScannedData(mockTickets);
      await tester.pump();

      // Find and tap the confirm button
      final confirmButton = find.widgetWithText(TextButton, 'Confirm');
      expect(confirmButton, findsOneWidget);
      await tester.tap(confirmButton);
      await tester.pump();

      // Verify that updateDatabaseTickets is called
      expect(mockViewModel.updateDatabaseTicketsCalled, true);
    },
  );
}

class MockQRCodeScannerViewModel extends QRCodeScannerViewModel {
  MockQRCodeScannerViewModel(super.repository, this.mockTickets);
  final List<Ticket> mockTickets;
  bool updateDatabaseTicketsCalled = false;
  final scannedData = ValueNotifier<List<Ticket>>([]);

  void setScannedData(List<Ticket> tickets) {
    state = 'scanned';
    scannedData.value = tickets;
  }

  @override
  Future<void> updateDatabaseTickets(List<Ticket> scannedTickets) async {
    updateDatabaseTicketsCalled = true;
  }
}

class MockTicketRepository implements TicketRepository {
  MockTicketRepository(this.mockTickets);
  final List<Ticket> mockTickets;

  @override
  Future<String> createTicket(Ticket ticket) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTicket(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Ticket>> readTicket(String uid) {
    throw UnimplementedError();
  }

  @override
  Future<Ticket> searchTicket(String id) {
    throw UnimplementedError();
  }

  @override
  Stream<List<Ticket>> watchAllTicket() {
    throw UnimplementedError();
  }

  @override
  Stream<List<Ticket>> watchTickets(String uid) {
    throw UnimplementedError();
  }

  @override
  Stream<Ticket> watchTicket(String uid, String ticketId) {
    throw UnimplementedError();
  }

  @override
  Future<List<Ticket>> readAllTicket() async {
    return mockTickets;
  }

  @override
  Future<String> updateTicket(Ticket ticket) async {
    throw UnimplementedError();
  }

  @override
  Future<void> updateUsed(String id, bool isUsed) {
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> testTicket(String uid) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTicketField(
    String ticketId,
    Map<String, dynamic> data,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTickets(List<Ticket> tickets) {
    // TODO: implement updateTickets
    throw UnimplementedError();
  }
}
