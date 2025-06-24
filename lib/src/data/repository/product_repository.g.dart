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
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$productRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductRepositoryRef = ProviderRef<ProductRepository>;
String _$productsStreamHash() => r'f8bfbee583a452c77a2084f8f6fd68f15ff72c05';

/// See also [productsStream].
@ProviderFor(productsStream)
final productsStreamProvider =
    AutoDisposeStreamProvider<List<Product>>.internal(
      productsStream,
      name: r'productsStreamProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$productsStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductsStreamRef = AutoDisposeStreamProviderRef<List<Product>>;
String _$productDocStreamHash() => r'a00d6ee08fb3561720a95b80f8ac78d6322e4c07';

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
    DocumentReference<Map<String, dynamic>> productDocRef,
  ) {
    return ProductDocStreamProvider(productDocRef);
  }

  @override
  ProductDocStreamProvider getProviderOverride(
    covariant ProductDocStreamProvider provider,
  ) {
    return call(provider.productDocRef);
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
    DocumentReference<Map<String, dynamic>> productDocRef,
  ) : this._internal(
        (ref) => productDocStream(ref as ProductDocStreamRef, productDocRef),
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

  final DocumentReference<Map<String, dynamic>> productDocRef;

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductDocStreamRef on AutoDisposeStreamProviderRef<Product> {
  /// The parameter `productDocRef` of this provider.
  DocumentReference<Map<String, dynamic>> get productDocRef;
}

class _ProductDocStreamProviderElement
    extends AutoDisposeStreamProviderElement<Product>
    with ProductDocStreamRef {
  _ProductDocStreamProviderElement(super.provider);

  @override
  DocumentReference<Map<String, dynamic>> get productDocRef =>
      (origin as ProductDocStreamProvider).productDocRef;
}

String _$productStreamHash() => r'ef3a50ef8c6df7e2da08dc8a73192097e99e8e51';

/// See also [productStream].
@ProviderFor(productStream)
const productStreamProvider = ProductStreamFamily();

/// See also [productStream].
class ProductStreamFamily extends Family<AsyncValue<Product>> {
  /// See also [productStream].
  const ProductStreamFamily();

  /// See also [productStream].
  ProductStreamProvider call(String productId) {
    return ProductStreamProvider(productId);
  }

  @override
  ProductStreamProvider getProviderOverride(
    covariant ProductStreamProvider provider,
  ) {
    return call(provider.productId);
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
  ProductStreamProvider(String productId)
    : this._internal(
        (ref) => productStream(ref as ProductStreamRef, productId),
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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductStreamRef on AutoDisposeStreamProviderRef<Product> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _ProductStreamProviderElement
    extends AutoDisposeStreamProviderElement<Product>
    with ProductStreamRef {
  _ProductStreamProviderElement(super.provider);

  @override
  String get productId => (origin as ProductStreamProvider).productId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
