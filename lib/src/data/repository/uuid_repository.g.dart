// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'uuid_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(uuidRepository)
const uuidRepositoryProvider = UuidRepositoryProvider._();

final class UuidRepositoryProvider
    extends $FunctionalProvider<UuidRepository, UuidRepository, UuidRepository>
    with $Provider<UuidRepository> {
  const UuidRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uuidRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uuidRepositoryHash();

  @$internal
  @override
  $ProviderElement<UuidRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UuidRepository create(Ref ref) {
    return uuidRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UuidRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UuidRepository>(value),
    );
  }
}

String _$uuidRepositoryHash() => r'f6dff6fa8d888f6b17691258934a7d967166d626';
