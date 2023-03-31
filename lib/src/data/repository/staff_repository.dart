import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repository/auth_repository.dart';
import '../general_provider.dart';
import '../model/staff_model.dart';

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

  // Stream<Staff> streamStaff(String eventId, String uid) {
  //   return _ref
  //       .read(firebaseFirestoreProvider)
  //       .collection(_eventCollectionPath)
  //       .doc(eventId)
  //       .collection(_collectionPath)
  //       .doc(uid)
  //       .snapshots()
  //       .map(
  //         (doc) => doc.exists
  //             ? Staff.fromJson(doc.data()!).copyWith(id: doc.id)
  //             : Staff.empty(),
  //       );
  // }

  Stream<List<Staff>> streamStaffs(String eventId) {
    return _collectionRef(eventId).snapshots().map(
          (snap) => snap.docs.map((doc) => doc.data()).toList(),
        );
  }

  // 取得
  Future<List<Staff>> readStaffs(String eventId) async {
    final querySnapshot = await _collectionRef(eventId).get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  // 登録
  Future<String> createStaff(String eventId, Staff staff, String uid) async {
    final docRef = _collectionRef(eventId).doc(uid);
    await docRef.set(staff, SetOptions(merge: true));
    return docRef.id;
  }

  // 更新
  Future<String> updateStaff(String eventId, Staff staff) async {
    final docRef = _collectionRef(eventId).doc(staff.id);
    await docRef.set(
      staff,
      SetOptions(merge: true),
    );
    return docRef.id;
  }

  // 削除
  Future<void> deleteStaff(String eventId, String staffId) async {
    await _collectionRef(eventId).doc(staffId).update({'isActive': false});
  }

  Future<bool> checkExistenceStaff(String eventId, String uid) async {
    return _collectionRef(eventId).doc(uid).get().then((doc) => doc.exists);
  }

  Stream<bool> watchExistenceStaff(String eventId, String uid) {
    return _collectionRef(eventId)
        .doc(uid)
        .snapshots()
        .map((event) => event.exists);
  }

  // Future<Staff?> searchStaff(String eventId, String uid) async {
  //   // 検索
  //   return _collectionRef(eventId).doc(uid).get().then((doc) => doc.data());
  // }
}

@riverpod
Stream<bool> staffCheckExistence(StaffCheckExistenceRef ref, String eventId) {
  final uidAsyncValue = ref.watch(userIdProvider);
  final uid = uidAsyncValue.value;
  if (uid == null) {
    return Stream.value(false);
  }
  return ref.watch(staffRepositoryProvider).watchExistenceStaff(eventId, uid);
}
