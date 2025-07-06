// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'product_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsStateHash() => r'a935c98657f64a61bc97b390e94a44270ee6f6d2';

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

/// See also [productsState].
@ProviderFor(productsState)
const productsStateProvider = ProductsStateFamily();

/// See also [productsState].
class ProductsStateFamily extends Family<AsyncValue<List<Product>>> {
  /// See also [productsState].
  const ProductsStateFamily();

  /// See also [productsState].
  ProductsStateProvider call(String programId, GenreType? genre) {
    return ProductsStateProvider(programId, genre);
  }

  @override
  ProductsStateProvider getProviderOverride(
    covariant ProductsStateProvider provider,
  ) {
    return call(provider.programId, provider.genre);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productsStateProvider';
}

/// See also [productsState].
class ProductsStateProvider extends AutoDisposeStreamProvider<List<Product>> {
  /// See also [productsState].
  ProductsStateProvider(String programId, GenreType? genre)
    : this._internal(
        (ref) => productsState(ref as ProductsStateRef, programId, genre),
        from: productsStateProvider,
        name: r'productsStateProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$productsStateHash,
        dependencies: ProductsStateFamily._dependencies,
        allTransitiveDependencies:
            ProductsStateFamily._allTransitiveDependencies,
        programId: programId,
        genre: genre,
      );

  ProductsStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.programId,
    required this.genre,
  }) : super.internal();

  final String programId;
  final GenreType? genre;

  @override
  Override overrideWith(
    Stream<List<Product>> Function(ProductsStateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductsStateProvider._internal(
        (ref) => create(ref as ProductsStateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        programId: programId,
        genre: genre,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Product>> createElement() {
    return _ProductsStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsStateProvider &&
        other.programId == programId &&
        other.genre == genre;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, programId.hashCode);
    hash = _SystemHash.combine(hash, genre.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductsStateRef on AutoDisposeStreamProviderRef<List<Product>> {
  /// The parameter `programId` of this provider.
  String get programId;

  /// The parameter `genre` of this provider.
  GenreType? get genre;
}

class _ProductsStateProviderElement
    extends AutoDisposeStreamProviderElement<List<Product>>
    with ProductsStateRef {
  _ProductsStateProviderElement(super.provider);

  @override
  String get programId => (origin as ProductsStateProvider).programId;
  @override
  GenreType? get genre => (origin as ProductsStateProvider).genre;
}

String _$productStateHash() => r'3f9fb71cbce7e641106620aaa016f2e26cc238c4';

/// See also [productState].
@ProviderFor(productState)
const productStateProvider = ProductStateFamily();

/// See also [productState].
class ProductStateFamily extends Family<AsyncValue<Product>> {
  /// See also [productState].
  const ProductStateFamily();

  /// See also [productState].
  ProductStateProvider call(String? productId) {
    return ProductStateProvider(productId);
  }

  @override
  ProductStateProvider getProviderOverride(
    covariant ProductStateProvider provider,
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
  String? get name => r'productStateProvider';
}

/// See also [productState].
class ProductStateProvider extends AutoDisposeStreamProvider<Product> {
  /// See also [productState].
  ProductStateProvider(String? productId)
    : this._internal(
        (ref) => productState(ref as ProductStateRef, productId),
        from: productStateProvider,
        name: r'productStateProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$productStateHash,
        dependencies: ProductStateFamily._dependencies,
        allTransitiveDependencies:
            ProductStateFamily._allTransitiveDependencies,
        productId: productId,
      );

  ProductStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final String? productId;

  @override
  Override overrideWith(
    Stream<Product> Function(ProductStateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductStateProvider._internal(
        (ref) => create(ref as ProductStateRef),
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
    return _ProductStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductStateProvider && other.productId == productId;
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
mixin ProductStateRef on AutoDisposeStreamProviderRef<Product> {
  /// The parameter `productId` of this provider.
  String? get productId;
}

class _ProductStateProviderElement
    extends AutoDisposeStreamProviderElement<Product>
    with ProductStateRef {
  _ProductStateProviderElement(super.provider);

  @override
  String? get productId => (origin as ProductStateProvider).productId;
}

String _$addProductButtonStateHash() =>
    r'6383a4e4b5713326ac7bc7bbf2265bda37645827';

/// See also [addProductButtonState].
@ProviderFor(addProductButtonState)
const addProductButtonStateProvider = AddProductButtonStateFamily();

/// See also [addProductButtonState].
class AddProductButtonStateFamily extends Family<AsyncValue<bool>> {
  /// See also [addProductButtonState].
  const AddProductButtonStateFamily();

  /// See also [addProductButtonState].
  AddProductButtonStateProvider call(Program program) {
    return AddProductButtonStateProvider(program);
  }

  @override
  AddProductButtonStateProvider getProviderOverride(
    covariant AddProductButtonStateProvider provider,
  ) {
    return call(provider.program);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'addProductButtonStateProvider';
}

/// See also [addProductButtonState].
class AddProductButtonStateProvider extends AutoDisposeStreamProvider<bool> {
  /// See also [addProductButtonState].
  AddProductButtonStateProvider(Program program)
    : this._internal(
        (ref) =>
            addProductButtonState(ref as AddProductButtonStateRef, program),
        from: addProductButtonStateProvider,
        name: r'addProductButtonStateProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$addProductButtonStateHash,
        dependencies: AddProductButtonStateFamily._dependencies,
        allTransitiveDependencies:
            AddProductButtonStateFamily._allTransitiveDependencies,
        program: program,
      );

  AddProductButtonStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.program,
  }) : super.internal();

  final Program program;

  @override
  Override overrideWith(
    Stream<bool> Function(AddProductButtonStateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddProductButtonStateProvider._internal(
        (ref) => create(ref as AddProductButtonStateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        program: program,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<bool> createElement() {
    return _AddProductButtonStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddProductButtonStateProvider && other.program == program;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, program.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AddProductButtonStateRef on AutoDisposeStreamProviderRef<bool> {
  /// The parameter `program` of this provider.
  Program get program;
}

class _AddProductButtonStateProviderElement
    extends AutoDisposeStreamProviderElement<bool>
    with AddProductButtonStateRef {
  _AddProductButtonStateProviderElement(super.provider);

  @override
  Program get program => (origin as AddProductButtonStateProvider).program;
}

String _$editProductButtonStateHash() =>
    r'b32fca7ed8ac1de1e254bcc9ecdd27b37df1a97c';

/// See also [editProductButtonState].
@ProviderFor(editProductButtonState)
const editProductButtonStateProvider = EditProductButtonStateFamily();

/// See also [editProductButtonState].
class EditProductButtonStateFamily extends Family<AsyncValue<bool>> {
  /// See also [editProductButtonState].
  const EditProductButtonStateFamily();

  /// See also [editProductButtonState].
  EditProductButtonStateProvider call(Product product) {
    return EditProductButtonStateProvider(product);
  }

  @override
  EditProductButtonStateProvider getProviderOverride(
    covariant EditProductButtonStateProvider provider,
  ) {
    return call(provider.product);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'editProductButtonStateProvider';
}

/// See also [editProductButtonState].
class EditProductButtonStateProvider extends AutoDisposeStreamProvider<bool> {
  /// See also [editProductButtonState].
  EditProductButtonStateProvider(Product product)
    : this._internal(
        (ref) =>
            editProductButtonState(ref as EditProductButtonStateRef, product),
        from: editProductButtonStateProvider,
        name: r'editProductButtonStateProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$editProductButtonStateHash,
        dependencies: EditProductButtonStateFamily._dependencies,
        allTransitiveDependencies:
            EditProductButtonStateFamily._allTransitiveDependencies,
        product: product,
      );

  EditProductButtonStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.product,
  }) : super.internal();

  final Product product;

  @override
  Override overrideWith(
    Stream<bool> Function(EditProductButtonStateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EditProductButtonStateProvider._internal(
        (ref) => create(ref as EditProductButtonStateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        product: product,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<bool> createElement() {
    return _EditProductButtonStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditProductButtonStateProvider && other.product == product;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, product.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EditProductButtonStateRef on AutoDisposeStreamProviderRef<bool> {
  /// The parameter `product` of this provider.
  Product get product;
}

class _EditProductButtonStateProviderElement
    extends AutoDisposeStreamProviderElement<bool>
    with EditProductButtonStateRef {
  _EditProductButtonStateProviderElement(super.provider);

  @override
  Product get product => (origin as EditProductButtonStateProvider).product;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
