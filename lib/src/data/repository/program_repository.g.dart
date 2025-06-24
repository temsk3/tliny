// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'program_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$programRepositoryHash() => r'a3d2bc5e7b2fa173f2a462be8c64098874e773ce';

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
String _$programsStreamHash() => r'158ced26dfd616ee4376f65228152f3afcc36d15';

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
String _$programStreamHash() => r'24cd8ca012c555115a64c0e0dcd64bab989be998';

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

String _$programFutureHash() => r'6e2441fda868a92c04790bdafbca522373c3c912';

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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
