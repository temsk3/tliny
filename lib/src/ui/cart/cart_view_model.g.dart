// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'cart_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cartViewModelHash() => r'7039e49b19412a385b7c936885e9741fea689d5b';

/// カートの状態を管理する ViewModel
///
/// Copied from [CartViewModel].
@ProviderFor(CartViewModel)
final cartViewModelProvider =
    AutoDisposeAsyncNotifierProvider<CartViewModel, List<Cart>>.internal(
      CartViewModel.new,
      name: r'cartViewModelProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$cartViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CartViewModel = AutoDisposeAsyncNotifier<List<Cart>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
