import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/data/model/ticket_model.dart';
import 'package:tliny/src/data/repository/ticket_repository.dart';
import 'package:tliny/src/ui/ticket/qrcode_scanner_view_model.dart';

void main() {
  final mockTickets = [
    const Ticket(name: 'Ticket 1', pdfUuid: 'uuid1', uuid: 'uuidA'),
    const Ticket(name: 'Ticket 2', pdfUuid: 'uuid2', uuid: 'uuidB'),
  ];

  group('QRCodeScannerViewModel Tests', () {
    test('should find tickets by REG UUID', () async {
      final providerContainer = ProviderContainer(
        overrides: [
          ticketRepositoryProvider.overrideWithValue(
            MockTicketRepository(mockTickets),
          ),
        ],
      );

      final viewModel = providerContainer.read(
        qrCodeScannerViewModelProvider.notifier,
      );
      final result = await viewModel.findTicketsByUuid('REG:', 'uuidA');

      print('result: ${result.length}');
      if (result.isNotEmpty) {
        print('result.first.name: ${result.first.name}');
      }

      expect(result.length, 1);
      expect(result.first.name, 'Ticket 1');
    });

    test('should find tickets by PDF UUID', () async {
      final providerContainer = ProviderContainer(
        overrides: [
          ticketRepositoryProvider.overrideWithValue(
            MockTicketRepository(mockTickets),
          ),
        ],
      );

      final viewModel = providerContainer.read(
        qrCodeScannerViewModelProvider.notifier,
      );
      final result = await viewModel.findTicketsByUuid('PDF:', 'uuid2');

      expect(result.length, 1);
      expect(result.first.name, 'Ticket 2');
    });

    test('should return empty list for unknown UUID', () async {
      final providerContainer = ProviderContainer(
        overrides: [
          ticketRepositoryProvider.overrideWithValue(
            MockTicketRepository(mockTickets),
          ),
        ],
      );

      final viewModel = providerContainer.read(
        qrCodeScannerViewModelProvider.notifier,
      );
      final result = await viewModel.findTicketsByUuid('REG:', 'unknown');

      expect(result.length, 0);
    });

    test('should update database tickets', () async {
      final mockRepository = MockTicketRepository(mockTickets);
      final providerContainer = ProviderContainer(
        overrides: [ticketRepositoryProvider.overrideWithValue(mockRepository)],
      );
      final viewModel = providerContainer.read(
        qrCodeScannerViewModelProvider.notifier,
      );

      await viewModel.updateDatabaseTickets(mockTickets);

      print('mockTickets[0].uuid: ${mockTickets[0].uuid}');
      print('mockTickets[1].uuid: ${mockTickets[1].uuid}');

      expect(mockRepository.updateTicketCallCount, mockTickets.length);
      expect(mockRepository.lastUpdatedTicket, mockTickets.last);
    });

    test('should update database tickets when called with unawaited', () async {
      final mockRepository = MockTicketRepository(mockTickets);
      final providerContainer = ProviderContainer(
        overrides: [ticketRepositoryProvider.overrideWithValue(mockRepository)],
      );
      final viewModel = providerContainer.read(
        qrCodeScannerViewModelProvider.notifier,
      );

      unawaited(viewModel.updateDatabaseTickets(mockTickets));

      // Wait for a short time to allow the unawaited task to complete
      await Future.delayed(const Duration(milliseconds: 100));

      expect(mockRepository.updateTicketCallCount, mockTickets.length);
      expect(mockRepository.lastUpdatedTicket, mockTickets.last);
    });
  });
}

class MockTicketRepository implements TicketRepository {
  MockTicketRepository(this.mockTickets);
  final List<Ticket> mockTickets;
  int updateTicketCallCount = 0;
  Ticket? lastUpdatedTicket;

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
    updateTicketCallCount++;
    lastUpdatedTicket = ticket;
    // Simulate the update operation
    final index = mockTickets.indexWhere((t) => t.uuid == ticket.uuid);
    if (index != -1) {
      mockTickets[index] = ticket;
    }
    if (ticket.uuid == null) {
      throw Exception('Ticket UUID cannot be null');
    }
    return ticket.uuid ?? '';
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
    Map<String, dynamic> values,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTickets(List<Ticket> tickets) async {
    for (final ticket in tickets) {
      await updateTicket(ticket);
    }
  }
}
