// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'sns_notifications_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SnsNotificationsViewModel)
const snsNotificationsViewModelProvider = SnsNotificationsViewModelProvider._();

final class SnsNotificationsViewModelProvider
    extends
        $AsyncNotifierProvider<
          SnsNotificationsViewModel,
          List<AppNotification>
        > {
  const SnsNotificationsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'snsNotificationsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$snsNotificationsViewModelHash();

  @$internal
  @override
  SnsNotificationsViewModel create() => SnsNotificationsViewModel();
}

String _$snsNotificationsViewModelHash() =>
    r'5ea59a5eeacfdcb7969aead25850798f2513c738';

abstract class _$SnsNotificationsViewModel
    extends $AsyncNotifier<List<AppNotification>> {
  FutureOr<List<AppNotification>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<AppNotification>>, List<AppNotification>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AppNotification>>,
                List<AppNotification>
              >,
              AsyncValue<List<AppNotification>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
