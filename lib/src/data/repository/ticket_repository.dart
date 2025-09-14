import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';
import '../model/exception/app_exception.dart';
import '../model/ticket_model.dart';

part 'ticket_repository.g.dart';

const _defaultPath = 'v/1';
const _collectionPath = 'v/1/users'; // 明示的にusersに固定
const _ticketCollectionPath = 'v/1/tickets'; // 明示的に
const _usageHistoryCollectionPath = 'use_of_tickets'; // 利用履歴はusers配下のみ
// customers関連のパスは削除

@Riverpod(keepAlive: true)
TicketRepository ticketRepository(Ref ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return TicketRepository(firestore);
}

class TicketRepository {
  TicketRepository(this._db)
    : _ticketRef = _db
          .collection(_ticketCollectionPath)
          .withConverter<Ticket>(
            fromFirestore: (snapshot, _) => Ticket.fromFirestore(snapshot),
            toFirestore:
                (model, _) => {
                  ...model.toFirestore(),
                  'updatedAt': FieldValue.serverTimestamp(),
                  if (model.createdAt == null)
                    'createdAt': FieldValue.serverTimestamp(),
                  if (!model.isActive)
                    'deletedAt': FieldValue.serverTimestamp(),
                },
          );
  final FirebaseFirestore _db;
  final CollectionReference<Ticket> _ticketRef;

