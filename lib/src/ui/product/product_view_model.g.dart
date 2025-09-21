// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'product_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductViewModel)
const productViewModelProvider = ProductViewModelProvider._();

final class ProductViewModelProvider
    extends $AsyncNotifierProvider<ProductViewModel, List<Product>> {
  const ProductViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productViewModelHash();

  @$internal
  @override
  ProductViewModel create() => ProductViewModel();
}

String _$productViewModelHash() => r'abf69bd16b648a4a88cb75ca1d1f8ccf29fd3ddb';

abstract class _$ProductViewModel extends $AsyncNotifier<List<Product>> {
  FutureOr<List<Product>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Product>>, List<Product>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Product>>, List<Product>>,
              AsyncValue<List<Product>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
