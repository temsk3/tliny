import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';
import '../model/order_model.dart' as purchase;

part 'order_repository.g.dart';

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

  // 注文情報の取得 (ユーザーID指定)
  Stream<List<purchase.Order>> watchOrder(String uid) {
    logger.d('watchOrder: uid=$uid');
    try {
      return _collectionRef()
          .where('userId', isEqualTo: uid)
          // .orderBy('createdAt', descending: false)
          .snapshots()
          .map((snapshot) {
        logger.d('watchOrder: snapshot=$snapshot');
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } on Exception catch (e, st) {
      logger.e('watchOrder: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // イベントの注文情報の取得 (イベントID指定)
  Stream<List<purchase.Order>> watchEventOrder(String eventId) {
    logger.d('watchEventOrder: eventId=$eventId');
    try {
      return _collectionRef()
          .where('eventId', isEqualTo: eventId)
          .snapshots()
          .map((snapshot) {
        logger.d('watchEventOrder: snapshot=$snapshot');
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } on Exception catch (e, st) {
      logger.e('watchEventOrder: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // 注文情報の取得 (ユーザーID指定)
  Future<List<purchase.Order>> readOrder(String uid) async {
    logger.d('readOrder: uid=$uid');
    try {
      final querySnapshot = await _collectionRef()
          .where('userId', isEqualTo: uid)
          // .orderBy('createdAt', descending: false)
          .get();
      logger.d('readOrder: querySnapshot=$querySnapshot');
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } on Exception catch (e, st) {
      logger.e('readOrder: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // 注文情報の登録
  Future<String> createOrder(String uid, purchase.Order order) async {
    logger.d('createOrder: uid=$uid, order=$order');
    try {
      final docRef = await _collectionRef().add(order);
      logger.d('createOrder: docRef=$docRef');
      return docRef.id;
    } on Exception catch (e, st) {
      logger.e('createOrder: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // 注文情報の更新
  Future<String> updateOrder(String uid, purchase.Order order) async {
    logger.d('updateOrder: uid=$uid, order=$order');
    try {
      final docRef = _collectionRef().doc(order.id);
      await docRef.set(order, SetOptions(merge: true));
      logger.d('updateOrder: success');
      return docRef.id;
    } on Exception catch (e, st) {
      logger.e('updateOrder: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  // 注文情報の削除
  Future<void> deleteOrder(String uid, String orderId) async {
    logger.d('deleteOrder: uid=$uid, orderId=$orderId');
    try {
      await _collectionRef().doc(orderId).delete();
      logger.d('deleteOrder: success');
    } on Exception catch (e, st) {
      logger.e('deleteOrder: error=$e, stackTrace=$st');
      rethrow;
    }
  }
}
