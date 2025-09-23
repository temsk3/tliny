// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'comment_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CommentViewModel)
const commentViewModelProvider = CommentViewModelFamily._();

final class CommentViewModelProvider
    extends $AsyncNotifierProvider<CommentViewModel, List<PostComment>> {
  const CommentViewModelProvider._({
    required CommentViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'commentViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$commentViewModelHash();

  @override
  String toString() {
    return r'commentViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CommentViewModel create() => CommentViewModel();

  @override
  bool operator ==(Object other) {
    return other is CommentViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$commentViewModelHash() => r'1b4bafdc87feed5f7c757f8250ee2f9276261dab';

final class CommentViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          CommentViewModel,
          AsyncValue<List<PostComment>>,
          List<PostComment>,
          FutureOr<List<PostComment>>,
          String
        > {
  const CommentViewModelFamily._()
    : super(
        retry: null,
        name: r'commentViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CommentViewModelProvider call(String postId) =>
      CommentViewModelProvider._(argument: postId, from: this);

  @override
  String toString() => r'commentViewModelProvider';
}

abstract class _$CommentViewModel extends $AsyncNotifier<List<PostComment>> {
  late final _$args = ref.$arg as String;
  String get postId => _$args;

  FutureOr<List<PostComment>> build(String postId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<List<PostComment>>, List<PostComment>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PostComment>>, List<PostComment>>,
              AsyncValue<List<PostComment>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
