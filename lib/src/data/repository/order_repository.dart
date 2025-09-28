import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';
import '../model/exception/app_exception.dart';
import '../model/order_model.dart' as purchase;

part 'order_repository.g.dart';

const _defaultPath = 'v/1';
const _collectionPath = '$_defaultPath/orders';

@Riverpod(keepAlive: true)
OrderRepository orderRepository(Ref ref) {
  return OrderRepository(ref.watch(firebaseFirestoreProvider));
}

class OrderRepository {
  OrderRepository(this._db);
  final FirebaseFirestore _db;

  CollectionReference<purchase.Order> _collectionRef() {
    return _db
        .collection(_collectionPath)
        .withConverter<purchase.Order>(
          fromFirestore:
              (snapshot, _) => purchase.Order.fromJson(
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

  /// 注文情報の取得 (ユーザーID指定)
  Stream<List<purchase.Order>> watchOrder(String uid) {
    logger.i('watchOrder: 注文情報を取得するストリームを開始します uid=$uid');
    try {
      return _collectionRef()
          .where('userId', isEqualTo: uid)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
            logger.i('watchOrder: 注文情報を取得しました count=${snapshot.docs.length}');
            return snapshot.docs.map((doc) => doc.data()).toList();
          });
    } on Exception catch (e, st) {
      logger.e('watchOrder: 注文情報取得エラー', error: e, stackTrace: st);
      throw GeneralException(message: '注文情報の取得に失敗しました', stackTrace: st);
    }
  }

  /// イベントの注文情報の取得 (イベントID指定)
  Stream<List<purchase.Order>> watchEventOrder(String eventId) {
    logger.i('watchEventOrder: イベント注文情報を取得するストリームを開始します eventId=$eventId');
    try {
      return _collectionRef()
          .where('eventId', isEqualTo: eventId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
            logger.i(
              'watchEventOrder: イベント注文情報を取得しました count=${snapshot.docs.length}',
            );
            return snapshot.docs.map((doc) => doc.data()).toList();
          });
    } on Exception catch (e, st) {
      logger.e('watchEventOrder: イベント注文情報取得エラー', error: e, stackTrace: st);
      throw GeneralException(message: 'イベント注文情報の取得に失敗しました', stackTrace: st);
    }
  }

  /// 注文情報の取得 (ユーザーID指定)
  Future<List<purchase.Order>> readOrder(String uid) async {
    logger.i('readOrder: 注文情報を取得します uid=$uid');
    try {
      // クエリを構築
      final query = _collectionRef()
          .where('userId', isEqualTo: uid)
          .orderBy('createdAt', descending: true);

      logger.d('readOrder: クエリを実行します');
      final querySnapshot = await query.get();

      logger.i('readOrder: 注文情報を取得しました count=${querySnapshot.docs.length}');

      // ドキュメントをOrderオブジェクトに変換
      final orders = <purchase.Order>[];
      for (final doc in querySnapshot.docs) {
        try {
          final order = doc.data();
          logger.d('readOrder: ドキュメントデータ: ${doc.id} = $order');
          orders.add(order);
        } catch (e, st) {
          logger.e(
            'readOrder: ドキュメント変換エラー docId=${doc.id}',
            error: e,
            stackTrace: st,
          );
          // 個別のドキュメント変換エラーはスキップして続行
          continue;
        }
      }

      logger.i('readOrder: 変換完了 count=${orders.length}');
      return orders;
    } on FirebaseException catch (e, st) {
      logger.e(
        'readOrder: FirebaseException - ${e.code}: ${e.message}',
        error: e,
        stackTrace: st,
      );
      if (e.code == 'failed-precondition') {
        throw GeneralException(
          message: 'インデックスが作成されていません。しばらく待ってから再試行してください。',
          stackTrace: st,
        );
      }
      throw GeneralException(
        message: 'Firebaseエラー: ${e.message}',
        stackTrace: st,
      );
    } on Exception catch (e, st) {
      logger.e('readOrder: 注文情報取得エラー', error: e, stackTrace: st);
      throw GeneralException(message: '注文情報の取得に失敗しました', stackTrace: st);
    }
  }

  /// 注文情報の登録
  Future<String> createOrder(String uid, purchase.Order order) async {
    logger.i('createOrder: 注文情報を登録します uid=$uid, orderId=${order.id}');
    try {
      final docRef = await _collectionRef().add(order);
      logger.i('createOrder: 注文情報を登録しました docId=${docRef.id}');
      return docRef.id;
    } on Exception catch (e, st) {
      logger.e('createOrder: 注文情報登録エラー', error: e, stackTrace: st);
      throw GeneralException(message: '注文情報の登録に失敗しました', stackTrace: st);
    }
  }

