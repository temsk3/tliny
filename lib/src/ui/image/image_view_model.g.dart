// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'image_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 画像のURLリストを管理する StateNotifierProvider

@ProviderFor(ImageViewModel)
const imageViewModelProvider = ImageViewModelProvider._();

/// 画像のURLリストを管理する StateNotifierProvider
final class ImageViewModelProvider
    extends $AsyncNotifierProvider<ImageViewModel, List<String>> {
  /// 画像のURLリストを管理する StateNotifierProvider
  const ImageViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imageViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imageViewModelHash();

  @$internal
  @override
  ImageViewModel create() => ImageViewModel();
}

String _$imageViewModelHash() => r'bef9288007c5d6202b282c3be4fa1b82d6c661f8';

/// 画像のURLリストを管理する StateNotifierProvider

abstract class _$ImageViewModel extends $AsyncNotifier<List<String>> {
  FutureOr<List<String>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<String>>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<String>>, List<String>>,
              AsyncValue<List<String>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// 一時的な画像ファイルの情報を管理する StateNotifierProvider

@ProviderFor(TempImageViewModel)
const tempImageViewModelProvider = TempImageViewModelProvider._();

/// 一時的な画像ファイルの情報を管理する StateNotifierProvider
final class TempImageViewModelProvider
    extends $AsyncNotifierProvider<TempImageViewModel, XFile?> {
  /// 一時的な画像ファイルの情報を管理する StateNotifierProvider
  const TempImageViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tempImageViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tempImageViewModelHash();

  @$internal
  @override
  TempImageViewModel create() => TempImageViewModel();
}

String _$tempImageViewModelHash() =>
    r'9b44b0069aec0d529e72da7773e65dd0d9d9d87e';

/// 一時的な画像ファイルの情報を管理する StateNotifierProvider

abstract class _$TempImageViewModel extends $AsyncNotifier<XFile?> {
  FutureOr<XFile?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<XFile?>, XFile?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<XFile?>, XFile?>,
              AsyncValue<XFile?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// 一時的な画像ファイルのリストを管理する StateNotifierProvider

@ProviderFor(TempImageListViewModel)
const tempImageListViewModelProvider = TempImageListViewModelProvider._();

/// 一時的な画像ファイルのリストを管理する StateNotifierProvider
final class TempImageListViewModelProvider
    extends $AsyncNotifierProvider<TempImageListViewModel, Map<int, XFile>> {
  /// 一時的な画像ファイルのリストを管理する StateNotifierProvider
  const TempImageListViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tempImageListViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tempImageListViewModelHash();

  @$internal
  @override
  TempImageListViewModel create() => TempImageListViewModel();
}

String _$tempImageListViewModelHash() =>
    r'a8926e03ccb157781e425e678331275638f44e3e';

/// 一時的な画像ファイルのリストを管理する StateNotifierProvider

abstract class _$TempImageListViewModel
    extends $AsyncNotifier<Map<int, XFile>> {
  FutureOr<Map<int, XFile>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Map<int, XFile>>, Map<int, XFile>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Map<int, XFile>>, Map<int, XFile>>,
              AsyncValue<Map<int, XFile>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
