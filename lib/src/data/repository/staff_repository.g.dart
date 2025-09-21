// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'staff_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(staffRepository)
const staffRepositoryProvider = StaffRepositoryProvider._();

final class StaffRepositoryProvider
    extends
        $FunctionalProvider<StaffRepository, StaffRepository, StaffRepository>
    with $Provider<StaffRepository> {
  const StaffRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'staffRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$staffRepositoryHash();

  @$internal
  @override
  $ProviderElement<StaffRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StaffRepository create(Ref ref) {
    return staffRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StaffRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StaffRepository>(value),
    );
  }
}

String _$staffRepositoryHash() => r'd5898172867636b4cd4411bdec6b3389c7d48f9e';

/// イベントIDを指定して、ログイン中のユーザーがスタッフかどうかを確認するストリーム

@ProviderFor(staffCheckExistence)
const staffCheckExistenceProvider = StaffCheckExistenceFamily._();

/// イベントIDを指定して、ログイン中のユーザーがスタッフかどうかを確認するストリーム

final class StaffCheckExistenceProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  /// イベントIDを指定して、ログイン中のユーザーがスタッフかどうかを確認するストリーム
  const StaffCheckExistenceProvider._({
    required StaffCheckExistenceFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'staffCheckExistenceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$staffCheckExistenceHash();

  @override
  String toString() {
    return r'staffCheckExistenceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    final argument = this.argument as String;
    return staffCheckExistence(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is StaffCheckExistenceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$staffCheckExistenceHash() =>
    r'db2e2a955bb619f533cf7cbfe7d23c8f0fac4ef3';

/// イベントIDを指定して、ログイン中のユーザーがスタッフかどうかを確認するストリーム

final class StaffCheckExistenceFamily extends $Family
    with $FunctionalFamilyOverride<Stream<bool>, String> {
  const StaffCheckExistenceFamily._()
    : super(
        retry: null,
        name: r'staffCheckExistenceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// イベントIDを指定して、ログイン中のユーザーがスタッフかどうかを確認するストリーム

  StaffCheckExistenceProvider call(String eventId) =>
      StaffCheckExistenceProvider._(argument: eventId, from: this);

  @override
  String toString() => r'staffCheckExistenceProvider';
}
