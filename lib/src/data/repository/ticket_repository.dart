import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../general_provider.dart';
import '../model/ticket_model.dart';

part 'ticket_repository.g.dart';

final logger = Logger();

const _defaultPath = 'v/1';
const _collectionPath = '$_defaultPath/users';
const _ticketCollectionPath = 'tickets';

// CartRepositoryProvider
@Riverpod(keepAlive: true)
TicketRepository ticketRepository(TicketRepositoryRef ref) {
  return TicketRepository(ref.watch(firebaseFirestoreProvider));
}

class TicketRepository {
  TicketRepository(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Ticket> _collectionRef(String uid) {
    return _db
        .collection(_collectionPath)
        .doc(uid)
        .collection(_ticketCollectionPath)
        .withConverter<Ticket>(
          fromFirestore: (snapshot, _) =>
              Ticket.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
          toFirestore: (model, _) => {
            ...model.toJson()..remove('id'),
            if (model.createdAt == null)
              'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
            if (model.isActive == false)
              'deletedAt': FieldValue.serverTimestamp(),
          },
        );
  }

  // 取得
  Stream<List<Ticket>> watchTickets(String uid) {
    return _collectionRef(uid).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Stream<Ticket> watchTicket(String uid, String ticketId) {
    return _collectionRef(uid)
        .doc(ticketId)
        .snapshots()
        .map((doc) => doc.data()!);
  }

  Future<List<Ticket>> readTicket(String uid) async {
    final querySnapshot = await _collectionRef(uid).get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  // 登録
  Future<String> createTicket(String uid, Ticket ticket) async {
    final docRef = _collectionRef(uid).doc();
    await docRef.set(ticket);
    return docRef.id;
  }

  // 更新
  Future<String> updateTicket(String uid, Ticket ticket) async {
    final docRef = _collectionRef(uid).doc(ticket.id);
    await docRef.set(ticket, SetOptions(merge: true));
    return docRef.id;
  }

  // 削除
  Future<void> deleteTicket(String uid, String ticketId) async {
    await _collectionRef(uid).doc(ticketId).update({'isActive': false});
  }
}

// Stream
@riverpod
Stream<List<Ticket>> ticketsStream(TicketsStreamRef ref, String uid) {
  return ref.watch(ticketRepositoryProvider).watchTickets(uid);
}

@riverpod
Stream<Ticket> ticketStream(TicketStreamRef ref, String uid, String ticketId) {
  return ref.watch(ticketRepositoryProvider).watchTicket(uid, ticketId);
}

//
//
const _usageHistoryCollectionPath = 'use_of_tickets';

// CartRepositoryProvider
@Riverpod(keepAlive: true)
UsageHistoryRepository usageHistoryRepository(UsageHistoryRepositoryRef ref) {
  return UsageHistoryRepository(ref.watch(firebaseFirestoreProvider));
}

class UsageHistoryRepository {
  UsageHistoryRepository(this._db);
  final FirebaseFirestore _db;

  CollectionReference<UsageHistory> _collectionRef(String uid) {
    return _db
        .collection(_collectionPath)
        .doc(uid)
        .collection(_usageHistoryCollectionPath)
        .withConverter<UsageHistory>(
          fromFirestore: (snapshot, _) =>
              UsageHistory.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
          toFirestore: (model, _) => {
            ...model.toJson()..remove('id'),
            if (model.createdAt == null)
              'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
          },
        );
  }

  // 取得
  Stream<List<UsageHistory>> watchUsageHistoryList(String uid) {
    return _collectionRef(uid).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Stream<UsageHistory> watchUsageHistory(String uid, String id) {
    return _collectionRef(uid).doc(id).snapshots().map((doc) => doc.data()!);
  }

  Future<List<UsageHistory>> readUsageHistory(String uid) async {
    final querySnapshot = await _collectionRef(uid).get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  // 登録
  Future<String> createUsageHistory(
    String uid,
    UsageHistory usageHistory,
  ) async {
    final docRef = _collectionRef(uid).doc();
    await docRef.set(usageHistory);
    return docRef.id;
  }

  // 更新
  Future<String> updateUsageHistory(
    String uid,
    UsageHistory usageHistory,
  ) async {
    final docRef = _collectionRef(uid).doc(usageHistory.id);
    await docRef.set(usageHistory, SetOptions(merge: true));
    return docRef.id;
  }

  // 削除
  Future<void> deleteUsageHistory(String uid, String id) async {
    await _collectionRef(uid).doc(id).delete();
  }
}

// Stream
@riverpod
Stream<List<UsageHistory>> usageHistoryListStream(
  UsageHistoryListStreamRef ref,
  String uid,
) {
  return ref.watch(usageHistoryRepositoryProvider).watchUsageHistoryList(uid);
}

@riverpod
Stream<UsageHistory> usageHistoryStream(
  UsageHistoryStreamRef ref,
  String uid,
  String id,
) {
  return ref.watch(usageHistoryRepositoryProvider).watchUsageHistory(uid, id);
}
