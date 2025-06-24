import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';
import '../model/my_program_model.dart';

part 'my_program_repository.g.dart';

const _defaultPath = 'v/1';
const _collectionPath = '$_defaultPath/users';
const _subCollectionPath = 'my_program';

// FavoriteRepositoryProvider
@Riverpod(keepAlive: true)
MyProgramRepository myProgramRepository(MyProgramRepositoryRef ref) {
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
          fromFirestore: (snapshot, _) =>
              MyProgram.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
          toFirestore: (model, _) => {
            ...model.toJson()..remove('id'),
            if (model.createdAt == null)
              'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
          },
        );
  }

  // 取得
  Stream<List<MyProgram>> streamMyProgramList(String uid) {
    logger.d('streamMyProgramList: uid=$uid');
    final list = _collectionRef(uid).snapshots().map((snapshot) {
      logger.d('streamMyProgramList: snapshot=$snapshot');
      return snapshot.docs.map((doc) {
        logger.d('streamMyProgramList: doc=$doc');
        return doc.data();
      }).toList();
    });
    return list;
  }

  Stream<MyProgram> streamMyProgram(String uid, String myProgramId) {
    logger.d('streamMyProgram: uid=$uid, myProgramId=$myProgramId');
    return _collectionRef(uid).doc(myProgramId).snapshots().map((doc) {
      logger.d('streamMyProgram: doc=$doc');
      if (doc.data() == null) {
        logger.e('streamMyProgram: doc.data() is null');
        throw Error();
      }
      return doc.data()!;
    });
  }

  Future<List<MyProgram>> readMyPrograms(String uid) async {
    logger.d('readMyPrograms: uid=$uid');
    try {
      final snapshot = await _collectionRef(uid).get();
      logger.d('readMyPrograms: snapshot=$snapshot');
      return snapshot.docs.map((doc) => doc.data()).toList();
    } on Exception catch (e) {
      logger.e('readMyPrograms: error=$e');
      rethrow;
    }
  }

  // 登録
  Future<String> createMyProgram(String uid, MyProgram myProgram) async {
    logger.d('createMyProgram: uid=$uid, myProgram=$myProgram');
    try {
      await _collectionRef(uid).doc(myProgram.programId).set(myProgram);
      logger.d('createMyProgram: success');
      return myProgram.programId!;
    } on Exception catch (e) {
      logger.e('createMyProgram: error=$e');
      rethrow;
    }
  }

  // 更新
  Future<String> updateMyProgram(String uid, MyProgram myProgram) async {
    logger.d('updateMyProgram: uid=$uid, myProgram=$myProgram');
    try {
      final docRef = _collectionRef(uid).doc(myProgram.id);
      await docRef.set(myProgram, SetOptions(merge: true));
      logger.d('updateMyProgram: success');
      return docRef.id;
    } on Exception catch (e) {
      logger.e('updateMyProgram: error=$e');
      rethrow;
    }
  }

  // 削除
  Future<void> deleteMyProgram(String uid, String myProgramId) async {
    logger.d('deleteMyProgram: uid=$uid, myProgramId=$myProgramId');
    try {
      await _collectionRef(uid).doc(myProgramId).delete();
      logger.d('deleteMyProgram: success');
    } on Exception catch (e) {
      logger.e('deleteMyProgram: error=$e');
      rethrow;
    }
  }
}
