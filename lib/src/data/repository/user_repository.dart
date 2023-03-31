import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../general_provider.dart';
import '../model/user_model.dart';

part 'user_repository.g.dart';

const _defaultPath = 'v/1';
const _userCollectionPath = '$_defaultPath/users';
const _customerCollectionPath = '$_defaultPath/stripe_customers';
const _accountCollectionPath = '$_defaultPath/stripe_connect_accounts';

// UserRepositoryProvider
@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepository(ref.watch(firebaseFirestoreProvider));
}

class UserRepository {
  UserRepository(this._db);
  final FirebaseFirestore _db;

  late final CollectionReference<User> _collectionRef =
      _db.collection(_userCollectionPath).withConverter<User>(
            fromFirestore: (snapshot, _) =>
                User.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
            toFirestore: (model, _) => {
              ...model.toJson()..remove('id'),
              if (model.createdAt == null)
                'createdAt': FieldValue.serverTimestamp(),
              'updatedAt': FieldValue.serverTimestamp(),
            },
          );

  // 取得
  Stream<User> watchUser(String uid) {
    final docRef = _collectionRef.doc(uid);
    return docRef.snapshots().map((user) => user.data()!);
  }

  Future<User> readUser(String uid) async {
    final docRef = _collectionRef.doc(uid);
    final snap = await docRef.get();
    final data = snap.data();
    return data!;
  }

  // 保存
  Future<String> createUser(User user) async {
    final docRef = await _collectionRef.add(user);
    return docRef.id;
  }

  // 更新
  Future<String> updateUser(User user) async {
    final docRef = _collectionRef.doc(user.id);
    await docRef.set(user, SetOptions(merge: true));
    return docRef.id;
  }

  // 削除
  Future<void> deleteUser(String uid) async {
    return _collectionRef.doc(uid).delete();
  }

  //
  Future<bool> checkExistenceCustomer(String uid) async {
    final doc = await _db.collection(_customerCollectionPath).doc(uid).get();
    return doc.exists;
  }

  Future<bool> checkExistenceAccount(String uid) async {
    final doc = await _db.collection(_accountCollectionPath).doc(uid).get();
    return doc.exists;
  }

  Stream<bool> streamCheckExistenceAccount(String uid) {
    final snapshot =
        _db.collection(_accountCollectionPath).doc(uid).snapshots();
    return snapshot.map((doc) => doc.exists);
  }
}

// Stream
@riverpod
Stream<User> userStream(UserStreamRef ref, String uid) {
  return ref.watch(userRepositoryProvider).watchUser(uid);
}
