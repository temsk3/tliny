// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'ticket_list_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ticketsState)
const ticketsStateProvider = TicketsStateProvider._();

final class TicketsStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Ticket>>,
          AsyncValue<List<Ticket>>,
          AsyncValue<List<Ticket>>
        >
    with $Provider<AsyncValue<List<Ticket>>> {
  const TicketsStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ticketsStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ticketsStateHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<List<Ticket>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<List<Ticket>> create(Ref ref) {
    return ticketsState(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<Ticket>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<Ticket>>>(value),
    );
  }
}

String _$ticketsStateHash() => r'a8c538971fcbc5dd266443d03ff4902ec7570163';

@ProviderFor(TicketListViewModel)
const ticketListViewModelProvider = TicketListViewModelProvider._();

final class TicketListViewModelProvider
    extends $AsyncNotifierProvider<TicketListViewModel, Set<String>> {
  const TicketListViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ticketListViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ticketListViewModelHash();

  @$internal
  @override
  TicketListViewModel create() => TicketListViewModel();
}

String _$ticketListViewModelHash() =>
    r'742d624f67b10473d7d3c5217996cf2748bf2959';

abstract class _$TicketListViewModel extends $AsyncNotifier<Set<String>> {
  FutureOr<Set<String>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Set<String>>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Set<String>>, Set<String>>,
              AsyncValue<Set<String>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
