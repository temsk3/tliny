// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'sns_chat_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$snsChatViewModelHash() => r'66b8a415cf7da8e7a23929b37f953d072a6d2201';

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

abstract class _$SnsChatViewModel
    extends BuildlessAutoDisposeAsyncNotifier<List<DirectMessage>> {
  late final String conversationId;

  FutureOr<List<DirectMessage>> build(
    String conversationId,
  );
}

/// See also [SnsChatViewModel].
@ProviderFor(SnsChatViewModel)
const snsChatViewModelProvider = SnsChatViewModelFamily();

/// See also [SnsChatViewModel].
class SnsChatViewModelFamily extends Family<AsyncValue<List<DirectMessage>>> {
  /// See also [SnsChatViewModel].
  const SnsChatViewModelFamily();

  /// See also [SnsChatViewModel].
  SnsChatViewModelProvider call(
    String conversationId,
  ) {
    return SnsChatViewModelProvider(
      conversationId,
    );
  }

  @override
  SnsChatViewModelProvider getProviderOverride(
    covariant SnsChatViewModelProvider provider,
  ) {
    return call(
      provider.conversationId,
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
  String? get name => r'snsChatViewModelProvider';
}

/// See also [SnsChatViewModel].
class SnsChatViewModelProvider extends AutoDisposeAsyncNotifierProviderImpl<
    SnsChatViewModel, List<DirectMessage>> {
  /// See also [SnsChatViewModel].
  SnsChatViewModelProvider(
    String conversationId,
  ) : this._internal(
          () => SnsChatViewModel()..conversationId = conversationId,
          from: snsChatViewModelProvider,
          name: r'snsChatViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$snsChatViewModelHash,
          dependencies: SnsChatViewModelFamily._dependencies,
          allTransitiveDependencies:
              SnsChatViewModelFamily._allTransitiveDependencies,
          conversationId: conversationId,
        );

  SnsChatViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.conversationId,
  }) : super.internal();

  final String conversationId;

  @override
  FutureOr<List<DirectMessage>> runNotifierBuild(
    covariant SnsChatViewModel notifier,
  ) {
    return notifier.build(
      conversationId,
    );
  }

  @override
  Override overrideWith(SnsChatViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: SnsChatViewModelProvider._internal(
        () => create()..conversationId = conversationId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        conversationId: conversationId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SnsChatViewModel, List<DirectMessage>>
      createElement() {
    return _SnsChatViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SnsChatViewModelProvider &&
        other.conversationId == conversationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, conversationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SnsChatViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<List<DirectMessage>> {
  /// The parameter `conversationId` of this provider.
  String get conversationId;
}

class _SnsChatViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SnsChatViewModel,
        List<DirectMessage>> with SnsChatViewModelRef {
  _SnsChatViewModelProviderElement(super.provider);

  @override
  String get conversationId =>
      (origin as SnsChatViewModelProvider).conversationId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
