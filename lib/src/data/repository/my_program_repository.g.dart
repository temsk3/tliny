// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'my_program_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myProgramRepositoryHash() =>
    r'4e6ccbc6bdb16b3a9dfd1aa8c6066512743d374a';

/// See also [myProgramRepository].
@ProviderFor(myProgramRepository)
final myProgramRepositoryProvider = Provider<MyProgramRepository>.internal(
  myProgramRepository,
  name: r'myProgramRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myProgramRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MyProgramRepositoryRef = ProviderRef<MyProgramRepository>;
String _$myProgramExistsStreamHash() =>
    r'7a24eab920d71080e7ce80ec2b389aed9aec8011';

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

/// See also [myProgramExistsStream].
@ProviderFor(myProgramExistsStream)
const myProgramExistsStreamProvider = MyProgramExistsStreamFamily();

/// See also [myProgramExistsStream].
class MyProgramExistsStreamFamily extends Family<AsyncValue<bool>> {
  /// See also [myProgramExistsStream].
  const MyProgramExistsStreamFamily();

  /// See also [myProgramExistsStream].
  MyProgramExistsStreamProvider call(
    String programId,
  ) {
    return MyProgramExistsStreamProvider(
      programId,
    );
  }

  @override
  MyProgramExistsStreamProvider getProviderOverride(
    covariant MyProgramExistsStreamProvider provider,
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
  String? get name => r'myProgramExistsStreamProvider';
}

/// See also [myProgramExistsStream].
class MyProgramExistsStreamProvider extends AutoDisposeStreamProvider<bool> {
  /// See also [myProgramExistsStream].
  MyProgramExistsStreamProvider(
    String programId,
  ) : this._internal(
          (ref) => myProgramExistsStream(
            ref as MyProgramExistsStreamRef,
            programId,
          ),
          from: myProgramExistsStreamProvider,
          name: r'myProgramExistsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$myProgramExistsStreamHash,
          dependencies: MyProgramExistsStreamFamily._dependencies,
          allTransitiveDependencies:
              MyProgramExistsStreamFamily._allTransitiveDependencies,
          programId: programId,
        );

  MyProgramExistsStreamProvider._internal(
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
    Stream<bool> Function(MyProgramExistsStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MyProgramExistsStreamProvider._internal(
        (ref) => create(ref as MyProgramExistsStreamRef),
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
  AutoDisposeStreamProviderElement<bool> createElement() {
    return _MyProgramExistsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MyProgramExistsStreamProvider &&
        other.programId == programId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, programId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MyProgramExistsStreamRef on AutoDisposeStreamProviderRef<bool> {
  /// The parameter `programId` of this provider.
  String get programId;
}

class _MyProgramExistsStreamProviderElement
    extends AutoDisposeStreamProviderElement<bool>
    with MyProgramExistsStreamRef {
  _MyProgramExistsStreamProviderElement(super.provider);

  @override
  String get programId => (origin as MyProgramExistsStreamProvider).programId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
