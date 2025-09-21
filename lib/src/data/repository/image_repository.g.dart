// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'image_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(imageRepository)
const imageRepositoryProvider = ImageRepositoryProvider._();

final class ImageRepositoryProvider
    extends
        $FunctionalProvider<ImageRepository, ImageRepository, ImageRepository>
    with $Provider<ImageRepository> {
  const ImageRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imageRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imageRepositoryHash();

  @$internal
  @override
  $ProviderElement<ImageRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ImageRepository create(Ref ref) {
    return imageRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImageRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImageRepository>(value),
    );
  }
}

String _$imageRepositoryHash() => r'd9d3ea7e121c29817ef5b725e27f3ba22a3d8c7b';
