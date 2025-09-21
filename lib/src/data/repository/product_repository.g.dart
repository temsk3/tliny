// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'product_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(productRepository)
const productRepositoryProvider = ProductRepositoryProvider._();

final class ProductRepositoryProvider
    extends
        $FunctionalProvider<
          ProductRepository,
          ProductRepository,
          ProductRepository
        >
    with $Provider<ProductRepository> {
  const ProductRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProductRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProductRepository create(Ref ref) {
    return productRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProductRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProductRepository>(value),
    );
  }
}

String _$productRepositoryHash() => r'93a29e114c0f2197ebcbb1c29ac3b96cb0c786de';

@ProviderFor(productsStream)
const productsStreamProvider = ProductsStreamProvider._();

final class ProductsStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Product>>,
          List<Product>,
          Stream<List<Product>>
        >
    with $FutureModifier<List<Product>>, $StreamProvider<List<Product>> {
  const ProductsStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productsStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productsStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<Product>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Product>> create(Ref ref) {
    return productsStream(ref);
  }
}

String _$productsStreamHash() => r'08fe08fdfd972bff22f4f3afe02e5a125565997d';

@ProviderFor(productDocStream)
const productDocStreamProvider = ProductDocStreamFamily._();

final class ProductDocStreamProvider
    extends $FunctionalProvider<AsyncValue<Product>, Product, Stream<Product>>
    with $FutureModifier<Product>, $StreamProvider<Product> {
  const ProductDocStreamProvider._({
    required ProductDocStreamFamily super.from,
    required DocumentReference<Product> super.argument,
  }) : super(
         retry: null,
         name: r'productDocStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productDocStreamHash();

  @override
  String toString() {
    return r'productDocStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Product> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Product> create(Ref ref) {
    final argument = this.argument as DocumentReference<Product>;
    return productDocStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductDocStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productDocStreamHash() => r'9f94bca57ae5fd3b1e880d3960de84216a464585';

final class ProductDocStreamFamily extends $Family
    with
        $FunctionalFamilyOverride<Stream<Product>, DocumentReference<Product>> {
  const ProductDocStreamFamily._()
    : super(
        retry: null,
        name: r'productDocStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProductDocStreamProvider call(DocumentReference<Product> productDocRef) =>
      ProductDocStreamProvider._(argument: productDocRef, from: this);

  @override
  String toString() => r'productDocStreamProvider';
}

@ProviderFor(productStream)
const productStreamProvider = ProductStreamFamily._();

final class ProductStreamProvider
    extends $FunctionalProvider<AsyncValue<Product>, Product, Stream<Product>>
    with $FutureModifier<Product>, $StreamProvider<Product> {
  const ProductStreamProvider._({
    required ProductStreamFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'productStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productStreamHash();

  @override
  String toString() {
    return r'productStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Product> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Product> create(Ref ref) {
    final argument = this.argument as String;
    return productStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productStreamHash() => r'200afe35ff39ef405332646f24832f86a4b174e4';

final class ProductStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Product>, String> {
  const ProductStreamFamily._()
    : super(
        retry: null,
        name: r'productStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProductStreamProvider call(String productId) =>
      ProductStreamProvider._(argument: productId, from: this);

  @override
  String toString() => r'productStreamProvider';
}
