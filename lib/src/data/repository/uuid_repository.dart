import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';

part 'uuid_repository.g.dart';

@Riverpod(keepAlive: true)
UuidRepository uuidRepository(UuidRepositoryRef ref) {
  return UuidRepository(ref.watch(firebaseFirestoreProvider));
}

class UuidRepository {
  UuidRepository(this._db);
  final FirebaseFirestore _db;

  Future<String> get createUuid async {
    try {
      const uuid = Uuid();
      var newId = uuid.v4();
      final snapShot =
          await _db.collection('/v/1/platform/spel1/storage_id').get();
      final idList = snapShot.docs.map((e) => e.id).toList();
      while (idList.any((id) => id == newId)) {
        newId = uuid.v4();
      }
      _db.collection('/v/1/platform/spel1/storage_id').doc(newId);
      return newId;
    } on Exception catch (e) {
      logger.d(e);
      return 'uuid Error';
    }
  }
}
