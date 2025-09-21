// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'favorite_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(favoriteRepository)
const favoriteRepositoryProvider = FavoriteRepositoryProvider._();

final class FavoriteRepositoryProvider
    extends
        $FunctionalProvider<
          FavoriteRepository,
          FavoriteRepository,
          FavoriteRepository
        >
    with $Provider<FavoriteRepository> {
  const FavoriteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteRepositoryHash();

  @$internal
  @override
  $ProviderElement<FavoriteRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FavoriteRepository create(Ref ref) {
    return favoriteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavoriteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavoriteRepository>(value),
    );
  }
}

String _$favoriteRepositoryHash() =>
    r'8862be4235a49c94fac8bb9a16ea326c190d67cc';

@ProviderFor(favoriteCheckExistence)
const favoriteCheckExistenceProvider = FavoriteCheckExistenceFamily._();

final class FavoriteCheckExistenceProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  const FavoriteCheckExistenceProvider._({
    required FavoriteCheckExistenceFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'favoriteCheckExistenceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$favoriteCheckExistenceHash();

  @override
  String toString() {
    return r'favoriteCheckExistenceProvider'
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
    return favoriteCheckExistence(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FavoriteCheckExistenceProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$favoriteCheckExistenceHash() =>
    r'e4d94062278b3778d7acdba5a1d88d6618a133ee';

final class FavoriteCheckExistenceFamily extends $Family
    with $FunctionalFamilyOverride<Stream<bool>, String> {
  const FavoriteCheckExistenceFamily._()
    : super(
        retry: null,
        name: r'favoriteCheckExistenceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FavoriteCheckExistenceProvider call(String favoriteId) =>
      FavoriteCheckExistenceProvider._(argument: favoriteId, from: this);

  @override
  String toString() => r'favoriteCheckExistenceProvider';
}