  /// 注文情報の更新
  Future<String> updateOrder(String uid, purchase.Order order) async {
    logger.i('updateOrder: 注文情報を更新します uid=$uid, orderId=${order.id}');
    try {
      final docRef = _collectionRef().doc(order.id);
      await docRef.set(order, SetOptions(merge: true));
      logger.i('updateOrder: 注文情報を更新しました');
      return docRef.id;
    } on Exception catch (e, st) {
      logger.e('updateOrder: 注文情報更新エラー', error: e, stackTrace: st);
      throw GeneralException(message: '注文情報の更新に失敗しました', stackTrace: st);
    }
  }

  /// 注文情報の削除
  Future<void> deleteOrder(String uid, String orderId) async {
    logger.i('deleteOrder: 注文情報を削除します uid=$uid, orderId=$orderId');
    try {
      await _collectionRef().doc(orderId).delete();
      logger.i('deleteOrder: 注文情報を削除しました');
    } on Exception catch (e, st) {
      logger.e('deleteOrder: 注文情報削除エラー', error: e, stackTrace: st);
      throw GeneralException(message: '注文情報の削除に失敗しました', stackTrace: st);
    }
  }

  /// 複数の注文情報を一括登録する（バッチ処理）
  Future<List<String>> createOrdersBatch(List<purchase.Order> orders) async {
    logger.i('createOrdersBatch: 複数の注文情報を一括登録します count=${orders.length}');
    try {
      final batch = _db.batch();
      final docRefs = <DocumentReference>[];

      for (final order in orders) {
        final docRef = _collectionRef().doc();
        batch.set(docRef, order);
        docRefs.add(docRef);
      }

      await batch.commit();
      logger.i('createOrdersBatch: 複数の注文情報を一括登録しました');
      return docRefs.map((ref) => ref.id).toList();
    } on Exception catch (e, st) {
      logger.e('createOrdersBatch: 一括登録エラー', error: e, stackTrace: st);
      throw GeneralException(message: '注文情報の一括登録に失敗しました', stackTrace: st);
    }
  }

  /// 複数の注文情報を一括更新する（バッチ処理）
  Future<void> updateOrdersBatch(List<purchase.Order> orders) async {
    logger.i('updateOrdersBatch: 複数の注文情報を一括更新します count=${orders.length}');
    try {
      final batch = _db.batch();

      for (final order in orders) {
        final docRef = _collectionRef().doc(order.id);
        batch.set(docRef, order, SetOptions(merge: true));
      }

      await batch.commit();
      logger.i('updateOrdersBatch: 複数の注文情報を一括更新しました');
    } on Exception catch (e, st) {
      logger.e('updateOrdersBatch: 一括更新エラー', error: e, stackTrace: st);
      throw GeneralException(message: '注文情報の一括更新に失敗しました', stackTrace: st);
    }
  }

  /// 複数の注文情報を一括削除する（バッチ処理）
  Future<void> deleteOrdersBatch(List<String> orderIds) async {
    logger.i('deleteOrdersBatch: 複数の注文情報を一括削除します count=${orderIds.length}');
    try {
      final batch = _db.batch();

      for (final orderId in orderIds) {
        final docRef = _collectionRef().doc(orderId);
        batch.delete(docRef);
      }

      await batch.commit();
      logger.i('deleteOrdersBatch: 複数の注文情報を一括削除しました');
    } on Exception catch (e, st) {
      logger.e('deleteOrdersBatch: 一括削除エラー', error: e, stackTrace: st);
      throw GeneralException(message: '注文情報の一括削除に失敗しました', stackTrace: st);
    }
  }

  /// 注文情報を検索する（パフォーマンス最適化版）
  Future<List<purchase.Order>> searchOrders({
    String? userId,
    String? eventId,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  }) async {
    logger.i(
      'searchOrders: 注文情報を検索します userId=$userId, eventId=$eventId, status=$status, limit=$limit',
    );
    try {
      Query<Map<String, dynamic>> query = _db.collection(_collectionPath);

      // フィルター条件を適用
      if (userId != null) {
        query = query.where('userId', isEqualTo: userId);
      }
      if (eventId != null) {
        query = query.where('eventId', isEqualTo: eventId);
      }
      if (status != null) {
        query = query.where('status', isEqualTo: status);
      }
      if (startDate != null) {
        query = query.where('createdAt', isGreaterThanOrEqualTo: startDate);
      }
      if (endDate != null) {
        query = query.where('createdAt', isLessThanOrEqualTo: endDate);
      }

      // ソート
      query = query.orderBy('createdAt', descending: true);

      // リミット
      if (limit != null) {
        query = query.limit(limit);
      }

      final querySnapshot = await query.get();
      final orders =
          querySnapshot.docs.map((doc) {
            return purchase.Order.fromJson(doc.data()).copyWith(id: doc.id);
          }).toList();

      logger.i('searchOrders: 注文情報検索完了 count=${orders.length}');
      return orders;
    } on Exception catch (e, st) {
      logger.e('searchOrders: 注文情報検索エラー', error: e, stackTrace: st);
      throw GeneralException(message: '注文情報の検索に失敗しました', stackTrace: st);
    }
  }
}
