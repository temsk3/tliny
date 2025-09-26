// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'cart_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// カートの状態を管理する StreamProvider

@ProviderFor(cartState)
const cartStateProvider = CartStateProvider._();

/// カートの状態を管理する StreamProvider

final class CartStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Cart>>,
          List<Cart>,
          Stream<List<Cart>>
        >
    with $FutureModifier<List<Cart>>, $StreamProvider<List<Cart>> {
  /// カートの状態を管理する StreamProvider
  const CartStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartStateHash();

  @$internal
  @override
  $StreamProviderElement<List<Cart>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Cart>> create(Ref ref) {
    return cartState(ref);
  }
}

String _$cartStateHash() => r'decad69435457d9b8bd84ff673409ed12431dc9c';

/// 商品価格のキャッシュを管理するプロバイダー

@ProviderFor(productPriceCache)
const productPriceCacheProvider = ProductPriceCacheFamily._();

/// 商品価格のキャッシュを管理するプロバイダー

final class ProductPriceCacheProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, int>>,
          Map<String, int>,
          FutureOr<Map<String, int>>
        >
    with $FutureModifier<Map<String, int>>, $FutureProvider<Map<String, int>> {
  /// 商品価格のキャッシュを管理するプロバイダー
  const ProductPriceCacheProvider._({
    required ProductPriceCacheFamily super.from,
    required List<String> super.argument,
  }) : super(
         retry: null,
         name: r'productPriceCacheProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productPriceCacheHash();

  @override
  String toString() {
    return r'productPriceCacheProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<String, int>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, int>> create(Ref ref) {
    final argument = this.argument as List<String>;
    return productPriceCache(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductPriceCacheProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productPriceCacheHash() => r'849a6ca38f6a79b15ed90b168d7fc0988298c872';

/// 商品価格のキャッシュを管理するプロバイダー

final class ProductPriceCacheFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Map<String, int>>, List<String>> {
  const ProductPriceCacheFamily._()
    : super(
        retry: null,
        name: r'productPriceCacheProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 商品価格のキャッシュを管理するプロバイダー

  ProductPriceCacheProvider call(List<String> productIds) =>
      ProductPriceCacheProvider._(argument: productIds, from: this);

  @override
  String toString() => r'productPriceCacheProvider';
}

/// 合計金額を管理する AsyncNotifier（根本的解決版）

@ProviderFor(TotalAmountNotifier)
const totalAmountProvider = TotalAmountNotifierFamily._();

/// 合計金額を管理する AsyncNotifier（根本的解決版）
final class TotalAmountNotifierProvider
    extends $AsyncNotifierProvider<TotalAmountNotifier, int> {
  /// 合計金額を管理する AsyncNotifier（根本的解決版）
  const TotalAmountNotifierProvider._({
    required TotalAmountNotifierFamily super.from,
    required List<Cart> super.argument,
  }) : super(
         retry: null,
         name: r'totalAmountProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$totalAmountNotifierHash();

  @override
  String toString() {
    return r'totalAmountProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TotalAmountNotifier create() => TotalAmountNotifier();

  @override
  bool operator ==(Object other) {
    return other is TotalAmountNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$totalAmountNotifierHash() =>
    r'fbfd20d3be820621b1a7e51efd0cbe5b987e1543';

/// 合計金額を管理する AsyncNotifier（根本的解決版）

final class TotalAmountNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          TotalAmountNotifier,
          AsyncValue<int>,
          int,
          FutureOr<int>,
          List<Cart>
        > {
  const TotalAmountNotifierFamily._()
    : super(
        retry: null,
        name: r'totalAmountProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 合計金額を管理する AsyncNotifier（根本的解決版）

  TotalAmountNotifierProvider call(List<Cart> list) =>
      TotalAmountNotifierProvider._(argument: list, from: this);

  @override
  String toString() => r'totalAmountProvider';
}

/// 合計金額を管理する AsyncNotifier（根本的解決版）

abstract class _$TotalAmountNotifier extends $AsyncNotifier<int> {
  late final _$args = ref.$arg as List<Cart>;
  List<Cart> get list => _$args;

  FutureOr<int> build(List<Cart> list);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<int>, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<int>, int>,
              AsyncValue<int>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
