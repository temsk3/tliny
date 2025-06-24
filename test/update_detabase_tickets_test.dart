import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tliny/src/data/model/ticket_model.dart';
import 'package:tliny/src/data/repository/ticket_repository.dart';

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  DocumentSnapshot,
  QuerySnapshot,
  Query,
])
import 'update_detabase_tickets_test.mocks.dart';

void main() {
  group('updateTickets', () {
    test('複数のチケットを更新できること', () async {
      // Arrange
      final firestore = MockFirebaseFirestore();
      final ticketRef = MockCollectionReference<Map<String, dynamic>>();
      final ticketRepository = TicketRepository(firestore);

      const ticket1 = Ticket(id: '1', ownerId: 'user1');
      const ticket2 = Ticket(id: '2', ownerId: 'user1');
      final tickets = [ticket1, ticket2];

      final docRef1 = MockDocumentReference<Map<String, dynamic>>();
      final docRef2 = MockDocumentReference<Map<String, dynamic>>();

      when(firestore.collection('v/1/tickets')).thenReturn(ticketRef);
      when(ticketRef.doc('1')).thenReturn(docRef1);
      when(ticketRef.doc('2')).thenReturn(docRef2);

      // Act
      await ticketRepository.updateTickets(tickets);

      // Assert
      verify(docRef1.set(any, SetOptions(merge: true))).called(1);
      verify(docRef2.set(any, SetOptions(merge: true))).called(1);
    });
  });
}
