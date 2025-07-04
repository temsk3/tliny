// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'image_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$imageViewModelHash() => r'bef9288007c5d6202b282c3be4fa1b82d6c661f8';

/// 画像のURLリストを管理する StateNotifierProvider
///
/// Copied from [ImageViewModel].
@ProviderFor(ImageViewModel)
final imageViewModelProvider =
    AutoDisposeAsyncNotifierProvider<ImageViewModel, List<String>>.internal(
      ImageViewModel.new,
      name: r'imageViewModelProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$imageViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ImageViewModel = AutoDisposeAsyncNotifier<List<String>>;
String _$tempImageViewModelHash() =>
    r'9b44b0069aec0d529e72da7773e65dd0d9d9d87e';

/// 一時的な画像ファイルの情報を管理する StateNotifierProvider
///
/// Copied from [TempImageViewModel].
@ProviderFor(TempImageViewModel)
final tempImageViewModelProvider =
    AutoDisposeAsyncNotifierProvider<TempImageViewModel, XFile?>.internal(
      TempImageViewModel.new,
      name: r'tempImageViewModelProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$tempImageViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TempImageViewModel = AutoDisposeAsyncNotifier<XFile?>;
String _$tempImageListViewModelHash() =>
    r'a8926e03ccb157781e425e678331275638f44e3e';

/// 一時的な画像ファイルのリストを管理する StateNotifierProvider
///
/// Copied from [TempImageListViewModel].
@ProviderFor(TempImageListViewModel)
final tempImageListViewModelProvider = AutoDisposeAsyncNotifierProvider<
  TempImageListViewModel,
  Map<int, XFile>
>.internal(
  TempImageListViewModel.new,
  name: r'tempImageListViewModelProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$tempImageListViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TempImageListViewModel = AutoDisposeAsyncNotifier<Map<int, XFile>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
