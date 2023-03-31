import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../general_provider.dart';
import '../model/favorite_model.dart';
import 'auth_repository.dart';

part 'favorite_repository.g.dart';

const _defaultPath = 'v/1';
const _collectionPath = '$_defaultPath/users';
const _subCollectionPath = 'favorite';

// FavoriteRepositoryProvider
@Riverpod(keepAlive: true)
FavoriteRepository favoriteRepository(FavoriteRepositoryRef ref) {
  return FavoriteRepository(ref.watch(firebaseFirestoreProvider));
}

class FavoriteRepository {
  FavoriteRepository(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Favorite> _collectionRef(String uid) {
    return _db
        .collection(_collectionPath)
        .doc(uid)
        .collection(_subCollectionPath)
        .withConverter<Favorite>(
          fromFirestore: (snapshot, _) =>
              Favorite.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
          toFirestore: (model, _) => {
            ...model.toJson()..remove('id'),
            if (model.createdAt == null)
              'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
          },
        );
  }

  // 取得
  Stream<List<Favorite>> streamFavoriteList(String uid) {
    final list = _collectionRef(uid).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
    return list;
  }

  Stream<Favorite> streamFavorite(String uid, String favoriteId) {
    return _collectionRef(uid).doc(favoriteId).snapshots().map((doc) {
      if (doc.data() == null) {
        throw Error();
      }
      return doc.data()!;
    });
  }

  Future<List<Favorite>> readFavorites(String uid) async {
    return _collectionRef(uid)
        .get()
        .then((value) => value.docs.map((doc) => doc.data()).toList());
  }

  // 登録
  Future<String> createFavorite(String uid, Favorite favorite) async {
    // final docRef = await _collectionRef(uid).add(favorite);
    // return docRef.id;
    await _collectionRef(uid).doc(favorite.programId).set(favorite);

    return favorite.programId!;
  }

  // 更新
  Future<String> updateFavorite(String uid, Favorite favorite) async {
    final docRef = _collectionRef(uid).doc(favorite.id);
    await docRef.set(favorite, SetOptions(merge: true));
    return docRef.id;
  }

  // 削除
  Future<void> deleteFavorite(String uid, String favoriteId) async {
    await _collectionRef(uid).doc(favoriteId).delete();
  }

  Stream<bool> watchExistenceFavorite(String uid, String favoriteId) {
    return _collectionRef(uid)
        .doc(favoriteId)
        .snapshots()
        .map((event) => event.exists);
  }
}

@riverpod
Stream<bool> favoriteCheckExistence(
  FavoriteCheckExistenceRef ref,
  String favoriteId,
) {
  final uidAsyncValue = ref.watch(userIdProvider);
  final uid = uidAsyncValue.value;
  if (uid == null) {
    return Stream.value(false);
  }
  return ref
      .watch(favoriteRepositoryProvider)
      .watchExistenceFavorite(uid, favoriteId);
}