  // 全チケットを取得するストリーム
  Stream<List<Ticket>> watchAllTicket() {
    logger.d('watchAllTicket');
    try {
      final list = _ticketRef.snapshots().map(
        (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
      );
      return list;
    } on Exception catch (e, st) {
      logger.e('watchAllTicket: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // ユーザーIDを指定してチケット一覧を取得するストリーム
  Stream<List<Ticket>> watchTickets(String uid) {
    logger.d('watchTickets: uid=$uid');
    try {
      return _ticketRef.where('ownerId', isEqualTo: uid).snapshots().map((
        snapshot,
      ) {
        logger.d('watchTickets: snapshot=$snapshot');
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } on Exception catch (e, st) {
      logger.e('watchTickets: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // ユーザーIDとチケットIDを指定してチケットを取得するストリーム
  Stream<Ticket> watchTicket(String uid, String ticketId) {
    logger.d('watchTicket: uid=$uid, ticketId=$ticketId');
    try {
      // uidパラメータは使用せず、チケットIDだけでチケットを取得
      return _ticketRef.doc(ticketId).snapshots().map((doc) {
        if (!doc.exists) {
          throw GeneralException(
            message: 'チケットが見つかりません: $ticketId',
            stackTrace: StackTrace.current,
          );
        }
        return doc.data()!;
      });
    } on Exception catch (e, st) {
      logger.e('watchTicket: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // チケットIDを指定してチケットを取得する
  Future<Ticket> searchTicket(String id) async {
    logger.d('searchTicket: id=$id');
    try {
      final docSnapshot = await _ticketRef.doc(id).get();
      logger.d('searchTicket: docSnapshot=$docSnapshot');
      final ticket = docSnapshot.data();
      if (ticket == null) {
        logger.e('searchTicket: ticket is null');
        throw GeneralException(
          message: 'データが存在しません',
          stackTrace: StackTrace.current,
        );
      }
      return ticket;
    } on Exception catch (e, st) {
      logger.e('searchTicket: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // 全チケットを取得する
  Future<List<Ticket>> readAllTicket() async {
    logger.d('readAllTicket');
    try {
      final querySnapshot = await _ticketRef.get();
      logger.d('readAllTicket: querySnapshot=$querySnapshot');
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } on Exception catch (e, st) {
      logger.e('readAllTicket: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // ユーザーIDを指定してチケット一覧を取得する
  Future<List<Ticket>> readTicket(String uid) async {
    logger.d('readTicket: uid=$uid');
    try {
      final querySnapshot =
          await _ticketRef.where('ownerId', isEqualTo: uid).get();
      logger.d('readTicket: querySnapshot=$querySnapshot');
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } on Exception catch (e, st) {
      logger.e('readTicket: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // チケットを登録する
  Future<String> createTicket(Ticket ticket) async {
    logger.d('createTicket: ticket=$ticket');
    try {
      final docRef = await _ticketRef.add(ticket);
      logger.d('createTicket: docRef=$docRef');
      return docRef.id;
    } on Exception catch (e, st) {
      logger.e('createTicket: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // チケットを更新する
  Future<String> updateTicket(Ticket ticket) async {
    logger.d('updateTicket: ticket=$ticket');
    try {
      final docRef = _ticketRef.doc(ticket.id);
      await docRef.set(ticket, SetOptions(merge: true));
      logger.d('updateTicket: success');
      return ticket.id!;
    } on Exception catch (e, st) {
      logger.e('updateTicket: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // チケットの一部のフィールドを更新する
  Future<void> updateTicketField(
    String ticketId,
    Map<String, dynamic> data,
  ) async {
    try {
      // updatedAtを追加
      final updateData = {...data, 'updatedAt': FieldValue.serverTimestamp()};
      await _ticketRef.doc(ticketId).update(updateData);
    } catch (e, st) {
      logger.e('Error updating ticket field: $e', stackTrace: st);
      rethrow; // エラーを上に伝える
    }
  }

  // チケットを削除する
  Future<void> deleteTicket(String ticketId) async {
    logger.d('deleteTicket: ticketId=$ticketId');
    try {
      await _ticketRef.doc(ticketId).update({'isActive': false});
      logger.d('deleteTicket: success');
    } on Exception catch (e, st) {
      logger.e('deleteTicket: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // テスト用
  Future<List<Map<String, dynamic>>> testTicket(String uid) async {
    logger.d('testTicket: uid=$uid');
    try {
      final docRef =
          await _db
              .collection(_collectionPath)
              .doc(uid)
              .collection(_ticketCollectionPath)
              .get();
      logger.d('testTicket: docRef=$docRef');
      return docRef.docs.map((doc) => doc.data()).toList();
    } on Exception catch (e, st) {
      logger.e('testTicket: error=$e, stackTrace=$st');
      rethrow;
    }
  }
}

// Stream
@riverpod
Stream<List<Ticket>> allTicketStream(Ref ref) {
  logger.d('allTicketStream');
  try {
    return ref.watch(ticketRepositoryProvider).watchAllTicket();
  } on Exception catch (e, st) {
    logger.e('allTicketStream: error=$e, stackTrace=$st');
    rethrow;
  }
}

@riverpod
Stream<List<Ticket>> ticketsStream(Ref ref, String uid) {
  logger.d('ticketsStream: uid=$uid');
  try {
    return ref.watch(ticketRepositoryProvider).watchTickets(uid);
  } on Exception catch (e, st) {
    logger.e('ticketsStream: error=$e, stackTrace=$st');
    rethrow;
  }
}

@riverpod
Stream<Ticket> ticketStream(Ref ref, String uid, String ticketId) {
  logger.d('ticketStream: uid=$uid, ticketId=$ticketId');
  try {
    return ref.watch(ticketRepositoryProvider).watchTicket(uid, ticketId);
  } on Exception catch (e, st) {
    logger.e('ticketStream: error=$e, stackTrace=$st');
    rethrow;
  }
}

//
//

// CartRepositoryProvider
@Riverpod(keepAlive: true)
UsageHistoryRepository usageHistoryRepository(Ref ref) {
  return UsageHistoryRepository(ref.watch(firebaseFirestoreProvider));
}

class UsageHistoryRepository {
  UsageHistoryRepository(this._db);
  final FirebaseFirestore _db;

  // users配下にのみ保存するよう明示
  CollectionReference<UsageHistory> _collectionRef(String uid) {
    return _db
        .collection(_collectionPath)
        .doc(uid)
        .collection(_usageHistoryCollectionPath)
        .withConverter<UsageHistory>(
          fromFirestore:
              (snapshot, _) => UsageHistory.fromJson(
                snapshot.data()!,
              ).copyWith(id: snapshot.id),
          toFirestore:
              (model, _) => {
                ...model.toJson()..remove('id'),
                if (model.createdAt == null)
                  'createdAt': FieldValue.serverTimestamp(),
                'updatedAt': FieldValue.serverTimestamp(),
              },
        );
  }

  // ユーザーIDを指定して利用履歴一覧を取得するストリーム
  Stream<List<UsageHistory>> watchUsageHistoryList(String uid) {
    logger.d('watchUsageHistoryList: uid=$uid');
    try {
      return _collectionRef(uid).snapshots().map((snapshot) {
        logger.d('watchUsageHistoryList: snapshot=$snapshot');
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } on Exception catch (e, st) {
      logger.e('watchUsageHistoryList: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // ユーザーIDと利用履歴IDを指定して利用履歴を取得するストリーム
  Stream<UsageHistory> watchUsageHistory(String uid, String id) {
    logger.d('watchUsageHistory: uid=$uid, id=$id');
    try {
      return _collectionRef(uid).doc(id).snapshots().map((doc) => doc.data()!);
    } on Exception catch (e, st) {
      logger.e('watchUsageHistory: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // ユーザーIDを指定して利用履歴一覧を取得する
  Future<List<UsageHistory>> readUsageHistory(String uid) async {
    logger.d('readUsageHistory: uid=$uid');
    try {
      final collectionPath =
          '$_collectionPath/$uid/$_usageHistoryCollectionPath';
      logger.d('readUsageHistory: collectionPath=$collectionPath');

      final querySnapshot = await _collectionRef(uid).get();
      logger.d('readUsageHistory: querySnapshot.size=${querySnapshot.size}');
      logger.d(
        'readUsageHistory: querySnapshot.docs.length=${querySnapshot.docs.length}',
      );

      final result =
          querySnapshot.docs.map((doc) {
            logger.d(
              'readUsageHistory: doc.id=${doc.id}, doc.data=${doc.data()}',
            );
            return doc.data();
          }).toList();

      logger.d('readUsageHistory: result.length=${result.length}');
      for (final history in result) {
        logger.d(
          'readUsageHistory: history.eventId=${history.eventId}, history.useTicket=${history.useTicket}',
        );
      }

      return result;
    } on Exception catch (e, st) {
      logger.e('readUsageHistory: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // 利用履歴を登録する
  Future<String> createUsageHistory(
    String uid,
    UsageHistory usageHistory,
  ) async {
    logger.d('createUsageHistory: uid=$uid, usageHistory=$usageHistory');
    try {
      final docRef = _collectionRef(uid).doc();
      await docRef.set(usageHistory);
      logger.d('createUsageHistory: docRef=$docRef');
      return docRef.id;
    } on Exception catch (e, st) {
      logger.e('createUsageHistory: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // 利用履歴を更新する
  Future<String> updateUsageHistory(
    String uid,
    UsageHistory usageHistory,
  ) async {
    logger.d('updateUsageHistory: uid=$uid, usageHistory=$usageHistory');
    try {
      final docRef = _collectionRef(uid).doc(usageHistory.id);
      await docRef.set(usageHistory, SetOptions(merge: true));
      logger.d('updateUsageHistory: docRef=$docRef');
      return docRef.id;
    } on Exception catch (e, st) {
      logger.e('updateUsageHistory: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // 利用履歴を削除する
  Future<void> deleteUsageHistory(String uid, String id) async {
    logger.d('deleteUsageHistory: uid=$uid, id=$id');
    try {
      await _collectionRef(uid).doc(id).delete();
      logger.d('deleteUsageHistory: success');
    } on Exception catch (e, st) {
      logger.e('deleteUsageHistory: error=$e, stackTrace=$st');
      rethrow;
    }
  }
}

// Stream
@riverpod
Stream<List<UsageHistory>> usageHistoryListStream(Ref ref, String uid) {
  logger.d('usageHistoryListStream: uid=$uid');
  try {
    return ref.watch(usageHistoryRepositoryProvider).watchUsageHistoryList(uid);
  } on Exception catch (e, st) {
    logger.e('usageHistoryListStream: error=$e, stackTrace=$st');
    rethrow;
  }
}

@riverpod
Stream<UsageHistory> usageHistoryStream(Ref ref, String uid, String id) {
  logger.d('usageHistoryStream: uid=$uid, id=$id');
  try {
    return ref.watch(usageHistoryRepositoryProvider).watchUsageHistory(uid, id);
  } on Exception catch (e, st) {
    logger.e('usageHistoryStream: error=$e, stackTrace=$st');
    rethrow;
  }
}
