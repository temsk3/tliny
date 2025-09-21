// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'cart_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// カートの状態を管理する ViewModel

@ProviderFor(CartViewModel)
const cartViewModelProvider = CartViewModelProvider._();

/// カートの状態を管理する ViewModel
final class CartViewModelProvider
    extends $AsyncNotifierProvider<CartViewModel, List<Cart>> {
  /// カートの状態を管理する ViewModel
  const CartViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartViewModelHash();

  @$internal
  @override
  CartViewModel create() => CartViewModel();
}

String _$cartViewModelHash() => r'4e3c96b54f3001582c41f8243dc61db84350d622';

/// カートの状態を管理する ViewModel

abstract class _$CartViewModel extends $AsyncNotifier<List<Cart>> {
  FutureOr<List<Cart>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Cart>>, List<Cart>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Cart>>, List<Cart>>,
              AsyncValue<List<Cart>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
