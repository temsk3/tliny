import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';
import '../model/cart_model.dart';
import '../model/exception/app_exception.dart';

part 'cart_repository.g.dart';

const _defaultPath = 'v/1';
const _collectionPath = '$_defaultPath/users';
const _subCollectionPath = 'cart';

// CartRepositoryProvider
@Riverpod(keepAlive: true)
CartRepository cartRepository(Ref ref) {
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
          fromFirestore:
              (snapshot, _) =>
                  Cart.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
          toFirestore:
              (model, _) => {
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
    } on Exception catch (e, st) {
      throw GeneralException(message: e.toString(), stackTrace: st);
    } catch (e, st) {
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  // カートのデータを一度に取得する
  Future<List<Cart>> readCart(String uid) async {
    logger.i('readCart: カートのデータを一度に取得します uid=$uid');
    try {
      logger.d('readCart: _collectionRef(uid)を呼び出し', time: DateTime.now());
      final collectionRef = _collectionRef(uid);
      logger.d('readCart: collectionRef.get()を呼び出し', time: DateTime.now());
      final querySnapshot = await collectionRef.get();
      logger.d(
        'readCart: querySnapshot取得完了, docs.length=${querySnapshot.docs.length}',
        time: DateTime.now(),
      );
      final result = querySnapshot.docs.map((doc) => doc.data()).toList();
      logger.i('readCart: カートのデータを一度に取得しました result=$result');
      return result;
    } on Exception catch (e, st) {
      logger.e('readCart: Exception - $e', stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
    } catch (e, st) {
      logger.e('readCart: catch - $e', stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  // カートに商品を追加する
  Future<Cart> createCart(String uid, Cart cart) async {
    logger.i('createCart: カートに商品を追加します');
    try {
      final item = cart.copyWith(
        id: cart.productId,
        productDocRef: 'v/1/products/${cart.productId}',
      );
      await _collectionRef(uid).doc(cart.productId).set(item);
      logger.i('createCart: カートに商品を追加しました');
      return item;
    } on Exception catch (e, st) {
      throw GeneralException(message: e.toString(), stackTrace: st);
    } catch (e, st) {
      throw GeneralException(message: e.toString(), stackTrace: st);
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
    } on Exception catch (e, st) {
      throw GeneralException(message: e.toString(), stackTrace: st);
    } catch (e, st) {
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  // カートの商品を削除する
  Future<void> deleteCart(String uid, String cartId) async {
    logger.i('deleteCart: カートの商品を削除します');
    try {
      await _collectionRef(uid).doc(cartId).delete();
      logger.i('deleteCart: カートの商品を削除しました');
    } on Exception catch (e, st) {
      throw GeneralException(message: e.toString(), stackTrace: st);
    } catch (e, st) {
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }
}

// カートのデータを取得するストリーム
@riverpod
Stream<List<Cart>> cartStream(Ref ref, String uid) {
  logger.i('cartStream: カートのデータを取得するストリームを開始します');
  try {
    return ref.watch(cartRepositoryProvider).watchCart(uid);
  } on Exception catch (e, st) {
    throw GeneralException(message: e.toString(), stackTrace: st);
  } catch (e, st) {
    throw GeneralException(message: e.toString(), stackTrace: st);
  }
}
