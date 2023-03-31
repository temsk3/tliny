import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

  Stream<List<Product>> streamProducts(GenreType? genre) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;
    if (genre == null) {
      snapshot = _db.collection(_collectionPath).snapshots();
    } else {
      snapshot = _db
          .collection(_collectionPath)
          .where('genre', isEqualTo: EnumToString.convertToString(genre))
          .snapshots();
    }
    return snapshot.map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return Product.fromJson(doc.data()).copyWith(id: doc.id);
        }).toList();
      },
    );
  }

  Stream<List<Product>> streamProgramProducts(
    ProductQueryParameter queryParameter,
  ) {
    if (queryParameter.programId == null) {
      return streamProducts(queryParameter.genre);
    }
    final Query<Map<String, dynamic>> query;
    if (queryParameter.genre == null) {
      query = _db
          .collection(_collectionPath)
          .where('eventId', isEqualTo: queryParameter.programId);
    } else {
      query = _db
          .collection(_collectionPath)
          .where('eventId', isEqualTo: queryParameter.programId)
          .where(
            'genre',
            isEqualTo: EnumToString.convertToString(queryParameter.genre),
          );
    }
    return query.snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return Product.fromJson(doc.data()).copyWith(id: doc.id);
        }).toList();
      },
    );
  }

  Future<List<Product>> programProducts(String programId) async {
    final querySnapshot =
        await _collectionRef.where('eventId', isEqualTo: programId).get();
    final queryDocSnapshot = querySnapshot.docs;
    return queryDocSnapshot.map((doc) => doc.data()).toList();
  }

  // 取得
  Stream<List<Product>> watchProducts() {
    return _collectionRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  Stream<Product> watchProduct(String productId) {
    return _collectionRef.doc(productId).snapshots().map((doc) {
      if (!doc.exists) {
        throw Error();
      }
      return doc.data()!;
    });
  }

  Future<List<Product>> readProducts() async {
    final querySnapshot = await _collectionRef.get();
    final queryDocSnapshot = querySnapshot.docs;
    return queryDocSnapshot.map((doc) => doc.data()).toList();
  }

  // 登録
  Future<String> createProduct(Product product) async {
    final docRef = await _collectionRef.add(product);
    return docRef.id;
  }

  // 更新
  Future<String> updateProduct(Product product) async {
    final docRef = _collectionRef.doc(product.id);
    await docRef.set(product, SetOptions(merge: true));
    return docRef.id;
  }

  // 削除
  Future<void> deleteProduct(String productId) async {
    await _collectionRef.doc(productId).delete();
    // await _collectionRef.doc(productId).update({'isActive':false});
  }
}

// Stream
@riverpod
Stream<List<Product>> productsStream(ProductsStreamRef ref) {
  return ref.watch(productRepositoryProvider).watchProducts();
}

@riverpod
Stream<Product> productDocStream(
  ProductDocStreamRef ref,
  DocumentReference<Map<String, dynamic>> productDocRef,
) {
  final documentSnapshot = productDocRef.snapshots();
  return documentSnapshot.map((doc) {
    if (!doc.exists) {
      throw Error();
    }
    return Product.fromJson(doc.data()!).copyWith(id: doc.id);
  });
}

@riverpod
Stream<Product> productStream(
  ProductStreamRef ref,
  String productId,
) {
  return ref.watch(productRepositoryProvider).watchProduct(productId);
}
