// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'user_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userRepositoryHash() => r'7b838d76413a4ed7caa642e36081918247857705';

/// See also [userRepository].
@ProviderFor(userRepository)
final userRepositoryProvider = Provider<UserRepository>.internal(
  userRepository,
  name: r'userRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRepositoryRef = ProviderRef<UserRepository>;
String _$userStreamHash() => r'2cf4b17d65e881eb21b099203c985d8c3e341b81';

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

/// See also [userStream].
@ProviderFor(userStream)
const userStreamProvider = UserStreamFamily();

/// See also [userStream].
class UserStreamFamily extends Family<AsyncValue<User>> {
  /// See also [userStream].
  const UserStreamFamily();

  /// See also [userStream].
  UserStreamProvider call(
    String uid,
  ) {
    return UserStreamProvider(
      uid,
    );
  }

  @override
  UserStreamProvider getProviderOverride(
    covariant UserStreamProvider provider,
  ) {
    return call(
      provider.uid,
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
  String? get name => r'userStreamProvider';
}

/// See also [userStream].
class UserStreamProvider extends AutoDisposeStreamProvider<User> {
  /// See also [userStream].
  UserStreamProvider(
    String uid,
  ) : this._internal(
          (ref) => userStream(
            ref as UserStreamRef,
            uid,
          ),
          from: userStreamProvider,
          name: r'userStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userStreamHash,
          dependencies: UserStreamFamily._dependencies,
          allTransitiveDependencies:
              UserStreamFamily._allTransitiveDependencies,
          uid: uid,
        );

  UserStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    Stream<User> Function(UserStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserStreamProvider._internal(
        (ref) => create(ref as UserStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<User> createElement() {
    return _UserStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserStreamProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserStreamRef on AutoDisposeStreamProviderRef<User> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _UserStreamProviderElement extends AutoDisposeStreamProviderElement<User>
    with UserStreamRef {
  _UserStreamProviderElement(super.provider);

  @override
  String get uid => (origin as UserStreamProvider).uid;
}

String _$publicUserRepositoryHash() =>
    r'506faab5f233a028a1d40fb4e2141c6b34535da3';

/// See also [publicUserRepository].
@ProviderFor(publicUserRepository)
final publicUserRepositoryProvider = Provider<PublicUserRepository>.internal(
  publicUserRepository,
  name: r'publicUserRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$publicUserRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PublicUserRepositoryRef = ProviderRef<PublicUserRepository>;
String _$publicUserStreamHash() => r'a4bebdc2b6382db7796a963ed4541007fe8aa8db';

/// See also [publicUserStream].
@ProviderFor(publicUserStream)
const publicUserStreamProvider = PublicUserStreamFamily();

/// See also [publicUserStream].
class PublicUserStreamFamily extends Family<AsyncValue<PublicUsers>> {
  /// See also [publicUserStream].
  const PublicUserStreamFamily();

  /// See also [publicUserStream].
  PublicUserStreamProvider call(
    String uid,
  ) {
    return PublicUserStreamProvider(
      uid,
    );
  }

  @override
  PublicUserStreamProvider getProviderOverride(
    covariant PublicUserStreamProvider provider,
  ) {
    return call(
      provider.uid,
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
  String? get name => r'publicUserStreamProvider';
}

/// See also [publicUserStream].
class PublicUserStreamProvider extends AutoDisposeStreamProvider<PublicUsers> {
  /// See also [publicUserStream].
  PublicUserStreamProvider(
    String uid,
  ) : this._internal(
          (ref) => publicUserStream(
            ref as PublicUserStreamRef,
            uid,
          ),
          from: publicUserStreamProvider,
          name: r'publicUserStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$publicUserStreamHash,
          dependencies: PublicUserStreamFamily._dependencies,
          allTransitiveDependencies:
              PublicUserStreamFamily._allTransitiveDependencies,
          uid: uid,
        );

  PublicUserStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    Stream<PublicUsers> Function(PublicUserStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PublicUserStreamProvider._internal(
        (ref) => create(ref as PublicUserStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<PublicUsers> createElement() {
    return _PublicUserStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PublicUserStreamProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PublicUserStreamRef on AutoDisposeStreamProviderRef<PublicUsers> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _PublicUserStreamProviderElement
    extends AutoDisposeStreamProviderElement<PublicUsers>
    with PublicUserStreamRef {
  _PublicUserStreamProviderElement(super.provider);

  @override
  String get uid => (origin as PublicUserStreamProvider).uid;
}

String _$publicUserFutureHash() => r'9138b3dce22b8a26edb47af9b5f0937e77d51623';

/// See also [publicUserFuture].
@ProviderFor(publicUserFuture)
const publicUserFutureProvider = PublicUserFutureFamily();

/// See also [publicUserFuture].
class PublicUserFutureFamily extends Family<AsyncValue<PublicUsers>> {
  /// See also [publicUserFuture].
  const PublicUserFutureFamily();

  /// See also [publicUserFuture].
  PublicUserFutureProvider call(
    String uid,
  ) {
    return PublicUserFutureProvider(
      uid,
    );
  }

  @override
  PublicUserFutureProvider getProviderOverride(
    covariant PublicUserFutureProvider provider,
  ) {
    return call(
      provider.uid,
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
  String? get name => r'publicUserFutureProvider';
}

/// See also [publicUserFuture].
class PublicUserFutureProvider extends AutoDisposeFutureProvider<PublicUsers> {
  /// See also [publicUserFuture].
  PublicUserFutureProvider(
    String uid,
  ) : this._internal(
          (ref) => publicUserFuture(
            ref as PublicUserFutureRef,
            uid,
          ),
          from: publicUserFutureProvider,
          name: r'publicUserFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$publicUserFutureHash,
          dependencies: PublicUserFutureFamily._dependencies,
          allTransitiveDependencies:
              PublicUserFutureFamily._allTransitiveDependencies,
          uid: uid,
        );

  PublicUserFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    FutureOr<PublicUsers> Function(PublicUserFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PublicUserFutureProvider._internal(
        (ref) => create(ref as PublicUserFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<PublicUsers> createElement() {
    return _PublicUserFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PublicUserFutureProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PublicUserFutureRef on AutoDisposeFutureProviderRef<PublicUsers> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _PublicUserFutureProviderElement
    extends AutoDisposeFutureProviderElement<PublicUsers>
    with PublicUserFutureRef {
  _PublicUserFutureProviderElement(super.provider);

  @override
  String get uid => (origin as PublicUserFutureProvider).uid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
