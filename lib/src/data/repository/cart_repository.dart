import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';
import '../model/cart_model.dart';

part 'cart_repository.g.dart';

const _defaultPath = 'v/1';
const _collectionPath = '$_defaultPath/users';
const _subCollectionPath = 'cart';
const _productCollectionPath = '$_defaultPath/products';

// CartRepositoryProvider
@Riverpod(keepAlive: true)
CartRepository cartRepository(CartRepositoryRef ref) {
  return CartRepository(ref.watch(firebaseFirestoreProvider));
}

class CartRepository {
  CartRepository(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Cart> _collectionRef(String uid) {
    return _db
        .collection(_collectionPath)
        .doc(uid)
        .collection(_subCollectionPath)
        .withConverter<Cart>(
          fromFirestore: (snapshot, _) =>
              Cart.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
          toFirestore: (model, _) => {
            ...model.toJson()..remove('id'),
            if (model.createdAt == null)
              'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
          },
        );
  }

  // カートのデータを取得するストリーム
  Stream<List<Cart>> watchCart(String uid) {
    logger.i('watchCart: カートのデータを取得するストリームを開始します');
    try {
      return _collectionRef(uid).snapshots().map((snapshot) {
        logger.i('watchCart: カートのデータを取得しました');
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } on FirebaseException catch (e) {
      logger.e('watchCart: カートのデータ取得に失敗しました', error: e);
      throw e;
    }
  }

  // カートのデータを一度に取得する
  Future<List<Cart>> readCart(String uid) async {
    logger.i('readCart: カートのデータを一度に取得します');
    try {
      final querySnapshot = await _collectionRef(uid).get();
      logger.i('readCart: カートのデータを一度に取得しました');
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } on FirebaseException catch (e) {
      logger.e('readCart: カートのデータ取得に失敗しました', error: e);
      throw e;
    }
  }

  // カートに商品を追加する
  Future<Cart> createCart(String uid, Cart cart) async {
    logger.i('createCart: カートに商品を追加します');
    try {
      final item = cart.copyWith(
        id: cart.productId,
        productDocRef:
            _db.collection(_productCollectionPath).doc(cart.productId),
      );
      await _collectionRef(uid).doc(cart.productId).set(item);
      logger.i('createCart: カートに商品を追加しました');
      return item;
    } on FirebaseException catch (e) {
      logger.e('createCart: カートへの商品追加に失敗しました', error: e);
      throw e;
    }
  }

  // カートの商品を更新する
  Future<String> updateCart(String uid, Cart cart) async {
    logger.i('updateCart: カートの商品を更新します');
    try {
      final docRef = _collectionRef(uid).doc(cart.id);
      await docRef.set(cart, SetOptions(merge: true));
      logger.i('updateCart: カートの商品を更新しました');
      return docRef.id;
    } on FirebaseException catch (e) {
      logger.e('updateCart: カートの商品更新に失敗しました', error: e);
      throw e;
    }
  }

  // カートの商品を削除する
  Future<void> deleteCart(String uid, String cartId) async {
    logger.i('deleteCart: カートの商品を削除します');
    try {
      await _collectionRef(uid).doc(cartId).delete();
      logger.i('deleteCart: カートの商品を削除しました');
    } on FirebaseException catch (e) {
      logger.e('deleteCart: カートの商品削除に失敗しました', error: e);
      throw e;
    }
  }
}

// カートのデータを取得するストリーム
@riverpod
Stream<List<Cart>> cartStream(CartStreamRef ref, String uid) {
  logger.i('cartStream: カートのデータを取得するストリームを開始します');
  try {
    return ref.watch(cartRepositoryProvider).watchCart(uid);
  } on FirebaseException catch (e) {
    logger.e('cartStream: カートのデータ取得に失敗しました', error: e);
    throw e;
  }
}
