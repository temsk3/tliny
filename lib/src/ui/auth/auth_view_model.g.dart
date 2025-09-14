// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'auth_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authViewModelHash() => r'dc3e7f55ce8634ca336a76c3bda3668d436e03eb';

/// 認証状態を管理する ViewModel
///
/// Copied from [AuthViewModel].
@ProviderFor(AuthViewModel)
final authViewModelProvider =
    AutoDisposeNotifierProvider<AuthViewModel, User?>.internal(
      AuthViewModel.new,
      name: r'authViewModelProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$authViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AuthViewModel = AutoDisposeNotifier<User?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
