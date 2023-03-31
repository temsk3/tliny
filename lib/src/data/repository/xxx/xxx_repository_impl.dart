import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../general_provider.dart';
import '../../model/xxx/xxx_model.dart';
import 'xxx_repository.dart';

const _collectionPath = 'xxx';

final xxxRepositoryProvider =
    Provider<XxxRepository>((ref) => XxxRepositoryImpl(ref));

// final xxxListStreamProvider = StreamProvider.autoDispose((ref) {
//   CollectionReference collectionRef =
//       FirebaseFirestore.instance.collection(_collectionPath);
//   final list = collectionRef.snapshots().map((snapshot) {
//     return snapshot.docs.map((doc) {
//       return Xxx.fromJson(doc.data() as Map<String, dynamic>)
//           .copyWith(id: doc.id);
//     }).toList();
//   });
//   return list;
// });

class XxxRepositoryImpl implements XxxRepository {
  XxxRepositoryImpl(this._ref);
  final Ref _ref;

  @override
  Stream<List<Xxx>> streamXxx() {
    final list = _ref
        .read(firebaseFirestoreProvider)
        .collection(_collectionPath)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Xxx.fromJson(doc.data()).copyWith(id: doc.id);
      }).toList();
    });
    return list;
  }

  @override
  Future<List<Xxx>> readXxx() async {
    // アイテムを取得
    final QuerySnapshot querySnapshot = await _ref
        .read(firebaseFirestoreProvider)
        .collection(_collectionPath)
        .get();
    final List<QueryDocumentSnapshot> queryDocSnapshot = querySnapshot.docs;
    return queryDocSnapshot.map((doc) {
      final Map<String, dynamic> map = doc.data()! as Map<String, dynamic>;
      return Xxx.fromJson(map).copyWith(id: doc.id);
    }).toList();
  }

  @override
  Future<String> createXxx({required Xxx xxx}) async {
    // 登録
    final docRef = await _ref
        .read(firebaseFirestoreProvider)
        .collection(_collectionPath)
        .add(xxx.toJson()..remove('id'));
    await docRef.set({
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    return docRef.id;
  }

  @override
  Future<void> updateXxx({required Xxx xxx}) async {
    // アイテムを更新
    _ref.read(firebaseFirestoreProvider).collection(_collectionPath).doc(xxx.id)
      ..update(xxx.toJson())
      ..set({
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
  }

  @override
  Future<void> deleteXxx({required xxxId}) async {
    // アイテムを削除
    await _ref
        .read(firebaseFirestoreProvider)
        .collection(_collectionPath)
        .doc(xxxId)
        .delete();
  }
}
