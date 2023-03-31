import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    final list = _collectionRef(uid).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
    return list;
  }

  Stream<MyProgram> streamMyProgram(String uid, String myProgramId) {
    return _collectionRef(uid).doc(myProgramId).snapshots().map((doc) {
      if (doc.data() == null) {
        throw Error();
      }
      return doc.data()!;
    });
  }

  Future<List<MyProgram>> readMyPrograms(String uid) async {
    return _collectionRef(uid)
        .get()
        .then((value) => value.docs.map((doc) => doc.data()).toList());
  }

  // 登録
  Future<String> createMyProgram(String uid, MyProgram myProgram) async {
    await _collectionRef(uid).doc(myProgram.programId).set(myProgram);
    return myProgram.programId!;
  }

  // 更新
  Future<String> updateMyProgram(String uid, MyProgram myProgram) async {
    final docRef = _collectionRef(uid).doc(myProgram.id);
    await docRef.set(myProgram, SetOptions(merge: true));
    return docRef.id;
  }

  // 削除
  Future<void> deleteMyProgram(String uid, String myProgramId) async {
    await _collectionRef(uid).doc(myProgramId).delete();
  }
}
