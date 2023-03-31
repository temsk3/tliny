// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'product_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productRepositoryHash() => r'e3c2eb71b28c272d8eb2a34276676a83492a97fa';

/// See also [productRepository].
@ProviderFor(productRepository)
final productRepositoryProvider = Provider<ProductRepository>.internal(
  productRepository,
  name: r'productRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProductRepositoryRef = ProviderRef<ProductRepository>;
String _$productsStreamHash() => r'fea45501f14fcb36118bc5b41b0eb0c1e81522f6';

/// See also [productsStream].
@ProviderFor(productsStream)
final productsStreamProvider =
    AutoDisposeStreamProvider<List<Product>>.internal(
  productsStream,
  name: r'productsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProductsStreamRef = AutoDisposeStreamProviderRef<List<Product>>;
String _$productDocStreamHash() => r'15da24ad424d4294b243c843a8cfd2e3fc466a18';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef ProductDocStreamRef = AutoDisposeStreamProviderRef<Product>;

/// See also [productDocStream].
@ProviderFor(productDocStream)
const productDocStreamProvider = ProductDocStreamFamily();

/// See also [productDocStream].
class ProductDocStreamFamily extends Family<AsyncValue<Product>> {
  /// See also [productDocStream].
  const ProductDocStreamFamily();

  /// See also [productDocStream].
  ProductDocStreamProvider call(
    DocumentReference<Map<String, dynamic>> productDocRef,
  ) {
    return ProductDocStreamProvider(
      productDocRef,
    );
  }

  @override
  ProductDocStreamProvider getProviderOverride(
    covariant ProductDocStreamProvider provider,
  ) {
    return call(
      provider.productDocRef,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productDocStreamProvider';
}

/// See also [productDocStream].
class ProductDocStreamProvider extends AutoDisposeStreamProvider<Product> {
  /// See also [productDocStream].
  ProductDocStreamProvider(
    this.productDocRef,
  ) : super.internal(
          (ref) => productDocStream(
            ref,
            productDocRef,
          ),
          from: productDocStreamProvider,
          name: r'productDocStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productDocStreamHash,
          dependencies: ProductDocStreamFamily._dependencies,
          allTransitiveDependencies:
              ProductDocStreamFamily._allTransitiveDependencies,
        );

  final DocumentReference<Map<String, dynamic>> productDocRef;

  @override
  bool operator ==(Object other) {
    return other is ProductDocStreamProvider &&
        other.productDocRef == productDocRef;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productDocRef.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$productStreamHash() => r'6ef066e769b4a735c187629942967cd7d1275789';
typedef ProductStreamRef = AutoDisposeStreamProviderRef<Product>;

/// See also [productStream].
@ProviderFor(productStream)
const productStreamProvider = ProductStreamFamily();

/// See also [productStream].
class ProductStreamFamily extends Family<AsyncValue<Product>> {
  /// See also [productStream].
  const ProductStreamFamily();

  /// See also [productStream].
  ProductStreamProvider call(
    String productId,
  ) {
    return ProductStreamProvider(
      productId,
    );
  }

  @override
  ProductStreamProvider getProviderOverride(
    covariant ProductStreamProvider provider,
  ) {
    return call(
      provider.productId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productStreamProvider';
}

/// See also [productStream].
class ProductStreamProvider extends AutoDisposeStreamProvider<Product> {
  /// See also [productStream].
  ProductStreamProvider(
    this.productId,
  ) : super.internal(
          (ref) => productStream(
            ref,
            productId,
          ),
          from: productStreamProvider,
          name: r'productStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productStreamHash,
          dependencies: ProductStreamFamily._dependencies,
          allTransitiveDependencies:
              ProductStreamFamily._allTransitiveDependencies,
        );

  final String productId;

  @override
  bool operator ==(Object other) {
    return other is ProductStreamProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
