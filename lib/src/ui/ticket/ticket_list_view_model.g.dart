// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'ticket_list_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ticketsStateHash() => r'4f74be3d5b128802db214ba6d6f0dd4db40c0e6a';

/// See also [ticketsState].
@ProviderFor(ticketsState)
final ticketsStateProvider =
    AutoDisposeProvider<AsyncValue<List<Ticket>>>.internal(
      ticketsState,
      name: r'ticketsStateProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$ticketsStateHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TicketsStateRef = AutoDisposeProviderRef<AsyncValue<List<Ticket>>>;
String _$ticketListViewModelHash() =>
    r'9daf73fb81959eefa6621567d7d961f2d377b518';

/// See also [TicketListViewModel].
@ProviderFor(TicketListViewModel)
final ticketListViewModelProvider =
    AsyncNotifierProvider<TicketListViewModel, Set<String>>.internal(
      TicketListViewModel.new,
      name: r'ticketListViewModelProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$ticketListViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TicketListViewModel = AsyncNotifier<Set<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
