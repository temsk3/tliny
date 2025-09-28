// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'staff_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$staffRepositoryHash() => r'd5898172867636b4cd4411bdec6b3389c7d48f9e';

/// See also [staffRepository].
@ProviderFor(staffRepository)
final staffRepositoryProvider = Provider<StaffRepository>.internal(
  staffRepository,
  name: r'staffRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$staffRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef StaffRepositoryRef = ProviderRef<StaffRepository>;
String _$staffCheckExistenceHash() =>
    r'db2e2a955bb619f533cf7cbfe7d23c8f0fac4ef3';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// イベントIDを指定して、ログイン中のユーザーがスタッフかどうかを確認するストリーム
///
/// Copied from [staffCheckExistence].
@ProviderFor(staffCheckExistence)
const staffCheckExistenceProvider = StaffCheckExistenceFamily();

/// イベントIDを指定して、ログイン中のユーザーがスタッフかどうかを確認するストリーム
///
/// Copied from [staffCheckExistence].
class StaffCheckExistenceFamily extends Family<AsyncValue<bool>> {
  /// イベントIDを指定して、ログイン中のユーザーがスタッフかどうかを確認するストリーム
  ///
  /// Copied from [staffCheckExistence].
  const StaffCheckExistenceFamily();

  /// イベントIDを指定して、ログイン中のユーザーがスタッフかどうかを確認するストリーム
  ///
  /// Copied from [staffCheckExistence].
  StaffCheckExistenceProvider call(
    String eventId,
  ) {
    return StaffCheckExistenceProvider(
      eventId,
    );
  }

  @override
  StaffCheckExistenceProvider getProviderOverride(
    covariant StaffCheckExistenceProvider provider,
  ) {
    return call(
      provider.eventId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'staffCheckExistenceProvider';
}

/// イベントIDを指定して、ログイン中のユーザーがスタッフかどうかを確認するストリーム
///
/// Copied from [staffCheckExistence].
class StaffCheckExistenceProvider extends AutoDisposeStreamProvider<bool> {
  /// イベントIDを指定して、ログイン中のユーザーがスタッフかどうかを確認するストリーム
  ///
  /// Copied from [staffCheckExistence].
  StaffCheckExistenceProvider(
    String eventId,
  ) : this._internal(
          (ref) => staffCheckExistence(
            ref as StaffCheckExistenceRef,
            eventId,
          ),
          from: staffCheckExistenceProvider,
          name: r'staffCheckExistenceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$staffCheckExistenceHash,
          dependencies: StaffCheckExistenceFamily._dependencies,
          allTransitiveDependencies:
              StaffCheckExistenceFamily._allTransitiveDependencies,
          eventId: eventId,
        );

  StaffCheckExistenceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventId,
  }) : super.internal();

  final String eventId;

  @override
  Override overrideWith(
    Stream<bool> Function(StaffCheckExistenceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StaffCheckExistenceProvider._internal(
        (ref) => create(ref as StaffCheckExistenceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventId: eventId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<bool> createElement() {
    return _StaffCheckExistenceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StaffCheckExistenceProvider && other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StaffCheckExistenceRef on AutoDisposeStreamProviderRef<bool> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _StaffCheckExistenceProviderElement
    extends AutoDisposeStreamProviderElement<bool> with StaffCheckExistenceRef {
  _StaffCheckExistenceProviderElement(super.provider);

  @override
  String get eventId => (origin as StaffCheckExistenceProvider).eventId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
