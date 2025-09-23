// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'sns_chat_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SnsChatViewModel)
const snsChatViewModelProvider = SnsChatViewModelFamily._();

final class SnsChatViewModelProvider
    extends $AsyncNotifierProvider<SnsChatViewModel, List<DirectMessage>> {
  const SnsChatViewModelProvider._({
    required SnsChatViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'snsChatViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$snsChatViewModelHash();

  @override
  String toString() {
    return r'snsChatViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SnsChatViewModel create() => SnsChatViewModel();

  @override
  bool operator ==(Object other) {
    return other is SnsChatViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$snsChatViewModelHash() => r'66b8a415cf7da8e7a23929b37f953d072a6d2201';

final class SnsChatViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          SnsChatViewModel,
          AsyncValue<List<DirectMessage>>,
          List<DirectMessage>,
          FutureOr<List<DirectMessage>>,
          String
        > {
  const SnsChatViewModelFamily._()
    : super(
        retry: null,
        name: r'snsChatViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SnsChatViewModelProvider call(String conversationId) =>
      SnsChatViewModelProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'snsChatViewModelProvider';
}

abstract class _$SnsChatViewModel extends $AsyncNotifier<List<DirectMessage>> {
  late final _$args = ref.$arg as String;
  String get conversationId => _$args;

  FutureOr<List<DirectMessage>> build(String conversationId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<List<DirectMessage>>, List<DirectMessage>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<DirectMessage>>, List<DirectMessage>>,
              AsyncValue<List<DirectMessage>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
