// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'program_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$programsStateHash() => r'ad3d1dda06125f9a1c29dd99fde2b80e102778bb';

/// See also [programsState].
@ProviderFor(programsState)
final programsStateProvider = AutoDisposeStreamProvider<List<Program>>.internal(
  programsState,
  name: r'programsStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$programsStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProgramsStateRef = AutoDisposeStreamProviderRef<List<Program>>;
String _$programsStateAsyncHash() =>
    r'f35d77d400c7d52bd6e480912ad3de3949b2a1ac';

/// See also [programsStateAsync].
@ProviderFor(programsStateAsync)
final programsStateAsyncProvider =
    AutoDisposeFutureProvider<List<Program>>.internal(
  programsStateAsync,
  name: r'programsStateAsyncProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$programsStateAsyncHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProgramsStateAsyncRef = AutoDisposeFutureProviderRef<List<Program>>;
String _$programStateHash() => r'c6fe483208bfe5fcded5085b735818d2cea3a164';

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

/// See also [programState].
@ProviderFor(programState)
const programStateProvider = ProgramStateFamily();

/// See also [programState].
class ProgramStateFamily extends Family<AsyncValue<Program>> {
  /// See also [programState].
  const ProgramStateFamily();

  /// See also [programState].
  ProgramStateProvider call(
    String? programId,
  ) {
    return ProgramStateProvider(
      programId,
    );
  }

  @override
  ProgramStateProvider getProviderOverride(
    covariant ProgramStateProvider provider,
  ) {
    return call(
      provider.programId,
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
  String? get name => r'programStateProvider';
}

/// See also [programState].
class ProgramStateProvider extends AutoDisposeStreamProvider<Program> {
  /// See also [programState].
  ProgramStateProvider(
    String? programId,
  ) : this._internal(
          (ref) => programState(
            ref as ProgramStateRef,
            programId,
          ),
          from: programStateProvider,
          name: r'programStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$programStateHash,
          dependencies: ProgramStateFamily._dependencies,
          allTransitiveDependencies:
              ProgramStateFamily._allTransitiveDependencies,
          programId: programId,
        );

  ProgramStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.programId,
  }) : super.internal();

  final String? programId;

  @override
  Override overrideWith(
    Stream<Program> Function(ProgramStateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProgramStateProvider._internal(
        (ref) => create(ref as ProgramStateRef),
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
    return _ProgramStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProgramStateProvider && other.programId == programId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, programId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProgramStateRef on AutoDisposeStreamProviderRef<Program> {
  /// The parameter `programId` of this provider.
  String? get programId;
}

class _ProgramStateProviderElement
    extends AutoDisposeStreamProviderElement<Program> with ProgramStateRef {
  _ProgramStateProviderElement(super.provider);

  @override
  String? get programId => (origin as ProgramStateProvider).programId;
}

String _$myProgramListStateHash() =>
    r'39901ee3093ccc77e32af291a9400a595ddc2993';

/// See also [myProgramListState].
@ProviderFor(myProgramListState)
final myProgramListStateProvider =
    AutoDisposeStreamProvider<List<Program>>.internal(
  myProgramListState,
  name: r'myProgramListStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myProgramListStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MyProgramListStateRef = AutoDisposeStreamProviderRef<List<Program>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
