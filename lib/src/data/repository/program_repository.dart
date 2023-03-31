import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../general_provider.dart';
import '../model/program_model.dart';

part 'program_repository.g.dart';

const _defaultPath = 'v/1';
const _collectionPath = '$_defaultPath/events';
const _subCollectionPath = 'staffs';

// ProgramRepositoryProvider
@Riverpod(keepAlive: true)
ProgramRepository programRepository(ProgramRepositoryRef ref) {
  return ProgramRepository(ref.watch(firebaseFirestoreProvider));
}

class ProgramRepository {
  ProgramRepository(this._db);
  final FirebaseFirestore _db;

  late final _collectionRef =
      _db.collection(_collectionPath).withConverter<Program>(
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

  // 取得
  Stream<List<Program>> watchEventList() {
    final list = _collectionRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
    return list;
  }

  Stream<Program> watchEvent(String eventId) {
    return _collectionRef.doc(eventId).snapshots().map((doc) {
      if (doc.data() == null) {
        throw Error();
      }
      return doc.data()!;
    });
  }

  Future<List<Program>> readEvents() async {
    return _collectionRef
        .get()
        .then((value) => value.docs.map((doc) => doc.data()).toList());
  }

  Future<Program?> readEvent(String eventId) async {
    return _collectionRef.doc(eventId).get().then((value) => value.data());
  }

  // 登録
  Future<String> createEvent(Program event) async {
    final docRef = await _collectionRef.add(event);
    return docRef.id;
  }

  // 更新
  Future<String> updateEvent(Program event) async {
    final docRef = _collectionRef.doc(event.id);
    await docRef.set(event, SetOptions(merge: true));
    return docRef.id;
  }

  // 削除
  Future<void> deleteEvent(String eventId) async {
    await _collectionRef.doc(eventId).update({'isActive': false});
  }
}

@riverpod
Stream<Program> programStream(
  ProgramStreamRef ref,
  String programId,
) {
  return ref.watch(programRepositoryProvider).watchEvent(programId);
}

@riverpod
Future<Program?> programFuture(
  ProgramFutureRef ref,
  String programId,
) {
  return ref.watch(programRepositoryProvider).readEvent(programId);
}
