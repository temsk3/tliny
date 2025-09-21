// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'sns_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(snsRepository)
const snsRepositoryProvider = SnsRepositoryProvider._();

final class SnsRepositoryProvider
    extends $FunctionalProvider<SnsRepository, SnsRepository, SnsRepository>
    with $Provider<SnsRepository> {
  const SnsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'snsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$snsRepositoryHash();

  @$internal
  @override
  $ProviderElement<SnsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SnsRepository create(Ref ref) {
    return snsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SnsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SnsRepository>(value),
    );
  }
}

String _$snsRepositoryHash() => r'cd2b9a6178651dbf5caea4aa124adce4080fa425';
