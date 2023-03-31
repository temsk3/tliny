// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'ticket_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ticketRepositoryHash() => r'8dd774418356faa9d951898d142bb857ceb8061b';

/// See also [ticketRepository].
@ProviderFor(ticketRepository)
final ticketRepositoryProvider = Provider<TicketRepository>.internal(
  ticketRepository,
  name: r'ticketRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ticketRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TicketRepositoryRef = ProviderRef<TicketRepository>;
String _$ticketsStreamHash() => r'725c0ac66a91dae1745c7b0b52c02a3299cd16ea';

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

typedef TicketsStreamRef = AutoDisposeStreamProviderRef<List<Ticket>>;

/// See also [ticketsStream].
@ProviderFor(ticketsStream)
const ticketsStreamProvider = TicketsStreamFamily();

/// See also [ticketsStream].
class TicketsStreamFamily extends Family<AsyncValue<List<Ticket>>> {
  /// See also [ticketsStream].
  const TicketsStreamFamily();

  /// See also [ticketsStream].
  TicketsStreamProvider call(
    String uid,
  ) {
    return TicketsStreamProvider(
      uid,
    );
  }

  @override
  TicketsStreamProvider getProviderOverride(
    covariant TicketsStreamProvider provider,
  ) {
    return call(
      provider.uid,
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
  String? get name => r'ticketsStreamProvider';
}

/// See also [ticketsStream].
class TicketsStreamProvider extends AutoDisposeStreamProvider<List<Ticket>> {
  /// See also [ticketsStream].
  TicketsStreamProvider(
    this.uid,
  ) : super.internal(
          (ref) => ticketsStream(
            ref,
            uid,
          ),
          from: ticketsStreamProvider,
          name: r'ticketsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ticketsStreamHash,
          dependencies: TicketsStreamFamily._dependencies,
          allTransitiveDependencies:
              TicketsStreamFamily._allTransitiveDependencies,
        );

  final String uid;

  @override
  bool operator ==(Object other) {
    return other is TicketsStreamProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$ticketStreamHash() => r'bd754237401cc7606a44ae02001641dc1aaa1136';
typedef TicketStreamRef = AutoDisposeStreamProviderRef<Ticket>;

/// See also [ticketStream].
@ProviderFor(ticketStream)
const ticketStreamProvider = TicketStreamFamily();

/// See also [ticketStream].
class TicketStreamFamily extends Family<AsyncValue<Ticket>> {
  /// See also [ticketStream].
  const TicketStreamFamily();

  /// See also [ticketStream].
  TicketStreamProvider call(
    String uid,
    String ticketId,
  ) {
    return TicketStreamProvider(
      uid,
      ticketId,
    );
  }

  @override
  TicketStreamProvider getProviderOverride(
    covariant TicketStreamProvider provider,
  ) {
    return call(
      provider.uid,
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
  String? get name => r'ticketStreamProvider';
}

/// See also [ticketStream].
class TicketStreamProvider extends AutoDisposeStreamProvider<Ticket> {
  /// See also [ticketStream].
  TicketStreamProvider(
    this.uid,
    this.ticketId,
  ) : super.internal(
          (ref) => ticketStream(
            ref,
            uid,
            ticketId,
          ),
          from: ticketStreamProvider,
          name: r'ticketStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ticketStreamHash,
          dependencies: TicketStreamFamily._dependencies,
          allTransitiveDependencies:
              TicketStreamFamily._allTransitiveDependencies,
        );

  final String uid;
  final String ticketId;

  @override
  bool operator ==(Object other) {
    return other is TicketStreamProvider &&
        other.uid == uid &&
        other.ticketId == ticketId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);
    hash = _SystemHash.combine(hash, ticketId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$usageHistoryRepositoryHash() =>
    r'e800b1891c1bad3235592aac8aaf993f334afa94';

/// See also [usageHistoryRepository].
@ProviderFor(usageHistoryRepository)
final usageHistoryRepositoryProvider =
    Provider<UsageHistoryRepository>.internal(
  usageHistoryRepository,
  name: r'usageHistoryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$usageHistoryRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UsageHistoryRepositoryRef = ProviderRef<UsageHistoryRepository>;
String _$usageHistoryListStreamHash() =>
    r'5ab80dab4dc776539af5b96093ae5685b40fd4b4';
typedef UsageHistoryListStreamRef
    = AutoDisposeStreamProviderRef<List<UsageHistory>>;

/// See also [usageHistoryListStream].
@ProviderFor(usageHistoryListStream)
const usageHistoryListStreamProvider = UsageHistoryListStreamFamily();

/// See also [usageHistoryListStream].
class UsageHistoryListStreamFamily
    extends Family<AsyncValue<List<UsageHistory>>> {
  /// See also [usageHistoryListStream].
  const UsageHistoryListStreamFamily();

  /// See also [usageHistoryListStream].
  UsageHistoryListStreamProvider call(
    String uid,
  ) {
    return UsageHistoryListStreamProvider(
      uid,
    );
  }

  @override
  UsageHistoryListStreamProvider getProviderOverride(
    covariant UsageHistoryListStreamProvider provider,
  ) {
    return call(
      provider.uid,
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
  String? get name => r'usageHistoryListStreamProvider';
}

/// See also [usageHistoryListStream].
class UsageHistoryListStreamProvider
    extends AutoDisposeStreamProvider<List<UsageHistory>> {
  /// See also [usageHistoryListStream].
  UsageHistoryListStreamProvider(
    this.uid,
  ) : super.internal(
          (ref) => usageHistoryListStream(
            ref,
            uid,
          ),
          from: usageHistoryListStreamProvider,
          name: r'usageHistoryListStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$usageHistoryListStreamHash,
          dependencies: UsageHistoryListStreamFamily._dependencies,
          allTransitiveDependencies:
              UsageHistoryListStreamFamily._allTransitiveDependencies,
        );

  final String uid;

  @override
  bool operator ==(Object other) {
    return other is UsageHistoryListStreamProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$usageHistoryStreamHash() =>
    r'fc9fd76ade0eec25e87821c4512d2d7b6c300ba8';
typedef UsageHistoryStreamRef = AutoDisposeStreamProviderRef<UsageHistory>;

/// See also [usageHistoryStream].
@ProviderFor(usageHistoryStream)
const usageHistoryStreamProvider = UsageHistoryStreamFamily();

/// See also [usageHistoryStream].
class UsageHistoryStreamFamily extends Family<AsyncValue<UsageHistory>> {
  /// See also [usageHistoryStream].
  const UsageHistoryStreamFamily();

  /// See also [usageHistoryStream].
  UsageHistoryStreamProvider call(
    String uid,
    String id,
  ) {
    return UsageHistoryStreamProvider(
      uid,
      id,
    );
  }

  @override
  UsageHistoryStreamProvider getProviderOverride(
    covariant UsageHistoryStreamProvider provider,
  ) {
    return call(
      provider.uid,
      provider.id,
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
  String? get name => r'usageHistoryStreamProvider';
}

/// See also [usageHistoryStream].
class UsageHistoryStreamProvider
    extends AutoDisposeStreamProvider<UsageHistory> {
  /// See also [usageHistoryStream].
  UsageHistoryStreamProvider(
    this.uid,
    this.id,
  ) : super.internal(
          (ref) => usageHistoryStream(
            ref,
            uid,
            id,
          ),
          from: usageHistoryStreamProvider,
          name: r'usageHistoryStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$usageHistoryStreamHash,
          dependencies: UsageHistoryStreamFamily._dependencies,
          allTransitiveDependencies:
              UsageHistoryStreamFamily._allTransitiveDependencies,
        );

  final String uid;
  final String id;

  @override
  bool operator ==(Object other) {
    return other is UsageHistoryStreamProvider &&
        other.uid == uid &&
        other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
