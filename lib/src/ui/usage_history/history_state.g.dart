// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'history_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$usageHistoryStateHash() => r'015815fa49ea6e38ef551263077388f18d1b9632';

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

/// See also [usageHistoryState].
@ProviderFor(usageHistoryState)
const usageHistoryStateProvider = UsageHistoryStateFamily();

/// See also [usageHistoryState].
class UsageHistoryStateFamily extends Family<AsyncValue<UsageHistory>> {
  /// See also [usageHistoryState].
  const UsageHistoryStateFamily();

  /// See also [usageHistoryState].
  UsageHistoryStateProvider call(String id) {
    return UsageHistoryStateProvider(id);
  }

  @override
  UsageHistoryStateProvider getProviderOverride(
    covariant UsageHistoryStateProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'usageHistoryStateProvider';
}

/// See also [usageHistoryState].
class UsageHistoryStateProvider
    extends AutoDisposeStreamProvider<UsageHistory> {
  /// See also [usageHistoryState].
  UsageHistoryStateProvider(String id)
    : this._internal(
        (ref) => usageHistoryState(ref as UsageHistoryStateRef, id),
        from: usageHistoryStateProvider,
        name: r'usageHistoryStateProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$usageHistoryStateHash,
        dependencies: UsageHistoryStateFamily._dependencies,
        allTransitiveDependencies:
            UsageHistoryStateFamily._allTransitiveDependencies,
        id: id,
      );

  UsageHistoryStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Stream<UsageHistory> Function(UsageHistoryStateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UsageHistoryStateProvider._internal(
        (ref) => create(ref as UsageHistoryStateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<UsageHistory> createElement() {
    return _UsageHistoryStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UsageHistoryStateProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UsageHistoryStateRef on AutoDisposeStreamProviderRef<UsageHistory> {
  /// The parameter `id` of this provider.
  String get id;
}

class _UsageHistoryStateProviderElement
    extends AutoDisposeStreamProviderElement<UsageHistory>
    with UsageHistoryStateRef {
  _UsageHistoryStateProviderElement(super.provider);

  @override
  String get id => (origin as UsageHistoryStateProvider).id;
}

String _$ticketStreamStateHash() => r'697add3ecc9b59beb7dfde9aadabd6bc43c8ec1c';

/// See also [ticketStreamState].
@ProviderFor(ticketStreamState)
const ticketStreamStateProvider = TicketStreamStateFamily();

/// See also [ticketStreamState].
class TicketStreamStateFamily extends Family<AsyncValue<Ticket>> {
  /// See also [ticketStreamState].
  const TicketStreamStateFamily();

  /// See also [ticketStreamState].
  TicketStreamStateProvider call(String id) {
    return TicketStreamStateProvider(id);
  }

  @override
  TicketStreamStateProvider getProviderOverride(
    covariant TicketStreamStateProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'ticketStreamStateProvider';
}

/// See also [ticketStreamState].
class TicketStreamStateProvider extends AutoDisposeStreamProvider<Ticket> {
  /// See also [ticketStreamState].
  TicketStreamStateProvider(String id)
    : this._internal(
        (ref) => ticketStreamState(ref as TicketStreamStateRef, id),
        from: ticketStreamStateProvider,
        name: r'ticketStreamStateProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$ticketStreamStateHash,
        dependencies: TicketStreamStateFamily._dependencies,
        allTransitiveDependencies:
            TicketStreamStateFamily._allTransitiveDependencies,
        id: id,
      );

  TicketStreamStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Stream<Ticket> Function(TicketStreamStateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TicketStreamStateProvider._internal(
        (ref) => create(ref as TicketStreamStateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Ticket> createElement() {
    return _TicketStreamStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TicketStreamStateProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TicketStreamStateRef on AutoDisposeStreamProviderRef<Ticket> {
  /// The parameter `id` of this provider.
  String get id;
}

class _TicketStreamStateProviderElement
    extends AutoDisposeStreamProviderElement<Ticket>
    with TicketStreamStateRef {
  _TicketStreamStateProviderElement(super.provider);

  @override
  String get id => (origin as TicketStreamStateProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
