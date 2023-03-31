// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'ticket_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ticketsStateHash() => r'30926c5a033903453e6dd5250a3f0175ce04e737';

/// See also [ticketsState].
@ProviderFor(ticketsState)
final ticketsStateProvider = AutoDisposeStreamProvider<List<Ticket>>.internal(
  ticketsState,
  name: r'ticketsStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$ticketsStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TicketsStateRef = AutoDisposeStreamProviderRef<List<Ticket>>;
String _$ticketStateHash() => r'1ad00a51b3596a0c26c444d40f203d2c1d0b859f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef TicketStateRef = AutoDisposeStreamProviderRef<Ticket>;

/// See also [ticketState].
@ProviderFor(ticketState)
const ticketStateProvider = TicketStateFamily();

/// See also [ticketState].
class TicketStateFamily extends Family<AsyncValue<Ticket>> {
  /// See also [ticketState].
  const TicketStateFamily();

  /// See also [ticketState].
  TicketStateProvider call(
    String ticketId,
  ) {
    return TicketStateProvider(
      ticketId,
    );
  }

  @override
  TicketStateProvider getProviderOverride(
    covariant TicketStateProvider provider,
  ) {
    return call(
      provider.ticketId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'ticketStateProvider';
}

/// See also [ticketState].
class TicketStateProvider extends AutoDisposeStreamProvider<Ticket> {
  /// See also [ticketState].
  TicketStateProvider(
    this.ticketId,
  ) : super.internal(
          (ref) => ticketState(
            ref,
            ticketId,
          ),
          from: ticketStateProvider,
          name: r'ticketStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ticketStateHash,
          dependencies: TicketStateFamily._dependencies,
          allTransitiveDependencies:
              TicketStateFamily._allTransitiveDependencies,
        );

  final String ticketId;

  @override
  bool operator ==(Object other) {
    return other is TicketStateProvider && other.ticketId == ticketId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ticketId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
