import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';
import '../model/exception/app_exception.dart';

part 'uuid_repository.g.dart';

@Riverpod(keepAlive: true)
UuidRepository uuidRepository(Ref ref) {
  return UuidRepository(ref.watch(firebaseFirestoreProvider));
}

class UuidRepository {
  UuidRepository(this._db);
  final FirebaseFirestore _db;

  /// 一意のUUIDを生成する
  Future<String> createUuid() async {
    logger.i('createUuid: 一意のUUIDを生成します');
    try {
      const uuid = Uuid();
      var newId = uuid.v4();

      // 既存のIDリストを取得
      final snapShot =
          await _db.collection('/v/1/platform/spel1/storage_id').get();
      final idList = snapShot.docs.map((e) => e.id).toList();

      // 重複しないIDが見つかるまで生成
      while (idList.any((id) => id == newId)) {
        newId = uuid.v4();
      }

      // 新しいIDを保存
      await _db.collection('/v/1/platform/spel1/storage_id').doc(newId).set({
        'createdAt': FieldValue.serverTimestamp(),
      });

      logger.i('createUuid: 一意のUUIDを生成しました: $newId');
      return newId;
    } on FirebaseException catch (e, st) {
      logger.e('createUuid: Firebaseエラー', error: e, stackTrace: st);
      throw GeneralException(
        message: 'UUIDの生成に失敗しました: ${e.message}',
        stackTrace: st,
      );
    } on Exception catch (e, st) {
      logger.e('createUuid: 予期しないエラー', error: e, stackTrace: st);
      throw GeneralException(message: 'UUIDの生成に失敗しました', stackTrace: st);
    }
  }

  /// 複数のUUIDを一括生成する
  Future<List<String>> createMultipleUuids(int count) async {
    logger.i('createMultipleUuids: $count個のUUIDを一括生成します');
    try {
      final uuids = <String>[];
      for (var i = 0; i < count; i++) {
        final uuid = await createUuid();
        uuids.add(uuid);
      }
      logger.i('createMultipleUuids: $count個のUUIDを生成しました');
      return uuids;
    } on Exception catch (e, st) {
      logger.e('createMultipleUuids: 一括UUID生成エラー', error: e, stackTrace: st);
      throw GeneralException(message: '一括UUID生成に失敗しました', stackTrace: st);
    }
  }

  /// UUIDの存在確認を行う
  Future<bool> checkUuidExists(String uuid) async {
    logger.i('checkUuidExists: UUIDの存在確認を行います: $uuid');
    try {
      final doc =
          await _db
              .collection('/v/1/platform/spel1/storage_id')
              .doc(uuid)
              .get();

      final exists = doc.exists;
      logger.i('checkUuidExists: UUIDの存在確認完了 exists=$exists');
      return exists;
    } on FirebaseException catch (e, st) {
      logger.e('checkUuidExists: Firebaseエラー', error: e, stackTrace: st);
      throw GeneralException(
        message: 'UUIDの存在確認に失敗しました: ${e.message}',
        stackTrace: st,
      );
    } on Exception catch (e, st) {
      logger.e('checkUuidExists: 予期しないエラー', error: e, stackTrace: st);
      throw GeneralException(message: 'UUIDの存在確認に失敗しました', stackTrace: st);
    }
  }
}
