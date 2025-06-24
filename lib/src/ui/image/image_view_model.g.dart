// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'image_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$imageViewModelHash() => r'fe32c52d8cb1401fc2a0790f6a607e4a4c9189ce';

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
    r'56e83c3b66b20b52216362de23c600d0bd238c7f';

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
    r'865fc8df46e034291cc83243425513fdb86969eb';

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
