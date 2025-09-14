// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'comment_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$commentViewModelHash() => r'5c711e307a1ea167d4bc1a08c133ca026e874bf3';

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

abstract class _$CommentViewModel
    extends BuildlessAutoDisposeAsyncNotifier<List<PostComment>> {
  late final String postId;

  FutureOr<List<PostComment>> build(String postId);
}

/// See also [CommentViewModel].
@ProviderFor(CommentViewModel)
const commentViewModelProvider = CommentViewModelFamily();

/// See also [CommentViewModel].
class CommentViewModelFamily extends Family<AsyncValue<List<PostComment>>> {
  /// See also [CommentViewModel].
  const CommentViewModelFamily();

  /// See also [CommentViewModel].
  CommentViewModelProvider call(String postId) {
    return CommentViewModelProvider(postId);
  }

  @override
  CommentViewModelProvider getProviderOverride(
    covariant CommentViewModelProvider provider,
  ) {
    return call(provider.postId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'commentViewModelProvider';
}

/// See also [CommentViewModel].
class CommentViewModelProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          CommentViewModel,
          List<PostComment>
        > {
  /// See also [CommentViewModel].
  CommentViewModelProvider(String postId)
    : this._internal(
        () => CommentViewModel()..postId = postId,
        from: commentViewModelProvider,
        name: r'commentViewModelProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$commentViewModelHash,
        dependencies: CommentViewModelFamily._dependencies,
        allTransitiveDependencies:
            CommentViewModelFamily._allTransitiveDependencies,
        postId: postId,
      );

  CommentViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
  }) : super.internal();

  final String postId;

  @override
  FutureOr<List<PostComment>> runNotifierBuild(
    covariant CommentViewModel notifier,
  ) {
    return notifier.build(postId);
  }

  @override
  Override overrideWith(CommentViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: CommentViewModelProvider._internal(
        () => create()..postId = postId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CommentViewModel, List<PostComment>>
  createElement() {
    return _CommentViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CommentViewModelProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CommentViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<List<PostComment>> {
  /// The parameter `postId` of this provider.
  String get postId;
}

class _CommentViewModelProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          CommentViewModel,
          List<PostComment>
        >
    with CommentViewModelRef {
  _CommentViewModelProviderElement(super.provider);

  @override
  String get postId => (origin as CommentViewModelProvider).postId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
