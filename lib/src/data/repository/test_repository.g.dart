// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'test_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(testRepository)
const testRepositoryProvider = TestRepositoryProvider._();

final class TestRepositoryProvider
    extends $FunctionalProvider<TestRepository, TestRepository, TestRepository>
    with $Provider<TestRepository> {
  const TestRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'testRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$testRepositoryHash();

  @$internal
  @override
  $ProviderElement<TestRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TestRepository create(Ref ref) {
    return testRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TestRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TestRepository>(value),
    );
  }
}

String _$testRepositoryHash() => r'789b751b3e92351b3b78439967a3789b859e3593';
