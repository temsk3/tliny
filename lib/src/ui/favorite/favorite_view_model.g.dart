// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'favorite_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavoriteViewModel)
const favoriteViewModelProvider = FavoriteViewModelProvider._();

final class FavoriteViewModelProvider
    extends $AsyncNotifierProvider<FavoriteViewModel, List<Favorite>> {
  const FavoriteViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteViewModelHash();

  @$internal
  @override
  FavoriteViewModel create() => FavoriteViewModel();
}

String _$favoriteViewModelHash() => r'6c924df8c4d38ce4d22f735e7f03d48a7ced7ecd';

abstract class _$FavoriteViewModel extends $AsyncNotifier<List<Favorite>> {
  FutureOr<List<Favorite>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Favorite>>, List<Favorite>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Favorite>>, List<Favorite>>,
              AsyncValue<List<Favorite>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
