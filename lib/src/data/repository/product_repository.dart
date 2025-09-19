import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';
import '../model/exception/app_exception.dart';
import '../model/product_model.dart';

part 'product_repository.g.dart';

const _defaultPath = 'v/1';
const _collectionPath = '$_defaultPath/products';

// ProductRepositoryProvider
@Riverpod(keepAlive: true)
ProductRepository productRepository(Ref ref) {
  return ProductRepository(ref.watch(firebaseFirestoreProvider));
}

class ProductRepository {
  ProductRepository(this._db);
  final FirebaseFirestore _db;

  late final CollectionReference<Product> _collectionRef = _db
      .collection(_collectionPath)
      .withConverter<Product>(
        fromFirestore: (snapshot, _) {
          final data = snapshot.data();
          if (data == null) {
            throw Exception(
              'Document data is null for document ${snapshot.id}',
            );
          }
          return Product.fromJson(data).copyWith(id: snapshot.id);
        },
        toFirestore:
            (model, _) => {
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
    logger.i('streamProducts: ジャンル指定で商品一覧を取得するストリームを開始します genre=$genre');
    try {
      final Stream<QuerySnapshot<Product>> snapshot;
      if (genre == null) {
        snapshot = _collectionRef.orderBy('name').snapshots();
      } else {
        snapshot =
            _collectionRef
                .where('genre', isEqualTo: EnumToString.convertToString(genre))
                .orderBy('name')
                .snapshots();
      }
      return snapshot.map((snapshot) {
        logger.i('streamProducts: 商品一覧を取得しました count=${snapshot.docs.length}');
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } on Exception catch (e, st) {
      logger.e('streamProducts: 商品一覧取得エラー', error: e, stackTrace: st);
      throw GeneralException(message: '商品一覧の取得に失敗しました', stackTrace: st);
    }
  }

  /// プログラムIDとジャンル指定で商品一覧を取得するストリーム
  Stream<List<Product>> streamProgramProducts(
    ProductQueryParameter queryParameter,
  ) {
    logger.i(
      'streamProgramProducts: プログラム商品一覧を取得するストリームを開始します queryParameter=$queryParameter',
    );
    try {
      final Query<Product> query;
      if (queryParameter.genre == null) {
        query = _collectionRef
            .where('eventId', isEqualTo: queryParameter.programId)
            .orderBy('name');
      } else {
        query = _collectionRef
            .where('eventId', isEqualTo: queryParameter.programId)
            .where(
              'genre',
              isEqualTo: EnumToString.convertToString(queryParameter.genre),
            )
            .orderBy('name');
      }
      return query.snapshots().map((snapshot) {
        logger.i(
          'streamProgramProducts: プログラム商品一覧を取得しました count=${snapshot.docs.length}',
        );
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } on Exception catch (e, st) {
      logger.e(
        'streamProgramProducts: プログラム商品一覧取得エラー',
        error: e,
        stackTrace: st,
      );
      throw GeneralException(message: 'プログラム商品一覧の取得に失敗しました', stackTrace: st);
    }
  }

  /// プログラムID指定で商品一覧を取得する
  Future<List<Product>> programProducts(String programId) async {
    logger.i('programProducts: プログラム商品一覧を取得します programId=$programId');
    try {
      final querySnapshot =
          await _collectionRef
              .where('eventId', isEqualTo: programId)
              .orderBy('name')
              .get();
      logger.i(
        'programProducts: プログラム商品一覧を取得しました count=${querySnapshot.docs.length}',
      );
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } on Exception catch (e, st) {
      logger.e('programProducts: プログラム商品一覧取得エラー', error: e, stackTrace: st);
      throw GeneralException(message: 'プログラム商品一覧の取得に失敗しました', stackTrace: st);
    }
  }

  /// 商品一覧を取得するストリーム
  Stream<List<Product>> watchProducts() {
    logger.i('watchProducts: 商品一覧を取得するストリームを開始します');
    try {
      return _collectionRef.orderBy('name').snapshots().map((snapshot) {
        logger.i('watchProducts: 商品一覧を取得しました count=${snapshot.docs.length}');
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } on Exception catch (e, st) {
      logger.e('watchProducts: 商品一覧取得エラー', error: e, stackTrace: st);
      throw GeneralException(message: '商品一覧の取得に失敗しました', stackTrace: st);
    }
  }

  /// 商品詳細を取得するストリーム
  Stream<Product> watchProduct(String? productId) {
    logger.i('watchProduct: 商品詳細を取得するストリームを開始します productId=$productId');
    try {
      if (productId == null) {
        logger.i('watchProduct: productId is null');
        return Stream.value(Product.empty());
      }
      return _collectionRef.doc(productId).snapshots().map((doc) {
        if (doc.exists) {
          final data = doc.data();
          if (data == null) {
            throw GeneralException(
              message: '商品データが存在しません',
              stackTrace: StackTrace.current,
            );
          }
          logger.i('watchProduct: 商品詳細を取得しました');
          logger.d('watchProduct: product.id=${data.id}');
          return data;
        }
        logger.i('watchProduct: 商品が存在しません');
        return Product.empty();
      });
    } on Exception catch (e, st) {
      logger.e('watchProduct: 商品詳細取得エラー', error: e, stackTrace: st);
      throw GeneralException(message: '商品詳細の取得に失敗しました', stackTrace: st);
    }
  }

  /// 商品一覧を取得する
  Future<List<Product>> readProducts() async {
    logger.i('readProducts: 商品一覧を取得します');
    try {
      final querySnapshot = await _collectionRef.get();
      logger.i('readProducts: 商品一覧を取得しました count=${querySnapshot.docs.length}');
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } on Exception catch (e, st) {
      logger.e('readProducts: 商品一覧取得エラー', error: e, stackTrace: st);
      throw GeneralException(message: '商品一覧の取得に失敗しました', stackTrace: st);
    }
  }

  /// 商品を登録する
  Future<String> createProduct(Product product) async {
    logger.i('createProduct: 商品を登録します product=${product.name}');
    try {
      final docRef = await _collectionRef.add(product);
      logger.i('createProduct: 商品を登録しました docId=${docRef.id}');
      return docRef.id;
    } on Exception catch (e, st) {
      logger.e('createProduct: 商品登録エラー', error: e, stackTrace: st);
      throw GeneralException(message: '商品の登録に失敗しました', stackTrace: st);
    }
  }

  /// 商品を更新する
  Future<String> updateProduct(Product product) async {
    logger.i('updateProduct: 商品を更新します productId=${product.id}');
    try {
      final docRef = _collectionRef.doc(product.id);
      await docRef.set(product, SetOptions(merge: true));
      logger.i('updateProduct: 商品を更新しました');
      return docRef.id;
    } on Exception catch (e, st) {
      logger.e('updateProduct: 商品更新エラー', error: e, stackTrace: st);
      throw GeneralException(message: '商品の更新に失敗しました', stackTrace: st);
    }
  }

  /// 商品を削除する
  Future<void> deleteProduct(String productId) async {
    logger.i('deleteProduct: 商品を削除します productId=$productId');
    try {
      await _collectionRef.doc(productId).update({'isActive': false});
      logger.i('deleteProduct: 商品を削除しました');
    } on Exception catch (e, st) {
      logger.e('deleteProduct: 商品削除エラー', error: e, stackTrace: st);
      throw GeneralException(message: '商品の削除に失敗しました', stackTrace: st);
    }
  }

  /// 商品を取得する
  Future<Product> getProduct(String docRef) async {
    logger.i('getProduct: 商品を取得します docRef=$docRef');
    try {
      final snapshot = await _collectionRef.doc(docRef).get();
      if (snapshot.exists) {
        final data = snapshot.data();
        if (data == null) {
          logger.e('getProduct: データがnullです docRef=$docRef');
          throw GeneralException(
            message: '商品データが不正です',
            stackTrace: StackTrace.current,
          );
        }
        logger.i('getProduct: 商品を取得しました');
        return data;
      } else {
        throw GeneralException(
          message: '商品が存在しません',
          stackTrace: StackTrace.current,
        );
      }
    } on Exception catch (e, st) {
      logger.e('getProduct: 商品取得エラー', error: e, stackTrace: st);
      throw GeneralException(message: '商品の取得に失敗しました', stackTrace: st);
    }
  }

  /// 複数の商品を一括登録する（バッチ処理）
  Future<List<String>> createProductsBatch(List<Product> products) async {
    logger.i('createProductsBatch: 複数の商品を一括登録します count=${products.length}');
    try {
      final batch = _db.batch();
      final docRefs = <DocumentReference>[];

      for (final product in products) {
        final docRef = _collectionRef.doc();
        batch.set(docRef, product);
        docRefs.add(docRef);
      }

      await batch.commit();
      logger.i('createProductsBatch: 複数の商品を一括登録しました');
      return docRefs.map((ref) => ref.id).toList();
    } on Exception catch (e, st) {
      logger.e('createProductsBatch: 一括登録エラー', error: e, stackTrace: st);
      throw GeneralException(message: '商品の一括登録に失敗しました', stackTrace: st);
    }
  }

  /// 複数の商品を一括更新する（バッチ処理）
  Future<void> updateProductsBatch(List<Product> products) async {
    logger.i('updateProductsBatch: 複数の商品を一括更新します count=${products.length}');
    try {
      final batch = _db.batch();

      for (final product in products) {
        final docRef = _collectionRef.doc(product.id);
        batch.set(docRef, product, SetOptions(merge: true));
      }

      await batch.commit();
      logger.i('updateProductsBatch: 複数の商品を一括更新しました');
    } on Exception catch (e, st) {
      logger.e('updateProductsBatch: 一括更新エラー', error: e, stackTrace: st);
      throw GeneralException(message: '商品の一括更新に失敗しました', stackTrace: st);
    }
  }

  /// 複数の商品を一括削除する（バッチ処理）
  Future<void> deleteProductsBatch(List<String> productIds) async {
    logger.i('deleteProductsBatch: 複数の商品を一括削除します count=${productIds.length}');
    try {
      final batch = _db.batch();

      for (final productId in productIds) {
        final docRef = _collectionRef.doc(productId);
        batch.update(docRef, {'isActive': false});
      }

      await batch.commit();
      logger.i('deleteProductsBatch: 複数の商品を一括削除しました');
    } on Exception catch (e, st) {
      logger.e('deleteProductsBatch: 一括削除エラー', error: e, stackTrace: st);
      throw GeneralException(message: '商品の一括削除に失敗しました', stackTrace: st);
    }
  }

  /// 商品を検索する（パフォーマンス最適化版）
  Future<List<Product>> searchProducts({
    String? keyword,
    GenreType? genre,
    String? programId,
    int? limit,
  }) async {
    logger.i(
      'searchProducts: 商品を検索します keyword=$keyword, genre=$genre, programId=$programId, limit=$limit',
    );
    try {
      Query<Product> query = _collectionRef;

      // フィルター条件を適用
      if (genre != null) {
        query = query.where(
          'genre',
          isEqualTo: EnumToString.convertToString(genre),
        );
      }
      if (programId != null) {
        query = query.where('eventId', isEqualTo: programId);
      }

      // ソート
      query = query.orderBy('name');

      // リミット
      if (limit != null) {
        query = query.limit(limit);
      }

      final querySnapshot = await query.get();
      final products = querySnapshot.docs.map((doc) => doc.data()).toList();

      // キーワード検索（クライアントサイド）
      if (keyword != null && keyword.isNotEmpty) {
        final lowerKeyword = keyword.toLowerCase();
        products.removeWhere(
          (product) =>
              !(product.name?.toLowerCase().contains(lowerKeyword) ?? false) &&
              !(product.desc?.toLowerCase().contains(lowerKeyword) ?? false),
        );
      }

      logger.i('searchProducts: 商品検索完了 count=${products.length}');
      return products;
    } on Exception catch (e, st) {
      logger.e('searchProducts: 商品検索エラー', error: e, stackTrace: st);
      throw GeneralException(message: '商品の検索に失敗しました', stackTrace: st);
    }
  }

  /// 商品ドキュメントストリームを取得するメソッド
  Stream<Product> watchProductDoc(DocumentReference<Product> productDocRef) {
    logger.i(
      'watchProductDoc: 商品ドキュメントストリームを開始します productDocRef=$productDocRef',
    );
    try {
      return productDocRef.snapshots().map((doc) {
        if (!doc.exists) {
          throw GeneralException(
            message: '商品が存在しません',
            stackTrace: StackTrace.current,
          );
        }
        final data = doc.data();
        if (data == null) {
          throw GeneralException(
            message: '商品データが存在しません',
            stackTrace: StackTrace.current,
          );
        }
        logger.i('watchProductDoc: 商品ドキュメントを取得しました');
        logger.d('watchProductDoc: product.id=${data.id}');
        return data;
      });
    } on Exception catch (e, st) {
      logger.e('watchProductDoc: 商品ドキュメントストリームエラー', error: e, stackTrace: st);
      throw GeneralException(message: '商品ドキュメントの取得に失敗しました', stackTrace: st);
    }
  }

  /// 文字列から`DocumentReference<Product>`を作成するメソッド
  DocumentReference<Product> getProductDocRef(String productId) {
    return _collectionRef.doc(productId);
  }

  /// 完全なパスから`DocumentReference<Product>`を作成するメソッド
  DocumentReference<Product> getProductDocRefFromPath(String path) {
    return _db
        .doc(path)
        .withConverter<Product>(
          fromFirestore: (snapshot, _) {
            final data = snapshot.data();
            if (data == null) {
              throw Exception(
                'Document data is null for document ${snapshot.id}',
              );
            }
            return Product.fromJson(data).copyWith(id: snapshot.id);
          },
          toFirestore:
              (model, _) => {
                ...model.toJson()..remove('id'),
                if (model.createdAt == null)
                  'createdAt': FieldValue.serverTimestamp(),
                'updatedAt': FieldValue.serverTimestamp(),
                if (model.isActive == false)
                  'deletedAt': FieldValue.serverTimestamp(),
              },
        );
  }

  /// 一度だけ商品データを取得するメソッド
  Future<Product?> getProductOnce(String productId) async {
    logger.i('getProductOnce: 商品データを一度だけ取得します productId=$productId');
    try {
      final docSnapshot = await _collectionRef.doc(productId).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data == null) {
          logger.w('getProductOnce: 商品データがnullです productId=$productId');
          return null;
        }
        logger.i('getProductOnce: 商品データを取得しました productId=$productId');
        return data;
      } else {
        logger.w('getProductOnce: 商品が存在しません productId=$productId');
        return null;
      }
    } on Exception catch (e, st) {
      logger.e(
        'getProductOnce: 商品データ取得エラー productId=$productId, error=$e',
        stackTrace: st,
      );
      return null;
    }
  }
}

// Stream
@riverpod
Stream<List<Product>> productsStream(Ref ref) {
  logger.i('productsStream: 商品一覧ストリームを開始します');
  try {
    return ref.watch(productRepositoryProvider).watchProducts();
  } on Exception catch (e, st) {
    logger.e('productsStream: 商品一覧ストリームエラー', error: e, stackTrace: st);
    throw GeneralException(message: '商品一覧の取得に失敗しました', stackTrace: st);
  }
}

@riverpod
Stream<Product> productDocStream(
  Ref ref,
  DocumentReference<Product> productDocRef,
) {
  logger.i(
    'productDocStream: 商品ドキュメントストリームを開始します productDocRef=$productDocRef',
  );
  try {
    return ref.watch(productRepositoryProvider).watchProductDoc(productDocRef);
  } on Exception catch (e, st) {
    logger.e('productDocStream: 商品ドキュメントストリームエラー', error: e, stackTrace: st);
    throw GeneralException(message: '商品ドキュメントの取得に失敗しました', stackTrace: st);
  }
}

@riverpod
Stream<Product> productStream(Ref ref, String productId) {
  logger.i('productStream: 商品ストリームを開始します productId=$productId');
  try {
    return ref.watch(productRepositoryProvider).watchProduct(productId);
  } on Exception catch (e, st) {
    logger.e('productStream: 商品ストリームエラー', error: e, stackTrace: st);
    throw GeneralException(message: '商品の取得に失敗しました', stackTrace: st);
  }
}
