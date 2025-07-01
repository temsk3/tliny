// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'staff_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$staffViewModelHash() => r'9c9847cc176c63a6b1164e097fdcfb1d4b29005c';

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

abstract class _$StaffViewModel
    extends BuildlessAutoDisposeAsyncNotifier<List<Staff>> {
  late final String programId;

  FutureOr<List<Staff>> build(String programId);
}

/// See also [StaffViewModel].
@ProviderFor(StaffViewModel)
const staffViewModelProvider = StaffViewModelFamily();

/// See also [StaffViewModel].
class StaffViewModelFamily extends Family<AsyncValue<List<Staff>>> {
  /// See also [StaffViewModel].
  const StaffViewModelFamily();

  /// See also [StaffViewModel].
  StaffViewModelProvider call(String programId) {
    return StaffViewModelProvider(programId);
  }

  @override
  StaffViewModelProvider getProviderOverride(
    covariant StaffViewModelProvider provider,
  ) {
    return call(provider.programId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'staffViewModelProvider';
}

/// See also [StaffViewModel].
class StaffViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<StaffViewModel, List<Staff>> {
  /// See also [StaffViewModel].
  StaffViewModelProvider(String programId)
    : this._internal(
        () => StaffViewModel()..programId = programId,
        from: staffViewModelProvider,
        name: r'staffViewModelProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$staffViewModelHash,
        dependencies: StaffViewModelFamily._dependencies,
        allTransitiveDependencies:
            StaffViewModelFamily._allTransitiveDependencies,
        programId: programId,
      );

  StaffViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.programId,
  }) : super.internal();

  final String programId;

  @override
  FutureOr<List<Staff>> runNotifierBuild(covariant StaffViewModel notifier) {
    return notifier.build(programId);
  }

  @override
  Override overrideWith(StaffViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: StaffViewModelProvider._internal(
        () => create()..programId = programId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        programId: programId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<StaffViewModel, List<Staff>>
  createElement() {
    return _StaffViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StaffViewModelProvider && other.programId == programId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, programId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StaffViewModelRef on AutoDisposeAsyncNotifierProviderRef<List<Staff>> {
  /// The parameter `programId` of this provider.
  String get programId;
}

class _StaffViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<StaffViewModel, List<Staff>>
    with StaffViewModelRef {
  _StaffViewModelProviderElement(super.provider);

  @override
  String get programId => (origin as StaffViewModelProvider).programId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
