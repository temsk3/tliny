// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'favorite_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoriteRepositoryHash() =>
    r'8862be4235a49c94fac8bb9a16ea326c190d67cc';

/// See also [favoriteRepository].
@ProviderFor(favoriteRepository)
final favoriteRepositoryProvider = Provider<FavoriteRepository>.internal(
  favoriteRepository,
  name: r'favoriteRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$favoriteRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FavoriteRepositoryRef = ProviderRef<FavoriteRepository>;
String _$favoriteCheckExistenceHash() =>
    r'e4d94062278b3778d7acdba5a1d88d6618a133ee';

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

/// See also [favoriteCheckExistence].
@ProviderFor(favoriteCheckExistence)
const favoriteCheckExistenceProvider = FavoriteCheckExistenceFamily();

/// See also [favoriteCheckExistence].
class FavoriteCheckExistenceFamily extends Family<AsyncValue<bool>> {
  /// See also [favoriteCheckExistence].
  const FavoriteCheckExistenceFamily();

  /// See also [favoriteCheckExistence].
  FavoriteCheckExistenceProvider call(String favoriteId) {
    return FavoriteCheckExistenceProvider(favoriteId);
  }

  @override
  FavoriteCheckExistenceProvider getProviderOverride(
    covariant FavoriteCheckExistenceProvider provider,
  ) {
    return call(provider.favoriteId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'favoriteCheckExistenceProvider';
}

/// See also [favoriteCheckExistence].
class FavoriteCheckExistenceProvider extends AutoDisposeStreamProvider<bool> {
  /// See also [favoriteCheckExistence].
  FavoriteCheckExistenceProvider(String favoriteId)
    : this._internal(
        (ref) => favoriteCheckExistence(
          ref as FavoriteCheckExistenceRef,
          favoriteId,
        ),
        from: favoriteCheckExistenceProvider,
        name: r'favoriteCheckExistenceProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$favoriteCheckExistenceHash,
        dependencies: FavoriteCheckExistenceFamily._dependencies,
        allTransitiveDependencies:
            FavoriteCheckExistenceFamily._allTransitiveDependencies,
        favoriteId: favoriteId,
      );

  FavoriteCheckExistenceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.favoriteId,
  }) : super.internal();

  final String favoriteId;

  @override
  Override overrideWith(
    Stream<bool> Function(FavoriteCheckExistenceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FavoriteCheckExistenceProvider._internal(
        (ref) => create(ref as FavoriteCheckExistenceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        favoriteId: favoriteId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<bool> createElement() {
    return _FavoriteCheckExistenceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FavoriteCheckExistenceProvider &&
        other.favoriteId == favoriteId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, favoriteId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FavoriteCheckExistenceRef on AutoDisposeStreamProviderRef<bool> {
  /// The parameter `favoriteId` of this provider.
  String get favoriteId;
}

class _FavoriteCheckExistenceProviderElement
    extends AutoDisposeStreamProviderElement<bool>
    with FavoriteCheckExistenceRef {
  _FavoriteCheckExistenceProviderElement(super.provider);

  @override
  String get favoriteId =>
      (origin as FavoriteCheckExistenceProvider).favoriteId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
