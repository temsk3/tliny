// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'terms_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TermsViewModel)
const termsViewModelProvider = TermsViewModelFamily._();

final class TermsViewModelProvider
    extends $AsyncNotifierProvider<TermsViewModel, User> {
  const TermsViewModelProvider._({
    required TermsViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'termsViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$termsViewModelHash();

  @override
  String toString() {
    return r'termsViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TermsViewModel create() => TermsViewModel();

  @override
  bool operator ==(Object other) {
    return other is TermsViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$termsViewModelHash() => r'9b0a379bef096a4ac82ebaa97f905ef596e2ecf4';

final class TermsViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          TermsViewModel,
          AsyncValue<User>,
          User,
          FutureOr<User>,
          String
        > {
  const TermsViewModelFamily._()
    : super(
        retry: null,
        name: r'termsViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TermsViewModelProvider call(String uid) =>
      TermsViewModelProvider._(argument: uid, from: this);

  @override
  String toString() => r'termsViewModelProvider';
}

abstract class _$TermsViewModel extends $AsyncNotifier<User> {
  late final _$args = ref.$arg as String;
  String get uid => _$args;

  FutureOr<User> build(String uid);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<User>, User>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<User>, User>,
              AsyncValue<User>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
