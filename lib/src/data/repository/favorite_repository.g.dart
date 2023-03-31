// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'favorite_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoriteRepositoryHash() =>
    r'88da7e1a51b44a2808044321305391122a3e18c2';

/// See also [favoriteRepository].
@ProviderFor(favoriteRepository)
final favoriteRepositoryProvider = Provider<FavoriteRepository>.internal(
  favoriteRepository,
  name: r'favoriteRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoriteRepositoryRef = ProviderRef<FavoriteRepository>;
String _$favoriteCheckExistenceHash() =>
    r'142aa67ab21570acf012cc71bea0e66fa481d586';

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

typedef FavoriteCheckExistenceRef = AutoDisposeStreamProviderRef<bool>;

/// See also [favoriteCheckExistence].
@ProviderFor(favoriteCheckExistence)
const favoriteCheckExistenceProvider = FavoriteCheckExistenceFamily();

/// See also [favoriteCheckExistence].
class FavoriteCheckExistenceFamily extends Family<AsyncValue<bool>> {
  /// See also [favoriteCheckExistence].
  const FavoriteCheckExistenceFamily();

  /// See also [favoriteCheckExistence].
  FavoriteCheckExistenceProvider call(
    String favoriteId,
  ) {
    return FavoriteCheckExistenceProvider(
      favoriteId,
    );
  }

  @override
  FavoriteCheckExistenceProvider getProviderOverride(
    covariant FavoriteCheckExistenceProvider provider,
  ) {
    return call(
      provider.favoriteId,
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
  String? get name => r'favoriteCheckExistenceProvider';
}

/// See also [favoriteCheckExistence].
class FavoriteCheckExistenceProvider extends AutoDisposeStreamProvider<bool> {
  /// See also [favoriteCheckExistence].
  FavoriteCheckExistenceProvider(
    this.favoriteId,
  ) : super.internal(
          (ref) => favoriteCheckExistence(
            ref,
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
        );

  final String favoriteId;

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
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
