// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'ticket_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ticketRepositoryHash() => r'e69d8f9efb6fbb3f6efdc35edf45a6100348a945';

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
String _$allTicketStreamHash() => r'6cd33a8e6239bd79380a2a6075d4380241f46a46';

/// See also [allTicketStream].
@ProviderFor(allTicketStream)
final allTicketStreamProvider =
    AutoDisposeStreamProvider<List<Ticket>>.internal(
  allTicketStream,
  name: r'allTicketStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allTicketStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllTicketStreamRef = AutoDisposeStreamProviderRef<List<Ticket>>;
String _$ticketsStreamHash() => r'320c7a59f4e104495f5847f887f88581c4067596';

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
    String uid,
  ) : this._internal(
          (ref) => ticketsStream(
            ref as TicketsStreamRef,
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
          uid: uid,
        );

  TicketsStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    Stream<List<Ticket>> Function(TicketsStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TicketsStreamProvider._internal(
        (ref) => create(ref as TicketsStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Ticket>> createElement() {
    return _TicketsStreamProviderElement(this);
  }

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

mixin TicketsStreamRef on AutoDisposeStreamProviderRef<List<Ticket>> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _TicketsStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<Ticket>>
    with TicketsStreamRef {
  _TicketsStreamProviderElement(super.provider);

  @override
  String get uid => (origin as TicketsStreamProvider).uid;
}

String _$ticketStreamHash() => r'14bf168141c8144533d728108ab52ff73815cf22';

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
    String uid,
    String ticketId,
  ) : this._internal(
          (ref) => ticketStream(
            ref as TicketStreamRef,
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
          uid: uid,
          ticketId: ticketId,
        );

  TicketStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
    required this.ticketId,
  }) : super.internal();

  final String uid;
  final String ticketId;

  @override
  Override overrideWith(
    Stream<Ticket> Function(TicketStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TicketStreamProvider._internal(
        (ref) => create(ref as TicketStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
        ticketId: ticketId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Ticket> createElement() {
    return _TicketStreamProviderElement(this);
  }

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

mixin TicketStreamRef on AutoDisposeStreamProviderRef<Ticket> {
  /// The parameter `uid` of this provider.
  String get uid;

  /// The parameter `ticketId` of this provider.
  String get ticketId;
}

class _TicketStreamProviderElement
    extends AutoDisposeStreamProviderElement<Ticket> with TicketStreamRef {
  _TicketStreamProviderElement(super.provider);

  @override
  String get uid => (origin as TicketStreamProvider).uid;
  @override
  String get ticketId => (origin as TicketStreamProvider).ticketId;
}

String _$usageHistoryRepositoryHash() =>
    r'f2f1dccbfd3e1a688511c0b9788cabce16a37a6b';

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
    r'bf5da019fb6055c7b32b06d5945120b68bd17d3b';

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
    String uid,
  ) : this._internal(
          (ref) => usageHistoryListStream(
            ref as UsageHistoryListStreamRef,
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
          uid: uid,
        );

  UsageHistoryListStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    Stream<List<UsageHistory>> Function(UsageHistoryListStreamRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UsageHistoryListStreamProvider._internal(
        (ref) => create(ref as UsageHistoryListStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<UsageHistory>> createElement() {
    return _UsageHistoryListStreamProviderElement(this);
  }

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

mixin UsageHistoryListStreamRef
    on AutoDisposeStreamProviderRef<List<UsageHistory>> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _UsageHistoryListStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<UsageHistory>>
    with UsageHistoryListStreamRef {
  _UsageHistoryListStreamProviderElement(super.provider);

  @override
  String get uid => (origin as UsageHistoryListStreamProvider).uid;
}

String _$usageHistoryStreamHash() =>
    r'c2a7744b605ff8fc998a37f24a78b6d552cc890c';

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
    String uid,
    String id,
  ) : this._internal(
          (ref) => usageHistoryStream(
            ref as UsageHistoryStreamRef,
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
          uid: uid,
          id: id,
        );

  UsageHistoryStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
    required this.id,
  }) : super.internal();

  final String uid;
  final String id;

  @override
  Override overrideWith(
    Stream<UsageHistory> Function(UsageHistoryStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UsageHistoryStreamProvider._internal(
        (ref) => create(ref as UsageHistoryStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<UsageHistory> createElement() {
    return _UsageHistoryStreamProviderElement(this);
  }

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

mixin UsageHistoryStreamRef on AutoDisposeStreamProviderRef<UsageHistory> {
  /// The parameter `uid` of this provider.
  String get uid;

  /// The parameter `id` of this provider.
  String get id;
}

class _UsageHistoryStreamProviderElement
    extends AutoDisposeStreamProviderElement<UsageHistory>
    with UsageHistoryStreamRef {
  _UsageHistoryStreamProviderElement(super.provider);

  @override
  String get uid => (origin as UsageHistoryStreamProvider).uid;
  @override
  String get id => (origin as UsageHistoryStreamProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
