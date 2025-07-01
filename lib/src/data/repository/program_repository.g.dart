// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'program_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$programRepositoryHash() => r'50d01370ee4b4eedac548501d03dff7d9d8a8975';

/// See also [programRepository].
@ProviderFor(programRepository)
final programRepositoryProvider = Provider<ProgramRepository>.internal(
  programRepository,
  name: r'programRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$programRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProgramRepositoryRef = ProviderRef<ProgramRepository>;
String _$programsStreamHash() => r'9b5ccb4a0654d7a29f795136fb4648d38a21ad61';

/// See also [programsStream].
@ProviderFor(programsStream)
final programsStreamProvider =
    AutoDisposeStreamProvider<List<Program>>.internal(
      programsStream,
      name: r'programsStreamProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$programsStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProgramsStreamRef = AutoDisposeStreamProviderRef<List<Program>>;
String _$programStreamHash() => r'bc5242811f6cdd9baac018abd2efd14163fb9a61';

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

/// See also [programStream].
@ProviderFor(programStream)
const programStreamProvider = ProgramStreamFamily();

/// See also [programStream].
class ProgramStreamFamily extends Family<AsyncValue<Program>> {
  /// See also [programStream].
  const ProgramStreamFamily();

  /// See also [programStream].
  ProgramStreamProvider call(String programId) {
    return ProgramStreamProvider(programId);
  }

  @override
  ProgramStreamProvider getProviderOverride(
    covariant ProgramStreamProvider provider,
  ) {
    return call(provider.programId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'programStreamProvider';
}

/// See also [programStream].
class ProgramStreamProvider extends AutoDisposeStreamProvider<Program> {
  /// See also [programStream].
  ProgramStreamProvider(String programId)
    : this._internal(
        (ref) => programStream(ref as ProgramStreamRef, programId),
        from: programStreamProvider,
        name: r'programStreamProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$programStreamHash,
        dependencies: ProgramStreamFamily._dependencies,
        allTransitiveDependencies:
            ProgramStreamFamily._allTransitiveDependencies,
        programId: programId,
      );

  ProgramStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.programId,
  }) : super.internal();

  final String programId;

  @override
  Override overrideWith(
    Stream<Program> Function(ProgramStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProgramStreamProvider._internal(
        (ref) => create(ref as ProgramStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        programId: programId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Program> createElement() {
    return _ProgramStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProgramStreamProvider && other.programId == programId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, programId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProgramStreamRef on AutoDisposeStreamProviderRef<Program> {
  /// The parameter `programId` of this provider.
  String get programId;
}

class _ProgramStreamProviderElement
    extends AutoDisposeStreamProviderElement<Program>
    with ProgramStreamRef {
  _ProgramStreamProviderElement(super.provider);

  @override
  String get programId => (origin as ProgramStreamProvider).programId;
}

String _$programFutureHash() => r'e270c5f833c5ab1fa7c4cb2a63b5c5bd0184e76a';

/// See also [programFuture].
@ProviderFor(programFuture)
const programFutureProvider = ProgramFutureFamily();

/// See also [programFuture].
class ProgramFutureFamily extends Family<AsyncValue<Program?>> {
  /// See also [programFuture].
  const ProgramFutureFamily();

  /// See also [programFuture].
  ProgramFutureProvider call(String programId) {
    return ProgramFutureProvider(programId);
  }

  @override
  ProgramFutureProvider getProviderOverride(
    covariant ProgramFutureProvider provider,
  ) {
    return call(provider.programId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'programFutureProvider';
}

/// See also [programFuture].
class ProgramFutureProvider extends AutoDisposeFutureProvider<Program?> {
  /// See also [programFuture].
  ProgramFutureProvider(String programId)
    : this._internal(
        (ref) => programFuture(ref as ProgramFutureRef, programId),
        from: programFutureProvider,
        name: r'programFutureProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$programFutureHash,
        dependencies: ProgramFutureFamily._dependencies,
        allTransitiveDependencies:
            ProgramFutureFamily._allTransitiveDependencies,
        programId: programId,
      );

  ProgramFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.programId,
  }) : super.internal();

  final String programId;

  @override
  Override overrideWith(
    FutureOr<Program?> Function(ProgramFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProgramFutureProvider._internal(
        (ref) => create(ref as ProgramFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        programId: programId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Program?> createElement() {
    return _ProgramFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProgramFutureProvider && other.programId == programId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, programId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProgramFutureRef on AutoDisposeFutureProviderRef<Program?> {
  /// The parameter `programId` of this provider.
  String get programId;
}

class _ProgramFutureProviderElement
    extends AutoDisposeFutureProviderElement<Program?>
    with ProgramFutureRef {
  _ProgramFutureProviderElement(super.provider);

  @override
  String get programId => (origin as ProgramFutureProvider).programId;
}

String _$programsByOrganizerStreamHash() =>
    r'45d4df871321e7ced10ebd80ce9d3853a3e55026';

/// See also [programsByOrganizerStream].
@ProviderFor(programsByOrganizerStream)
const programsByOrganizerStreamProvider = ProgramsByOrganizerStreamFamily();

/// See also [programsByOrganizerStream].
class ProgramsByOrganizerStreamFamily
    extends Family<AsyncValue<List<Program>>> {
  /// See also [programsByOrganizerStream].
  const ProgramsByOrganizerStreamFamily();

  /// See also [programsByOrganizerStream].
  ProgramsByOrganizerStreamProvider call(String organizerId) {
    return ProgramsByOrganizerStreamProvider(organizerId);
  }

  @override
  ProgramsByOrganizerStreamProvider getProviderOverride(
    covariant ProgramsByOrganizerStreamProvider provider,
  ) {
    return call(provider.organizerId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'programsByOrganizerStreamProvider';
}

/// See also [programsByOrganizerStream].
class ProgramsByOrganizerStreamProvider
    extends AutoDisposeStreamProvider<List<Program>> {
  /// See also [programsByOrganizerStream].
  ProgramsByOrganizerStreamProvider(String organizerId)
    : this._internal(
        (ref) => programsByOrganizerStream(
          ref as ProgramsByOrganizerStreamRef,
          organizerId,
        ),
        from: programsByOrganizerStreamProvider,
        name: r'programsByOrganizerStreamProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$programsByOrganizerStreamHash,
        dependencies: ProgramsByOrganizerStreamFamily._dependencies,
        allTransitiveDependencies:
            ProgramsByOrganizerStreamFamily._allTransitiveDependencies,
        organizerId: organizerId,
      );

  ProgramsByOrganizerStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.organizerId,
  }) : super.internal();

  final String organizerId;

  @override
  Override overrideWith(
    Stream<List<Program>> Function(ProgramsByOrganizerStreamRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProgramsByOrganizerStreamProvider._internal(
        (ref) => create(ref as ProgramsByOrganizerStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        organizerId: organizerId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Program>> createElement() {
    return _ProgramsByOrganizerStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProgramsByOrganizerStreamProvider &&
        other.organizerId == organizerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, organizerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProgramsByOrganizerStreamRef
    on AutoDisposeStreamProviderRef<List<Program>> {
  /// The parameter `organizerId` of this provider.
  String get organizerId;
}

class _ProgramsByOrganizerStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<Program>>
    with ProgramsByOrganizerStreamRef {
  _ProgramsByOrganizerStreamProviderElement(super.provider);

  @override
  String get organizerId =>
      (origin as ProgramsByOrganizerStreamProvider).organizerId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
