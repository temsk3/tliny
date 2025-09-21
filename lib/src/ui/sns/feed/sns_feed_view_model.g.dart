// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'sns_feed_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SnsFeedViewModel)
const snsFeedViewModelProvider = SnsFeedViewModelProvider._();

final class SnsFeedViewModelProvider
    extends $AsyncNotifierProvider<SnsFeedViewModel, List<Post>> {
  const SnsFeedViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'snsFeedViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$snsFeedViewModelHash();

  @$internal
  @override
  SnsFeedViewModel create() => SnsFeedViewModel();
}

String _$snsFeedViewModelHash() => r'a5b5d920a9e2ce335bf677938e8b3dd45a7d909f';

abstract class _$SnsFeedViewModel extends $AsyncNotifier<List<Post>> {
  FutureOr<List<Post>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Post>>, List<Post>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Post>>, List<Post>>,
              AsyncValue<List<Post>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
