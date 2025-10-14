import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';
import '../model/exception/app_exception.dart';
import '../model/program_model.dart';

part 'program_repository.g.dart';

const _defaultPath = 'v/1';
const _collectionPath = '$_defaultPath/events';

// ProgramRepositoryProvider
@Riverpod(keepAlive: true)
ProgramRepository programRepository(Ref ref) {
  return ProgramRepository(ref.watch(firebaseFirestoreProvider));
}

class ProgramRepository {
  ProgramRepository(this._db);
  final FirebaseFirestore _db;

  late final CollectionReference<Program> _collectionRef = _db
      .collection(_collectionPath)
      .withConverter<Program>(
        fromFirestore: (snapshot, _) =>
            Program.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
        toFirestore: (model, _) => {
          ...model.toJson()..remove('id'),
          if (model.createdAt == null)
            'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          if (model.isActive == false)
            'deletedAt': FieldValue.serverTimestamp(),
        },
      );

  // イベント一覧を取得するストリーム（シークレットイベントは除外）
  Stream<List<Program>> watchEventList() {
    logger.d('watchEventList');
    try {
      final list = _collectionRef
          .where('isSecret', isEqualTo: false)
          .snapshots()
          .map((snapshot) {
            logger.d('watchEventList: snapshot=$snapshot');
            return snapshot.docs.map((doc) {
              logger.d('watchEventList: doc=$doc');
              return doc.data();
            }).toList();
          });
      return list;
    } on Exception catch (e, st) {
      logger.e('watchEventList: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // イベント詳細を取得するストリーム
  Stream<Program> watchEvent(String eventId) {
    logger.d('watchEvent: eventId=$eventId');
    try {
      return _collectionRef.doc(eventId).snapshots().map((snapshot) {
        logger.d('watchEvent: snapshot=$snapshot');
        if (snapshot.exists) {
          logger.d('watchEvent: イベントを取得しました');
          return snapshot.data()!;
        } else {
          logger.e('watchEvent: イベントが存在しません');
          throw GeneralException(
            message: 'イベントが存在しません',
            stackTrace: StackTrace.current,
          );
        }
      });
    } on Exception catch (e, st) {
      logger.e('watchEvent: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // オーナーIDでイベント一覧を取得するストリーム（非表示設定とシークレットイベントは除外）
  Stream<List<Program>> watchEventsByOrganizer(String organizerId) {
    logger.d('watchEventsByOrganizer: organizerId=$organizerId');
    try {
      return _collectionRef
          .where('organizerId', isEqualTo: organizerId)
          .where('isActive', isEqualTo: true)
          .where('isPublish', isEqualTo: true)
          .where('isSecret', isEqualTo: false)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
            logger.d('watchEventsByOrganizer: snapshot=$snapshot');
            return snapshot.docs.map((doc) {
              logger.d('watchEventsByOrganizer: doc=$doc');
              return doc.data();
            }).toList();
          })
          .handleError((error, stackTrace) {
            logger.e(
              'watchEventsByOrganizer: Firestore error=$error, stackTrace=$stackTrace',
            );
            if (error.toString().contains('index')) {
              throw GeneralException(
                message: 'データベースのインデックスが不足しています。管理者にお問い合わせください。',
                stackTrace: stackTrace as StackTrace?,
              );
            } else if (error.toString().contains('permission')) {
              throw GeneralException(
                message: 'アクセス権限がありません。',
                stackTrace: stackTrace as StackTrace?,
              );
            } else {
              throw GeneralException(
                message: 'イベント一覧の取得に失敗しました: $error',
                stackTrace: stackTrace as StackTrace?,
              );
            }
          });
    } on Exception catch (e, st) {
      logger.e('watchEventsByOrganizer: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // イベント一覧を取得する（シークレットイベントは除外）
  Future<List<Program>> readEvents() async {
    logger.d('readEvents');
    try {
      final querySnapshot = await _collectionRef
          .where('isSecret', isEqualTo: false)
          .get();
      logger.d('readEvents: querySnapshot=$querySnapshot');
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } on Exception catch (e, st) {
      logger.e('readEvents: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // イベント詳細を取得する
  Future<Program?> readEvent(String eventId) async {
    logger.d('readEvent: eventId=$eventId');
    try {
      final snapshot = await _collectionRef.doc(eventId).get();
      logger.d('readEvent: snapshot=$snapshot');
      return snapshot.data();
    } on Exception catch (e, st) {
      logger.e('readEvent: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // イベントを登録する
  Future<String> createEvent(Program event) async {
    logger.d('createEvent: event=$event');
    try {
      final docRef = await _collectionRef.add(event);
      logger.d('createEvent: docRef=$docRef');
      return docRef.id;
    } on Exception catch (e, st) {
      logger.e('createEvent: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // イベントを更新する
  Future<String> updateEvent(Program event) async {
    logger.d('updateEvent: event=$event');
    try {
      final docRef = _collectionRef.doc(event.id);
      await docRef.set(event, SetOptions(merge: true));
      logger.d('updateEvent: success');
      return docRef.id;
    } on Exception catch (e, st) {
      logger.e('updateEvent: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // イベントを削除する
  Future<void> deleteEvent(String eventId) async {
    logger.d('deleteEvent: eventId=$eventId');
    try {
      await _collectionRef.doc(eventId).update({'isActive': false});
      logger.d('deleteEvent: success');
    } on Exception catch (e, st) {
      logger.e('deleteEvent: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // イベントを取得する
  Future<Program> getProduct(String docRef) async {
    logger.d('getProduct: docRef=$docRef');
    try {
      final snapshot = await _collectionRef.doc(docRef).get();
      if (snapshot.exists) {
        logger.d('getProduct: イベントを取得しました');
        return snapshot.data()!;
      } else {
        logger.e('getProduct: イベントが存在しません');
        throw GeneralException(
          message: 'イベントが存在しません',
          stackTrace: StackTrace.current,
        );
      }
    } on Exception catch (e, st) {
      logger.e('getProduct: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // シークレットURLでイベントを取得する
  Future<Program?> getEventBySecretUrl(String secretUrl) async {
    logger.d('getEventBySecretUrl: secretUrl=$secretUrl');
    try {
      final querySnapshot = await _collectionRef
          .where('secretUrl', isEqualTo: secretUrl)
          .where('isSecret', isEqualTo: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        logger.d('getEventBySecretUrl: シークレットイベントを取得しました');
        return querySnapshot.docs.first.data();
      } else {
        logger.d('getEventBySecretUrl: シークレットイベントが見つかりません');
        return null;
      }
    } on Exception catch (e, st) {
      logger.e('getEventBySecretUrl: error=$e, stackTrace=$st');
      rethrow;
    }
  }
}

@riverpod
Stream<List<Program>> programsStream(Ref ref) {
  logger.d('programsStream');
  try {
    return ref.watch(programRepositoryProvider).watchEventList();
  } on Exception catch (e, st) {
    logger.e('programsStream: error=$e, stackTrace=$st');
    rethrow;
  }
}

@riverpod
Stream<Program> programStream(Ref ref, String programId) {
  logger.d('programStream: programId=$programId');
  try {
    return ref.watch(programRepositoryProvider).watchEvent(programId);
  } on Exception catch (e, st) {
    logger.e('programStream: error=$e, stackTrace=$st');
    rethrow;
  }
}

@riverpod
Future<Program?> programFuture(Ref ref, String programId) {
  logger.d('programFuture: programId=$programId');
  try {
    return ref.watch(programRepositoryProvider).readEvent(programId);
  } on Exception catch (e, st) {
    logger.e('programFuture: error=$e, stackTrace=$st');
    rethrow;
  }
}

@riverpod
Stream<List<Program>> programsByOrganizerStream(Ref ref, String organizerId) {
  logger.d('programsByOrganizerStream: organizerId=$organizerId');
  try {
    return ref
        .watch(programRepositoryProvider)
        .watchEventsByOrganizer(organizerId);
  } on Exception catch (e, st) {
    logger.e('programsByOrganizerStream: error=$e, stackTrace=$st');
    rethrow;
  }
}
