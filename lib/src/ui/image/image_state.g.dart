// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'image_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tempImage)
const tempImageProvider = TempImageProvider._();

final class TempImageProvider
    extends $FunctionalProvider<AsyncValue<XFile?>, XFile?, FutureOr<XFile?>>
    with $FutureModifier<XFile?>, $FutureProvider<XFile?> {
  const TempImageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tempImageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tempImageHash();

  @$internal
  @override
  $FutureProviderElement<XFile?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<XFile?> create(Ref ref) {
    return tempImage(ref);
  }
}

String _$tempImageHash() => r'e2678ea9fb90b5d700c986b196db37f69f81470d';
