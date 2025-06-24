import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';
import '../model/user_model.dart';

part 'user_repository.g.dart';

const _defaultPath = 'v/1';
const _userCollectionPath = '$_defaultPath/users';
const _publicUsersCollectionPath = '$_defaultPath/public_users';
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

  // ユーザー情報を取得するストリーム
  Stream<User> watchUser(String uid) {
    logger.d('watchUser: uid=$uid');
    try {
      final docRef = _collectionRef.doc(uid);
      return docRef.snapshots().map((user) => user.data()!);
    } on Exception catch (e, st) {
      logger.e('watchUser: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // ユーザー情報を取得する
  Future<User> readUser(String uid) async {
    logger.d('readUser: uid=$uid');
    try {
      final docRef = _collectionRef.doc(uid);
      final snap = await docRef.get();
      final data = snap.data();
      if (data == null) {
        logger.e('readUser: data is null');
        throw Error();
      }
      return data;
    } on Exception catch (e, st) {
      logger.e('readUser: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // ユーザー情報を登録する
  Future<String> createUser(User user) async {
    logger.d('createUser: user=$user');
    try {
      final docRef = await _collectionRef.add(user);
      logger.d('createUser: docRef=$docRef');
      return docRef.id;
    } on Exception catch (e, st) {
      logger.e('createUser: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // ユーザー情報を更新する
  Future<String> updateUser(User user) async {
    logger.d('updateUser: user=$user');
    try {
      final docRef = _collectionRef.doc(user.id);
      await docRef.set(user, SetOptions(merge: true));
      logger.d('updateUser: success');
      return docRef.id;
    } on Exception catch (e, st) {
      logger.e('updateUser: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // ユーザー情報を削除する
  Future<void> deleteUser(String uid) async {
    logger.d('deleteUser: uid=$uid');
    try {
      await _collectionRef.doc(uid).delete();
      logger.d('deleteUser: success');
    } on Exception catch (e, st) {
      logger.e('deleteUser: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // Stripe Customer の存在確認
  Future<bool> checkExistenceCustomer(String uid) async {
    logger.d('checkExistenceCustomer: uid=$uid');
    try {
      final doc = await _db.collection(_customerCollectionPath).doc(uid).get();
      logger.d('checkExistenceCustomer: doc=$doc');
      return doc.exists;
    } on Exception catch (e, st) {
      logger.e('checkExistenceCustomer: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // Stripe Connect Account の存在確認
  Future<bool> checkExistenceAccount(String uid) async {
    logger.d('checkExistenceAccount: uid=$uid');
    try {
      final doc = await _db.collection(_accountCollectionPath).doc(uid).get();
      logger.d('checkExistenceAccount: doc=$doc');
      return doc.exists;
    } on Exception catch (e, st) {
      logger.e('checkExistenceAccount: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // Stripe Connect Account の存在確認 (ストリーム)
  Stream<bool> streamCheckExistenceAccount(String uid) {
    logger.d('streamCheckExistenceAccount: uid=$uid');
    try {
      final snapshot =
          _db.collection(_accountCollectionPath).doc(uid).snapshots();
      return snapshot.map((doc) => doc.exists);
    } on Exception catch (e, st) {
      logger.e('streamCheckExistenceAccount: error=$e, stackTrace=$st');
      rethrow;
    }
  }
}

// Stream
@riverpod
Stream<User> userStream(UserStreamRef ref, String uid) {
  logger.d('userStream: uid=$uid');
  try {
    return ref.watch(userRepositoryProvider).watchUser(uid);
  } on Exception catch (e, st) {
    logger.e('userStream: error=$e, stackTrace=$st');
    rethrow;
  }
}

// publicUser
// UserRepositoryProvider
@Riverpod(keepAlive: true)
PublicUserRepository publicUserRepository(PublicUserRepositoryRef ref) {
  return PublicUserRepository(ref.watch(firebaseFirestoreProvider));
}

class PublicUserRepository {
  PublicUserRepository(this._db);
  final FirebaseFirestore _db;

  late final CollectionReference<PublicUsers> _collectionRef = _db
      .collection(_publicUsersCollectionPath)
      .withConverter<PublicUsers>(
        fromFirestore: (snapshot, _) =>
            PublicUsers.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
        toFirestore: (model, _) => {
          ...model.toJson()..remove('id'),
          if (model.createdAt == null)
            'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
      );

  // 公開ユーザー情報を取得するストリーム
  Stream<PublicUsers> watchUser(String uid) {
    logger.d('watchUser: uid=$uid');
    try {
      final docRef = _collectionRef.doc(uid);
      return docRef.snapshots().map((user) => user.data()!);
    } on Exception catch (e, st) {
      logger.e('watchUser: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // 公開ユーザー情報を取得する
  Future<PublicUsers> readUser(String uid) async {
    logger.d('readUser: uid=$uid');
    try {
      final docRef = _collectionRef.doc(uid);
      final snap = await docRef.get();
      final data = snap.data();
      if (data == null) {
        logger.e('readUser: data is null');
        throw Error();
      }
      return data;
    } on Exception catch (e, st) {
      logger.e('readUser: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // 公開ユーザー情報を更新する
  Future<void> updateUser(User user) async {
    logger.d('updateUser: user=$user');
    try {
      final publicUser = PublicUsers(
        id: user.id,
        displayName: user.displayName,
        createdAt: user.createdAt,
      );
      final docRef = _collectionRef.doc(publicUser.id);
      await docRef.set(publicUser, SetOptions(merge: true));
      logger.d('updateUser: success');
    } on Exception catch (e, st) {
      logger.e('updateUser: error=$e, stackTrace=$st');
      rethrow;
    }
  }
}

// Stream
@riverpod
Stream<PublicUsers> publicUserStream(PublicUserStreamRef ref, String uid) {
  logger.d('publicUserStream: uid=$uid');
  try {
    return ref.watch(publicUserRepositoryProvider).watchUser(uid);
  } on Exception catch (e, st) {
    logger.e('publicUserStream: error=$e, stackTrace=$st');
    rethrow;
  }
}

@riverpod
Future<PublicUsers> publicUserFuture(PublicUserFutureRef ref, String uid) {
  logger.d('publicUserFuture: uid=$uid');
  try {
    return ref.watch(publicUserRepositoryProvider).readUser(uid);
  } on Exception catch (e, st) {
    logger.e('publicUserFuture: error=$e, stackTrace=$st');
    rethrow;
  }
}
