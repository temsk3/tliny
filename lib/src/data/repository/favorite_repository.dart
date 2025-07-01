import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../general_provider.dart';
import '../model/exception/app_exception.dart';
import '../model/favorite_model.dart';
import 'auth_repository.dart';

part 'favorite_repository.g.dart';

final logger = Logger();

const _defaultPath = 'v/1';
const _collectionPath = '$_defaultPath/users';
const _subCollectionPath = 'favorite';

// FavoriteRepositoryProvider
@Riverpod(keepAlive: true)
FavoriteRepository favoriteRepository(Ref ref) {
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
          fromFirestore:
              (snapshot, _) =>
                  Favorite.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
          toFirestore:
              (model, _) => {
                ...model.toJson()..remove('id'),
                if (model.createdAt == null)
                  'createdAt': FieldValue.serverTimestamp(),
                'updatedAt': FieldValue.serverTimestamp(),
              },
        );
  }

  // お気に入りのリストを取得するストリーム
  Stream<List<Favorite>> streamFavoriteList(String uid) {
    logger.i('streamFavoriteList: お気に入りのリストを取得するストリームを開始します');
    try {
      final list = _collectionRef(uid).snapshots().map((snapshot) {
        logger.i('streamFavoriteList: お気に入りのリストを取得しました');
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
      return list;
    } on Exception catch (e, st) {
      logger.e(
        'streamFavoriteList: お気に入りのリスト取得に失敗しました',
        error: e,
        stackTrace: st,
      );
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  // 特定のお気に入りデータを取得するストリーム
  Stream<Favorite> streamFavorite(String uid, String favoriteId) {
    logger.i('streamFavorite: 特定のお気に入りデータを取得するストリームを開始します');
    try {
      return _collectionRef(uid).doc(favoriteId).snapshots().map((doc) {
        if (doc.data() == null) {
          logger.e('streamFavorite: お気に入りデータが見つかりません');
          throw Error();
        }
        logger.i('streamFavorite: 特定のお気に入りデータを取得しました');
        return doc.data()!;
      });
    } on Exception catch (e, st) {
      logger.e(
        'streamFavorite: 特定のお気に入りデータ取得に失敗しました',
        error: e,
        stackTrace: st,
      );
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  // お気に入りのリストを一度に取得する
  Future<List<Favorite>> readFavorites(String uid) async {
    logger.i('readFavorites: お気に入りのリストを一度に取得します');
    try {
      final querySnapshot = await _collectionRef(uid).get();
      logger.i('readFavorites: お気に入りのリストを一度に取得しました');
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } on Exception catch (e, st) {
      logger.e('readFavorites: お気に入りのリスト取得に失敗しました', error: e, stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  // お気に入りを登録する
  Future<String> createFavorite(String uid, Favorite favorite) async {
    logger.i('createFavorite: お気に入りを登録します');
    try {
      await _collectionRef(uid).doc(favorite.programId).set(favorite);
      logger.i('createFavorite: お気に入りを登録しました');
      return favorite.programId!;
    } on Exception catch (e, st) {
      logger.e('createFavorite: お気に入りの登録に失敗しました', error: e, stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  // お気に入りを更新する
  Future<String> updateFavorite(String uid, Favorite favorite) async {
    logger.i('updateFavorite: お気に入りを更新します');
    try {
      final docRef = _collectionRef(uid).doc(favorite.id);
      await docRef.set(favorite, SetOptions(merge: true));
      logger.i('updateFavorite: お気に入りを更新しました');
      return docRef.id;
    } on Exception catch (e, st) {
      logger.e('updateFavorite: お気に入りの更新に失敗しました', error: e, stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  // お気に入りを削除する
  Future<void> deleteFavorite(String uid, String favoriteId) async {
    logger.i('deleteFavorite: お気に入りを削除します');
    try {
      await _collectionRef(uid).doc(favoriteId).delete();
      logger.i('deleteFavorite: お気に入りを削除しました');
    } on Exception catch (e, st) {
      logger.e('deleteFavorite: お気に入りの削除に失敗しました', error: e, stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  // お気に入りの存在を確認するストリーム
  Stream<bool> watchExistenceFavorite(String uid, String favoriteId) {
    logger.i('watchExistenceFavorite: お気に入りの存在を確認するストリームを開始します');
    try {
      return _collectionRef(
        uid,
      ).doc(favoriteId).snapshots().map((event) => event.exists);
    } on Exception catch (e, st) {
      logger.e(
        'watchExistenceFavorite: お気に入りの存在確認に失敗しました',
        error: e,
        stackTrace: st,
      );
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }
}

// お気に入りの存在を確認するプロバイダー
@riverpod
Stream<bool> favoriteCheckExistence(Ref ref, String favoriteId) {
  logger.i('favoriteCheckExistence: お気に入りの存在を確認します');
  final uidAsyncValue = ref.watch(userIdProvider);

  return uidAsyncValue.when(
    data: (uid) {
      if (uid == null) {
        logger.i('favoriteCheckExistence: ユーザーIDが取得できませんでした');
        return Stream.value(false);
      }
      try {
        return ref
            .watch(favoriteRepositoryProvider)
            .watchExistenceFavorite(uid, favoriteId);
      } on Exception catch (e, st) {
        logger.e(
          'favoriteCheckExistence: お気に入りの存在確認に失敗しました',
          error: e,
          stackTrace: st,
        );
        throw GeneralException(message: e.toString(), stackTrace: st);
      }
    },
    loading: () {
      logger.i('favoriteCheckExistence: 認証状態を確認中');
      return Stream.value(false);
    },
    error: (error, stackTrace) {
      logger.e(
        'favoriteCheckExistence: 認証状態の取得に失敗しました',
        error: error,
        stackTrace: stackTrace,
      );
      return Stream.value(false);
    },
  );
}
