import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';
import '../model/staff_model.dart';
import 'auth_repository.dart';

part 'staff_repository.g.dart';

const _defaultPath = 'v/1';
const _eventCollectionPath = '$_defaultPath/events';
const _collectionPath = 'staffs';

// StaffRepositoryProvider
@Riverpod(keepAlive: true)
StaffRepository staffRepository(StaffRepositoryRef ref) {
  return StaffRepository(ref.watch(firebaseFirestoreProvider));
}

class StaffRepository {
  StaffRepository(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Staff> _collectionRef(String eventId) {
    return _db
        .collection(_eventCollectionPath)
        .doc(eventId)
        .collection(_collectionPath)
        .withConverter<Staff>(
          fromFirestore: (snapshot, _) =>
              Staff.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
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

  /// イベントIDを指定してスタッフ一覧を取得するストリーム
  Stream<List<Staff>> streamStaffs(String eventId) {
    logger.d('streamStaffs: eventId=$eventId');
    try {
      return _collectionRef(eventId).snapshots().map(
        (snap) {
          logger.d('streamStaffs: snap=$snap');
          return snap.docs.map((doc) => doc.data()).toList();
        },
      );
    } on Exception catch (e, st) {
      logger.e('streamStaffs: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  /// イベントIDを指定してスタッフ一覧を取得する
  Future<List<Staff>> readStaffs(String eventId) async {
    logger.d('readStaffs: eventId=$eventId');
    try {
      final querySnapshot = await _collectionRef(eventId).get();
      logger.d('readStaffs: querySnapshot=$querySnapshot');
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } on Exception catch (e, st) {
      logger.e('readStaffs: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  /// イベントIDとスタッフ情報を指定してスタッフを登録する
  Future<String> createStaff(String eventId, Staff staff, String uid) async {
    logger.d('createStaff: eventId=$eventId, staff=$staff, uid=$uid');
    try {
      final docRef = _collectionRef(eventId).doc(uid);
      await docRef.set(staff, SetOptions(merge: true));
      logger.d('createStaff: success');
      return docRef.id;
    } on Exception catch (e, st) {
      logger.e('createStaff: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  /// イベントIDとスタッフ情報を指定してスタッフを更新する
  Future<String> updateStaff(String eventId, Staff staff) async {
    logger.d('updateStaff: eventId=$eventId, staff=$staff');
    try {
      final docRef = _collectionRef(eventId).doc(staff.id);
      await docRef.set(
        staff,
        SetOptions(merge: true),
      );
      logger.d('updateStaff: success');
      return docRef.id;
    } on Exception catch (e, st) {
      logger.e('updateStaff: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  /// イベントIDとスタッフIDを指定してスタッフを削除する
  Future<void> deleteStaff(String eventId, String staffId) async {
    logger.d('deleteStaff: eventId=$eventId, staffId=$staffId');
    try {
      await _collectionRef(eventId).doc(staffId).update({'isActive': false});
      logger.d('deleteStaff: success');
    } on Exception catch (e, st) {
      logger.e('deleteStaff: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  /// イベントIDとユーザーIDを指定してスタッフの存在確認を行う
  Future<bool> checkExistenceStaff(String eventId, String uid) async {
    logger.d('checkExistenceStaff: eventId=$eventId, uid=$uid');
    try {
      final doc = await _collectionRef(eventId).doc(uid).get();
      logger.d('checkExistenceStaff: doc=$doc');
      return doc.exists;
    } on Exception catch (e, st) {
      logger.e('checkExistenceStaff: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  /// イベントIDとユーザーIDを指定してスタッフの存在確認を行うストリーム
  Stream<bool> watchExistenceStaff(String eventId, String uid) {
    logger.d('watchExistenceStaff: eventId=$eventId, uid=$uid');
    try {
      return _collectionRef(eventId).doc(uid).snapshots().map((event) {
        logger.d('watchExistenceStaff: event=$event');
        return event.exists;
      });
    } on Exception catch (e, st) {
      logger.e('watchExistenceStaff: error=$e, stackTrace=$st');
      rethrow;
    }
  }
}

/// イベントIDを指定して、ログイン中のユーザーがスタッフかどうかを確認するストリーム
@riverpod
Stream<bool> staffCheckExistence(StaffCheckExistenceRef ref, String eventId) {
  logger.d('staffCheckExistence: eventId=$eventId');
  final uidAsyncValue = ref.watch(userIdProvider);
  final uid = uidAsyncValue.value;
  if (uid == null) {
    logger.d('staffCheckExistence: uid is null');
    return Stream.value(false);
  }
  logger.d('staffCheckExistence: uid=$uid');
  return ref.watch(staffRepositoryProvider).watchExistenceStaff(eventId, uid);
}
