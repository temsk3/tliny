import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';
import '../model/product_model.dart';

part 'product_repository.g.dart';

const _defaultPath = 'v/1';
const _collectionPath = '$_defaultPath/products';

// ProductRepositoryProvider
@Riverpod(keepAlive: true)
ProductRepository productRepository(ProductRepositoryRef ref) {
  return ProductRepository(ref.watch(firebaseFirestoreProvider));
}

class ProductRepository {
  ProductRepository(this._db);
  final FirebaseFirestore _db;

  late final _collectionRef =
      _db.collection(_collectionPath).withConverter<Product>(
            fromFirestore: (snapshot, _) =>
                Product.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
            toFirestore: (model, _) => {
              ...model.toJson()..remove('id'),
              if (model.createdAt == null)
                'createdAt': FieldValue.serverTimestamp(),
              'updatedAt': FieldValue.serverTimestamp(),
              if (model.isActive == false)
                'deletedAt': FieldValue.serverTimestamp(),
            },
          );

  /// ジャンル指定で商品一覧を取得するストリーム
  Stream<List<Product>> streamProducts(GenreType? genre) {
    logger.d('streamProducts: genre=$genre');
    try {
      final Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;
      if (genre == null) {
        snapshot = _db.collection(_collectionPath).orderBy('name').snapshots();
      } else {
        snapshot = _db
            .collection(_collectionPath)
            .where('genre', isEqualTo: EnumToString.convertToString(genre))
            .orderBy('name')
            .snapshots();
      }
      return snapshot.map(
        (snapshot) {
          logger.d('streamProducts: snapshot=$snapshot');
          return snapshot.docs.map((doc) {
            logger.d('streamProducts: doc=$doc');
            return Product.fromJson(doc.data()).copyWith(id: doc.id);
          }).toList();
        },
      );
    } on Exception catch (e, st) {
      logger.e('streamProducts: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  /// プログラムIDとジャンル指定で商品一覧を取得するストリーム
  Stream<List<Product>> streamProgramProducts(
    ProductQueryParameter queryParameter,
  ) {
    logger.d('streamProgramProducts: queryParameter=$queryParameter');
    try {
      final Query<Map<String, dynamic>> query;
      if (queryParameter.genre == null) {
        query = _db
            .collection(_collectionPath)
            .where('eventId', isEqualTo: queryParameter.programId)
            .orderBy('name');
      } else {
        query = _db
            .collection(_collectionPath)
            .where('eventId', isEqualTo: queryParameter.programId)
            .where(
              'genre',
              isEqualTo: EnumToString.convertToString(queryParameter.genre),
            )
            .orderBy('name');
      }
      return query.snapshots().map(
        (snapshot) {
          logger.d('streamProgramProducts: snapshot=$snapshot');
          return snapshot.docs.map((doc) {
            logger.d('streamProgramProducts: doc=$doc');
            return Product.fromJson(doc.data()).copyWith(id: doc.id);
          }).toList();
        },
      );
    } on Exception catch (e, st) {
      logger.e('streamProgramProducts: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  /// プログラムID指定で商品一覧を取得する
  Future<List<Product>> programProducts(String programId) async {
    logger.d('programProducts: programId=$programId');
    try {
      final querySnapshot = await _collectionRef
          .where('eventId', isEqualTo: programId)
          .orderBy('name')
          .get();
      logger.d('programProducts: querySnapshot=$querySnapshot');
      final queryDocSnapshot = querySnapshot.docs;
      return queryDocSnapshot.map((doc) => doc.data()).toList();
    } on Exception catch (e, st) {
      logger.e('programProducts: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  /// 商品一覧を取得するストリーム
  Stream<List<Product>> watchProducts() {
    logger.d('watchProducts');
    try {
      return _collectionRef.orderBy('name').snapshots().map((snapshot) {
        logger.d('watchProducts: snapshot=$snapshot');
        return snapshot.docs.map((doc) {
          logger.d('watchProducts: doc=$doc');
          return doc.data();
        }).toList();
      });
    } on Exception catch (e, st) {
      logger.e('watchProducts: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  /// 商品詳細を取得するストリーム
  Stream<Product> watchProduct(String? productId) {
    logger.d('watchProduct: productId=$productId');
    try {
      if (productId == null) {
        logger.d('watchProduct: productId is null');
        return Stream.value(Product.empty());
      }
      return _collectionRef.doc(productId).snapshots().map((doc) {
        logger.d('watchProduct: doc=$doc');
        if (doc.exists) {
          logger.d('watchProduct: doc.exists');
          return doc.data()!;
        }
        logger.d('watchProduct: doc.exists is false');
        return Product.empty();
      });
    } on Exception catch (e, st) {
      logger.e('watchProduct: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  /// 商品一覧を取得する
  Future<List<Product>> readProducts() async {
    logger.d('readProducts');
    try {
      final querySnapshot = await _collectionRef.get();
      logger.d('readProducts: querySnapshot=$querySnapshot');
      final queryDocSnapshot = querySnapshot.docs;
      return queryDocSnapshot.map((doc) => doc.data()).toList();
    } on Exception catch (e, st) {
      logger.e('readProducts: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  /// 商品を登録する
  Future<String> createProduct(Product product) async {
    logger.d('createProduct: product=$product');
    try {
      final docRef = await _collectionRef.add(product);
      logger.d('createProduct: docRef=$docRef');
      return docRef.id;
    } on Exception catch (e, st) {
      logger.e('createProduct: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  /// 商品を更新する
  Future<String> updateProduct(Product product) async {
    logger.d('updateProduct: product=$product');
    try {
      final docRef = _collectionRef.doc(product.id);
      await docRef.set(product, SetOptions(merge: true));
      logger.d('updateProduct: success');
      return docRef.id;
    } on Exception catch (e, st) {
      logger.e('updateProduct: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  /// 商品を削除する
  Future<void> deleteProduct(String productId) async {
    logger.d('deleteProduct: productId=$productId');
    try {
      // await _collectionRef.doc(productId).delete();
      await _collectionRef.doc(productId).update({'isActive': false});
      logger.d('deleteProduct: success');
    } on Exception catch (e, st) {
      logger.e('deleteProduct: error=$e, stackTrace=$st');
      rethrow;
    }
  }

  /// 商品を取得する
  Future<Product> getProduct(String docRef) async {
    logger.d('getProduct: docRef=$docRef');
    try {
      final snapshot = await _db.doc(docRef).get().then((snap) {
        if (snap.exists) {
          logger.d('getProduct: snap.exists');
          return snap.data();
        } else {
          logger.e('getProduct: snap.exists is false');
          throw Error();
        }
      });
      logger.d('getProduct: snapshot=$snapshot');
      return Product.fromJson(snapshot!);
    } on Exception catch (e, st) {
      logger.e('getProduct: error=$e, stackTrace=$st');
      rethrow;
    }
  }
}

// Stream
@riverpod
Stream<List<Product>> productsStream(ProductsStreamRef ref) {
  logger.d('productsStream');
  try {
    return ref.watch(productRepositoryProvider).watchProducts();
  } on Exception catch (e, st) {
    logger.e('productsStream: error=$e, stackTrace=$st');
    rethrow;
  }
}

@riverpod
Stream<Product> productDocStream(
  ProductDocStreamRef ref,
  DocumentReference<Map<String, dynamic>> productDocRef,
) {
  logger.d('productDocStream: productDocRef=$productDocRef');
  try {
    final documentSnapshot = productDocRef.snapshots();
    return documentSnapshot.map((doc) {
      logger.d('productDocStream: doc=$doc');
      if (!doc.exists) {
        logger.e('productDocStream: doc.exists is false');
        throw Error();
      }
      final data = Product.fromJson(doc.data()!).copyWith(id: doc.id);
      logger.d('productDocStream: data=$data');
      return data;
    });
  } on Exception catch (e, st) {
    logger.e('productDocStream: error=$e, stackTrace=$st');
    rethrow;
  }
}

@riverpod
Stream<Product> productStream(
  ProductStreamRef ref,
  String productId,
) {
  logger.d('productStream: productId=$productId');
  try {
    return ref.watch(productRepositoryProvider).watchProduct(productId);
  } on Exception catch (e, st) {
    logger.e('productStream: error=$e, stackTrace=$st');
    rethrow;
  }
}
