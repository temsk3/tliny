// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'product_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(productsState)
const productsStateProvider = ProductsStateFamily._();

final class ProductsStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Product>>,
          List<Product>,
          Stream<List<Product>>
        >
    with $FutureModifier<List<Product>>, $StreamProvider<List<Product>> {
  const ProductsStateProvider._({
    required ProductsStateFamily super.from,
    required (String, GenreType?) super.argument,
  }) : super(
         retry: null,
         name: r'productsStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productsStateHash();

  @override
  String toString() {
    return r'productsStateProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<List<Product>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Product>> create(Ref ref) {
    final argument = this.argument as (String, GenreType?);
    return productsState(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productsStateHash() => r'a935c98657f64a61bc97b390e94a44270ee6f6d2';

final class ProductsStateFamily extends $Family
    with
        $FunctionalFamilyOverride<Stream<List<Product>>, (String, GenreType?)> {
  const ProductsStateFamily._()
    : super(
        retry: null,
        name: r'productsStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProductsStateProvider call(String programId, GenreType? genre) =>
      ProductsStateProvider._(argument: (programId, genre), from: this);

  @override
  String toString() => r'productsStateProvider';
}

@ProviderFor(productState)
const productStateProvider = ProductStateFamily._();

final class ProductStateProvider
    extends $FunctionalProvider<AsyncValue<Product>, Product, Stream<Product>>
    with $FutureModifier<Product>, $StreamProvider<Product> {
  const ProductStateProvider._({
    required ProductStateFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'productStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productStateHash();

  @override
  String toString() {
    return r'productStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Product> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Product> create(Ref ref) {
    final argument = this.argument as String?;
    return productState(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productStateHash() => r'3f9fb71cbce7e641106620aaa016f2e26cc238c4';

final class ProductStateFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Product>, String?> {
  const ProductStateFamily._()
    : super(
        retry: null,
        name: r'productStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProductStateProvider call(String? productId) =>
      ProductStateProvider._(argument: productId, from: this);

  @override
  String toString() => r'productStateProvider';
}

@ProviderFor(addProductButtonState)
const addProductButtonStateProvider = AddProductButtonStateFamily._();

final class AddProductButtonStateProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  const AddProductButtonStateProvider._({
    required AddProductButtonStateFamily super.from,
    required Program super.argument,
  }) : super(
         retry: null,
         name: r'addProductButtonStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$addProductButtonStateHash();

  @override
  String toString() {
    return r'addProductButtonStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    final argument = this.argument as Program;
    return addProductButtonState(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AddProductButtonStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$addProductButtonStateHash() =>
    r'49a6a5c27dd46d61c62dd59b89b711bf21e76e80';

final class AddProductButtonStateFamily extends $Family
    with $FunctionalFamilyOverride<Stream<bool>, Program> {
  const AddProductButtonStateFamily._()
    : super(
        retry: null,
        name: r'addProductButtonStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AddProductButtonStateProvider call(Program program) =>
      AddProductButtonStateProvider._(argument: program, from: this);

  @override
  String toString() => r'addProductButtonStateProvider';
}

@ProviderFor(editProductButtonState)
const editProductButtonStateProvider = EditProductButtonStateFamily._();

final class EditProductButtonStateProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  const EditProductButtonStateProvider._({
    required EditProductButtonStateFamily super.from,
    required Product super.argument,
  }) : super(
         retry: null,
         name: r'editProductButtonStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$editProductButtonStateHash();

  @override
  String toString() {
    return r'editProductButtonStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    final argument = this.argument as Product;
    return editProductButtonState(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EditProductButtonStateProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$editProductButtonStateHash() =>
    r'7a76770cbaee4860243d1746e08fe6ec65930e04';

final class EditProductButtonStateFamily extends $Family
    with $FunctionalFamilyOverride<Stream<bool>, Product> {
  const EditProductButtonStateFamily._()
    : super(
        retry: null,
        name: r'editProductButtonStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EditProductButtonStateProvider call(Product product) =>
      EditProductButtonStateProvider._(argument: product, from: this);

  @override
  String toString() => r'editProductButtonStateProvider';
}
