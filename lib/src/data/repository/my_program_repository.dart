import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';
import '../model/exception/app_exception.dart';
import '../model/my_program_model.dart';
import 'auth_repository.dart';

part 'my_program_repository.g.dart';

const _defaultPath = 'v/1';
const _collectionPath = '$_defaultPath/users';
const _subCollectionPath = 'my_program';

// MyProgramRepositoryProvider
@Riverpod(keepAlive: true)
MyProgramRepository myProgramRepository(Ref ref) {
  return MyProgramRepository(ref.watch(firebaseFirestoreProvider));
}

class MyProgramRepository {
  MyProgramRepository(this._db);
  final FirebaseFirestore _db;

  CollectionReference<MyProgram> _collectionRef(String uid) {
    return _db
        .collection(_collectionPath)
        .doc(uid)
        .collection(_subCollectionPath)
        .withConverter<MyProgram>(
          fromFirestore:
              (snapshot, _) => MyProgram.fromJson(
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

  /// マイプログラム一覧を取得するストリーム
  Stream<List<MyProgram>> streamMyProgramList(String uid) {
    logger.i('streamMyProgramList: マイプログラム一覧を取得するストリームを開始します uid=$uid');
    try {
      return _collectionRef(uid).snapshots().map((snapshot) {
        logger.i(
          'streamMyProgramList: マイプログラム一覧を取得しました count=${snapshot.docs.length}',
        );
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } on Exception catch (e, st) {
      logger.e('streamMyProgramList: マイプログラム一覧取得エラー', error: e, stackTrace: st);
      throw GeneralException(message: 'マイプログラム一覧の取得に失敗しました', stackTrace: st);
    }
  }

  /// 特定のマイプログラムを取得するストリーム
  Stream<MyProgram> streamMyProgram(String uid, String myProgramId) {
    logger.i(
      'streamMyProgram: 特定のマイプログラムを取得するストリームを開始します uid=$uid, myProgramId=$myProgramId',
    );
    try {
      return _collectionRef(uid).doc(myProgramId).snapshots().map((doc) {
        if (doc.data() == null) {
          logger.e('streamMyProgram: マイプログラムデータが見つかりません');
          throw GeneralException(
            message: 'マイプログラムデータが存在しません',
            stackTrace: StackTrace.current,
          );
        }
        logger.i('streamMyProgram: 特定のマイプログラムを取得しました');
        return doc.data()!;
      });
    } on Exception catch (e, st) {
      logger.e('streamMyProgram: 特定のマイプログラム取得エラー', error: e, stackTrace: st);
      throw GeneralException(message: 'マイプログラムの取得に失敗しました', stackTrace: st);
    }
  }

  /// マイプログラム一覧を一度に取得する
  Future<List<MyProgram>> readMyPrograms(String uid) async {
    logger.i('readMyPrograms: マイプログラム一覧を一度に取得します uid=$uid');
    try {
      final snapshot = await _collectionRef(uid).get();
      logger.i(
        'readMyPrograms: マイプログラム一覧を取得しました count=${snapshot.docs.length}',
      );
      return snapshot.docs.map((doc) => doc.data()).toList();
    } on Exception catch (e, st) {
      logger.e('readMyPrograms: マイプログラム一覧取得エラー', error: e, stackTrace: st);
      throw GeneralException(message: 'マイプログラム一覧の取得に失敗しました', stackTrace: st);
    }
  }

  /// マイプログラムを登録する
  Future<String> createMyProgram(String uid, MyProgram myProgram) async {
    logger.i(
      'createMyProgram: マイプログラムを登録します uid=$uid, programId=${myProgram.programId}',
    );
    try {
      await _collectionRef(uid).doc(myProgram.programId).set(myProgram);
      logger.i('createMyProgram: マイプログラムを登録しました');
      return myProgram.programId!;
    } on Exception catch (e, st) {
      logger.e('createMyProgram: マイプログラム登録エラー', error: e, stackTrace: st);
      throw GeneralException(message: 'マイプログラムの登録に失敗しました', stackTrace: st);
    }
  }

  /// マイプログラムを更新する
  Future<String> updateMyProgram(String uid, MyProgram myProgram) async {
    logger.i(
      'updateMyProgram: マイプログラムを更新します uid=$uid, programId=${myProgram.programId}',
    );
    try {
      final docRef = _collectionRef(uid).doc(myProgram.id);
      await docRef.set(myProgram, SetOptions(merge: true));
      logger.i('updateMyProgram: マイプログラムを更新しました');
      return docRef.id;
    } on Exception catch (e, st) {
      logger.e('updateMyProgram: マイプログラム更新エラー', error: e, stackTrace: st);
      throw GeneralException(message: 'マイプログラムの更新に失敗しました', stackTrace: st);
    }
  }

  /// マイプログラムを削除する
  Future<void> deleteMyProgram(String uid, String myProgramId) async {
    logger.i(
      'deleteMyProgram: マイプログラムを削除します uid=$uid, myProgramId=$myProgramId',
    );
    try {
      await _collectionRef(uid).doc(myProgramId).delete();
      logger.i('deleteMyProgram: マイプログラムを削除しました');
    } on Exception catch (e, st) {
      logger.e('deleteMyProgram: マイプログラム削除エラー', error: e, stackTrace: st);
      throw GeneralException(message: 'マイプログラムの削除に失敗しました', stackTrace: st);
    }
  }

  /// マイプログラムの存在確認を行うストリーム
  Stream<bool> watchMyProgramExists(String uid, String programId) {
    logger.i(
      'watchMyProgramExists: マイプログラムの存在確認ストリームを開始します uid=$uid, programId=$programId',
    );
    try {
      return _collectionRef(uid).doc(programId).snapshots().map((doc) {
        final exists = doc.exists;
        logger.i('watchMyProgramExists: 存在確認完了 exists=$exists');
        return exists;
      });
    } on Exception catch (e, st) {
      logger.e('watchMyProgramExists: 存在確認エラー', error: e, stackTrace: st);
      throw GeneralException(message: 'マイプログラムの存在確認に失敗しました', stackTrace: st);
    }
  }

  /// マイプログラムの存在確認を行う
  Future<bool> checkMyProgramExists(String uid, String programId) async {
    logger.i(
      'checkMyProgramExists: マイプログラムの存在確認を行います uid=$uid, programId=$programId',
    );
    try {
      final doc = await _collectionRef(uid).doc(programId).get();
      final exists = doc.exists;
      logger.i('checkMyProgramExists: 存在確認完了 exists=$exists');
      return exists;
    } on Exception catch (e, st) {
      logger.e('checkMyProgramExists: 存在確認エラー', error: e, stackTrace: st);
      throw GeneralException(message: 'マイプログラムの存在確認に失敗しました', stackTrace: st);
    }
  }
}

// マイプログラムの存在確認プロバイダー
@riverpod
Stream<bool> myProgramExistsStream(Ref ref, String programId) {
  logger.i(
    'myProgramExistsStream: マイプログラムの存在確認ストリームを開始します programId=$programId',
  );
  final uidAsyncValue = ref.watch(userIdProvider);

  return uidAsyncValue.when(
    data: (uid) {
      if (uid == null) {
        logger.i('myProgramExistsStream: ユーザーIDが取得できませんでした');
        return Stream.value(false);
      }
      try {
        return ref
            .watch(myProgramRepositoryProvider)
            .watchMyProgramExists(uid, programId);
      } on Exception catch (e, st) {
        logger.e('myProgramExistsStream: 存在確認エラー', error: e, stackTrace: st);
        throw GeneralException(message: 'マイプログラムの存在確認に失敗しました', stackTrace: st);
      }
    },
    loading: () {
      logger.i('myProgramExistsStream: 認証状態を確認中');
      return Stream.value(false);
    },
    error: (error, stackTrace) {
      logger.e(
        'myProgramExistsStream: 認証状態の取得に失敗しました',
        error: error,
        stackTrace: stackTrace,
      );
      return Stream.value(false);
    },
  );
}
