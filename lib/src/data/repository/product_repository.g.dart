// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'product_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productRepositoryHash() => r'93a29e114c0f2197ebcbb1c29ac3b96cb0c786de';

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
String _$productsStreamHash() => r'08fe08fdfd972bff22f4f3afe02e5a125565997d';

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
String _$productDocStreamHash() => r'9f94bca57ae5fd3b1e880d3960de84216a464585';

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

/// See also [productDocStream].
@ProviderFor(productDocStream)
const productDocStreamProvider = ProductDocStreamFamily();

/// See also [productDocStream].
class ProductDocStreamFamily extends Family<AsyncValue<Product>> {
  /// See also [productDocStream].
  const ProductDocStreamFamily();

  /// See also [productDocStream].
  ProductDocStreamProvider call(
    DocumentReference<Product> productDocRef,
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
    DocumentReference<Product> productDocRef,
  ) : this._internal(
          (ref) => productDocStream(
            ref as ProductDocStreamRef,
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
          productDocRef: productDocRef,
        );

  ProductDocStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productDocRef,
  }) : super.internal();

  final DocumentReference<Product> productDocRef;

  @override
  Override overrideWith(
    Stream<Product> Function(ProductDocStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductDocStreamProvider._internal(
        (ref) => create(ref as ProductDocStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productDocRef: productDocRef,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Product> createElement() {
    return _ProductDocStreamProviderElement(this);
  }

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

mixin ProductDocStreamRef on AutoDisposeStreamProviderRef<Product> {
  /// The parameter `productDocRef` of this provider.
  DocumentReference<Product> get productDocRef;
}

class _ProductDocStreamProviderElement
    extends AutoDisposeStreamProviderElement<Product> with ProductDocStreamRef {
  _ProductDocStreamProviderElement(super.provider);

  @override
  DocumentReference<Product> get productDocRef =>
      (origin as ProductDocStreamProvider).productDocRef;
}

String _$productStreamHash() => r'200afe35ff39ef405332646f24832f86a4b174e4';

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
    String productId,
  ) : this._internal(
          (ref) => productStream(
            ref as ProductStreamRef,
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
          productId: productId,
        );

  ProductStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final String productId;

  @override
  Override overrideWith(
    Stream<Product> Function(ProductStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductStreamProvider._internal(
        (ref) => create(ref as ProductStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Product> createElement() {
    return _ProductStreamProviderElement(this);
  }

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

mixin ProductStreamRef on AutoDisposeStreamProviderRef<Product> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _ProductStreamProviderElement
    extends AutoDisposeStreamProviderElement<Product> with ProductStreamRef {
  _ProductStreamProviderElement(super.provider);

  @override
  String get productId => (origin as ProductStreamProvider).productId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
