import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../general_provider.dart';
import '../model/order_model.dart' as purchase;

part 'order_repository.g.dart';

final logger = Logger();

const _defaultPath = 'v/1';
const _collectionPath = '$_defaultPath/orders';

@Riverpod(keepAlive: true)
OrderRepository orderRepository(OrderRepositoryRef ref) {
  return OrderRepository(ref.watch(firebaseFirestoreProvider));
}

class OrderRepository {
  OrderRepository(this._db);
  final FirebaseFirestore _db;

  CollectionReference<purchase.Order> _collectionRef() {
    return _db.collection(_collectionPath).withConverter<purchase.Order>(
          fromFirestore: (snapshot, _) =>
              purchase.Order.fromJson(snapshot.data()!)
                  .copyWith(id: snapshot.id),
          toFirestore: (model, _) => {
            ...model.toJson()..remove('id'),
            if (model.createdAt == null)
              'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
          },
        );
  }

  // 取得
  Stream<List<purchase.Order>> watchOrder(String uid) {
    return _collectionRef()
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<List<purchase.Order>> readOrder(String uid) async {
    final querySnapshot = await _collectionRef()
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: false)
        .get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  // 登録
  Future<String> createOrder(String uid, purchase.Order order) async {
    final docRef = await _collectionRef().add(order);
    return docRef.id;
  }

  // 更新
  Future<String> updateOrder(String uid, purchase.Order order) async {
    final docRef = _collectionRef().doc(order.id);
    await docRef.set(order, SetOptions(merge: true));
    return docRef.id;
  }

  // 削除
  Future<void> deleteOrder(String uid, String orderId) async {
    await _collectionRef().doc(orderId).delete();
  }
}

// // Stream
// @riverpod
// Stream<List<purchase.Order>> orderStream(OrderStreamRef ref, String uid) {
//   return ref.watch(orderRepositoryProvider).watchOrder(uid);
// }
