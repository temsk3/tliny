// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'sns_messages_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SnsMessagesViewModel)
const snsMessagesViewModelProvider = SnsMessagesViewModelProvider._();

final class SnsMessagesViewModelProvider
    extends $AsyncNotifierProvider<SnsMessagesViewModel, List<Conversation>> {
  const SnsMessagesViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'snsMessagesViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$snsMessagesViewModelHash();

  @$internal
  @override
  SnsMessagesViewModel create() => SnsMessagesViewModel();
}

String _$snsMessagesViewModelHash() =>
    r'af573e88715cd9c1459142922bf49d8705a285e7';

abstract class _$SnsMessagesViewModel
    extends $AsyncNotifier<List<Conversation>> {
  FutureOr<List<Conversation>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<Conversation>>, List<Conversation>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Conversation>>, List<Conversation>>,
              AsyncValue<List<Conversation>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
