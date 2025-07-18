// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'terms_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$termsViewModelHash() => r'170db5fa563fff16ff3863129dcdd9df3a80811c';

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

abstract class _$TermsViewModel
    extends BuildlessAutoDisposeAsyncNotifier<User> {
  late final String uid;

  FutureOr<User> build(String uid);
}

/// See also [TermsViewModel].
@ProviderFor(TermsViewModel)
const termsViewModelProvider = TermsViewModelFamily();

/// See also [TermsViewModel].
class TermsViewModelFamily extends Family<AsyncValue<User>> {
  /// See also [TermsViewModel].
  const TermsViewModelFamily();

  /// See also [TermsViewModel].
  TermsViewModelProvider call(String uid) {
    return TermsViewModelProvider(uid);
  }

  @override
  TermsViewModelProvider getProviderOverride(
    covariant TermsViewModelProvider provider,
  ) {
    return call(provider.uid);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'termsViewModelProvider';
}

/// See also [TermsViewModel].
class TermsViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TermsViewModel, User> {
  /// See also [TermsViewModel].
  TermsViewModelProvider(String uid)
    : this._internal(
        () => TermsViewModel()..uid = uid,
        from: termsViewModelProvider,
        name: r'termsViewModelProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$termsViewModelHash,
        dependencies: TermsViewModelFamily._dependencies,
        allTransitiveDependencies:
            TermsViewModelFamily._allTransitiveDependencies,
        uid: uid,
      );

  TermsViewModelProvider._internal(
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
  FutureOr<User> runNotifierBuild(covariant TermsViewModel notifier) {
    return notifier.build(uid);
  }

  @override
  Override overrideWith(TermsViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: TermsViewModelProvider._internal(
        () => create()..uid = uid,
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
  AutoDisposeAsyncNotifierProviderElement<TermsViewModel, User>
  createElement() {
    return _TermsViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TermsViewModelProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TermsViewModelRef on AutoDisposeAsyncNotifierProviderRef<User> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _TermsViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TermsViewModel, User>
    with TermsViewModelRef {
  _TermsViewModelProviderElement(super.provider);

  @override
  String get uid => (origin as TermsViewModelProvider).uid;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
