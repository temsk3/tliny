// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'ticket_list_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ticketsStateHash() => r'a8c538971fcbc5dd266443d03ff4902ec7570163';

/// See also [ticketsState].
@ProviderFor(ticketsState)
final ticketsStateProvider =
    AutoDisposeProvider<AsyncValue<List<Ticket>>>.internal(
  ticketsState,
  name: r'ticketsStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$ticketsStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TicketsStateRef = AutoDisposeProviderRef<AsyncValue<List<Ticket>>>;
String _$ticketListViewModelHash() =>
    r'742d624f67b10473d7d3c5217996cf2748bf2959';

/// See also [TicketListViewModel].
@ProviderFor(TicketListViewModel)
final ticketListViewModelProvider =
    AsyncNotifierProvider<TicketListViewModel, Set<String>>.internal(
  TicketListViewModel.new,
  name: r'ticketListViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ticketListViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TicketListViewModel = AsyncNotifier<Set<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
