import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../general_provider.dart';
import '../model/cart_model.dart';

part 'cart_repository.g.dart';

final logger = Logger();

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

  // 取得
  Stream<List<Cart>> watchCart(String uid) {
    return _collectionRef(uid).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<List<Cart>> readCart(String uid) async {
    final querySnapshot = await _collectionRef(uid).get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  // 登録
  Future<Cart> createCart(String uid, Cart cart) async {
    final item = cart.copyWith(
      id: cart.productId,
      productDocRef: _db.collection(_productCollectionPath).doc(cart.productId),
    );
    await _collectionRef(uid).doc(cart.productId).set(item);

    return item;
  }

  // 更新
  Future<String> updateCart(String uid, Cart cart) async {
    final docRef = _collectionRef(uid).doc(cart.id);
    await docRef.set(cart, SetOptions(merge: true));
    return docRef.id;
  }

  // 削除
  Future<void> deleteCart(String uid, String cartId) async {
    await _collectionRef(uid).doc(cartId).delete();
  }
}

// Stream
@riverpod
Stream<List<Cart>> cartStream(CartStreamRef ref, String uid) {
  return ref.watch(cartRepositoryProvider).watchCart(uid);
}
