// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'history_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UsageHistoryViewModel)
const usageHistoryViewModelProvider = UsageHistoryViewModelProvider._();

final class UsageHistoryViewModelProvider
    extends $AsyncNotifierProvider<UsageHistoryViewModel, List<UsageHistory>> {
  const UsageHistoryViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'usageHistoryViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$usageHistoryViewModelHash();

  @$internal
  @override
  UsageHistoryViewModel create() => UsageHistoryViewModel();
}

String _$usageHistoryViewModelHash() =>
    r'8b782f79864d7170a75c7f63792403ea2d950008';

abstract class _$UsageHistoryViewModel
    extends $AsyncNotifier<List<UsageHistory>> {
  FutureOr<List<UsageHistory>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<UsageHistory>>, List<UsageHistory>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<UsageHistory>>, List<UsageHistory>>,
              AsyncValue<List<UsageHistory>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
