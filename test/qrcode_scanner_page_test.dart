// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:tliny/src/data/model/ticket_model.dart';
// import 'package:tliny/src/ui/ticket/qr_code_scanner_page.dart';
// import 'package:tliny/src/ui/ticket/qrcode_scanner_view_model.dart';

// void main() {
//   testWidgets('should display scanned ticket', (WidgetTester tester) async {
//     final mockTickets = [const Ticket(name: 'Test Ticket')];

//     final providerContainer = ProviderContainer(
//       overrides: [
//         qrCodeScannerViewModelProvider
//             .overrideWithValue(MockQRCodeScannerViewModel(mockTickets)),
//       ],
//     );

//     await tester.pumpWidget(
//       ProviderScope(
//         overrides: [
//           qrCodeScannerViewModelProvider.overrideWithProvider(
//             (ref) => MockQRCodeScannerViewModel(mockTickets),
//           ),
//         ],
//         child: const MaterialApp(
//           home: QRCodeScannerPage(currentEventID: 'eventId'),
//         ),
//       ),
//     );

//     // Simulate QR code scan
//     // Note: You may need to find a way to simulate onDetect event for MobileScanner

//     await tester.pump(); // Rebuild the widget

//     expect(find.text('Test Ticket'), findsOneWidget);
//   });
// }

// class MockQRCodeScannerViewModel extends StateNotifier<String?> {
//   MockQRCodeScannerViewModel(this.mockTickets) : super(null);
//   final List<Ticket> mockTickets;

//   Future<List<Ticket>> findTicketsByUuid(String prefix, String uuid) async {
//     return mockTickets;
//   }

//   Future<void> updateDatabaseTickets(List<Ticket> scannedTickets) async {
//     // Update logic for testing
//   }
// }
