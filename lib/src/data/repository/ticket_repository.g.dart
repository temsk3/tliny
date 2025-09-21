// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'ticket_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ticketRepository)
const ticketRepositoryProvider = TicketRepositoryProvider._();

final class TicketRepositoryProvider
    extends
        $FunctionalProvider<
          TicketRepository,
          TicketRepository,
          TicketRepository
        >
    with $Provider<TicketRepository> {
  const TicketRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ticketRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ticketRepositoryHash();

  @$internal
  @override
  $ProviderElement<TicketRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TicketRepository create(Ref ref) {
    return ticketRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TicketRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TicketRepository>(value),
    );
  }
}

String _$ticketRepositoryHash() => r'e69d8f9efb6fbb3f6efdc35edf45a6100348a945';

@ProviderFor(allTicketStream)
const allTicketStreamProvider = AllTicketStreamProvider._();

final class AllTicketStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Ticket>>,
          List<Ticket>,
          Stream<List<Ticket>>
        >
    with $FutureModifier<List<Ticket>>, $StreamProvider<List<Ticket>> {
  const AllTicketStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allTicketStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allTicketStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<Ticket>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Ticket>> create(Ref ref) {
    return allTicketStream(ref);
  }
}

String _$allTicketStreamHash() => r'6cd33a8e6239bd79380a2a6075d4380241f46a46';

@ProviderFor(ticketsStream)
const ticketsStreamProvider = TicketsStreamFamily._();

final class TicketsStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Ticket>>,
          List<Ticket>,
          Stream<List<Ticket>>
        >
    with $FutureModifier<List<Ticket>>, $StreamProvider<List<Ticket>> {
  const TicketsStreamProvider._({
    required TicketsStreamFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'ticketsStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ticketsStreamHash();

  @override
  String toString() {
    return r'ticketsStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Ticket>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Ticket>> create(Ref ref) {
    final argument = this.argument as String;
    return ticketsStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TicketsStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ticketsStreamHash() => r'320c7a59f4e104495f5847f887f88581c4067596';

final class TicketsStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Ticket>>, String> {
  const TicketsStreamFamily._()
    : super(
        retry: null,
        name: r'ticketsStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TicketsStreamProvider call(String uid) =>
      TicketsStreamProvider._(argument: uid, from: this);

  @override
  String toString() => r'ticketsStreamProvider';
}

@ProviderFor(ticketStream)
const ticketStreamProvider = TicketStreamFamily._();

final class TicketStreamProvider
    extends $FunctionalProvider<AsyncValue<Ticket>, Ticket, Stream<Ticket>>
    with $FutureModifier<Ticket>, $StreamProvider<Ticket> {
  const TicketStreamProvider._({
    required TicketStreamFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'ticketStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ticketStreamHash();

  @override
  String toString() {
    return r'ticketStreamProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<Ticket> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Ticket> create(Ref ref) {
    final argument = this.argument as (String, String);
    return ticketStream(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is TicketStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ticketStreamHash() => r'14bf168141c8144533d728108ab52ff73815cf22';

final class TicketStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Ticket>, (String, String)> {
  const TicketStreamFamily._()
    : super(
        retry: null,
        name: r'ticketStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TicketStreamProvider call(String uid, String ticketId) =>
      TicketStreamProvider._(argument: (uid, ticketId), from: this);

  @override
  String toString() => r'ticketStreamProvider';
}

@ProviderFor(usageHistoryRepository)
const usageHistoryRepositoryProvider = UsageHistoryRepositoryProvider._();

final class UsageHistoryRepositoryProvider
    extends
        $FunctionalProvider<
          UsageHistoryRepository,
          UsageHistoryRepository,
          UsageHistoryRepository
        >
    with $Provider<UsageHistoryRepository> {
  const UsageHistoryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'usageHistoryRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$usageHistoryRepositoryHash();

  @$internal
  @override
  $ProviderElement<UsageHistoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UsageHistoryRepository create(Ref ref) {
    return usageHistoryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UsageHistoryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UsageHistoryRepository>(value),
    );
  }
}

String _$usageHistoryRepositoryHash() =>
    r'f2f1dccbfd3e1a688511c0b9788cabce16a37a6b';

@ProviderFor(usageHistoryListStream)
const usageHistoryListStreamProvider = UsageHistoryListStreamFamily._();

final class UsageHistoryListStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UsageHistory>>,
          List<UsageHistory>,
          Stream<List<UsageHistory>>
        >
    with
        $FutureModifier<List<UsageHistory>>,
        $StreamProvider<List<UsageHistory>> {
  const UsageHistoryListStreamProvider._({
    required UsageHistoryListStreamFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'usageHistoryListStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$usageHistoryListStreamHash();

  @override
  String toString() {
    return r'usageHistoryListStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<UsageHistory>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<UsageHistory>> create(Ref ref) {
    final argument = this.argument as String;
    return usageHistoryListStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UsageHistoryListStreamProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$usageHistoryListStreamHash() =>
    r'bf5da019fb6055c7b32b06d5945120b68bd17d3b';

final class UsageHistoryListStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<UsageHistory>>, String> {
  const UsageHistoryListStreamFamily._()
    : super(
        retry: null,
        name: r'usageHistoryListStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UsageHistoryListStreamProvider call(String uid) =>
      UsageHistoryListStreamProvider._(argument: uid, from: this);

  @override
  String toString() => r'usageHistoryListStreamProvider';
}

@ProviderFor(usageHistoryStream)
const usageHistoryStreamProvider = UsageHistoryStreamFamily._();

final class UsageHistoryStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<UsageHistory>,
          UsageHistory,
          Stream<UsageHistory>
        >
    with $FutureModifier<UsageHistory>, $StreamProvider<UsageHistory> {
  const UsageHistoryStreamProvider._({
    required UsageHistoryStreamFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'usageHistoryStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$usageHistoryStreamHash();

  @override
  String toString() {
    return r'usageHistoryStreamProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<UsageHistory> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<UsageHistory> create(Ref ref) {
    final argument = this.argument as (String, String);
    return usageHistoryStream(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is UsageHistoryStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$usageHistoryStreamHash() =>
    r'c2a7744b605ff8fc998a37f24a78b6d552cc890c';

final class UsageHistoryStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<UsageHistory>, (String, String)> {
  const UsageHistoryStreamFamily._()
    : super(
        retry: null,
        name: r'usageHistoryStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UsageHistoryStreamProvider call(String uid, String id) =>
      UsageHistoryStreamProvider._(argument: (uid, id), from: this);

  @override
  String toString() => r'usageHistoryStreamProvider';
}
