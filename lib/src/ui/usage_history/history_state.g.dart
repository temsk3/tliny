// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'history_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(usageHistoryState)
const usageHistoryStateProvider = UsageHistoryStateFamily._();

final class UsageHistoryStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<UsageHistory>,
          UsageHistory,
          Stream<UsageHistory>
        >
    with $FutureModifier<UsageHistory>, $StreamProvider<UsageHistory> {
  const UsageHistoryStateProvider._({
    required UsageHistoryStateFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'usageHistoryStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$usageHistoryStateHash();

  @override
  String toString() {
    return r'usageHistoryStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<UsageHistory> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<UsageHistory> create(Ref ref) {
    final argument = this.argument as String;
    return usageHistoryState(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UsageHistoryStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$usageHistoryStateHash() => r'015815fa49ea6e38ef551263077388f18d1b9632';

final class UsageHistoryStateFamily extends $Family
    with $FunctionalFamilyOverride<Stream<UsageHistory>, String> {
  const UsageHistoryStateFamily._()
    : super(
        retry: null,
        name: r'usageHistoryStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UsageHistoryStateProvider call(String id) =>
      UsageHistoryStateProvider._(argument: id, from: this);

  @override
  String toString() => r'usageHistoryStateProvider';
}

@ProviderFor(ticketStreamState)
const ticketStreamStateProvider = TicketStreamStateFamily._();

final class TicketStreamStateProvider
    extends $FunctionalProvider<AsyncValue<Ticket>, Ticket, Stream<Ticket>>
    with $FutureModifier<Ticket>, $StreamProvider<Ticket> {
  const TicketStreamStateProvider._({
    required TicketStreamStateFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'ticketStreamStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ticketStreamStateHash();

  @override
  String toString() {
    return r'ticketStreamStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Ticket> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Ticket> create(Ref ref) {
    final argument = this.argument as String;
    return ticketStreamState(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TicketStreamStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ticketStreamStateHash() => r'd59317c10143bcb3d5c52a9c7c10e3adea87b465';

final class TicketStreamStateFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Ticket>, String> {
  const TicketStreamStateFamily._()
    : super(
        retry: null,
        name: r'ticketStreamStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TicketStreamStateProvider call(String id) =>
      TicketStreamStateProvider._(argument: id, from: this);

  @override
  String toString() => r'ticketStreamStateProvider';
}
