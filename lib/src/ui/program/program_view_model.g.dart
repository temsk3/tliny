// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'program_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProgramViewModel)
const programViewModelProvider = ProgramViewModelProvider._();

final class ProgramViewModelProvider
    extends $AsyncNotifierProvider<ProgramViewModel, List<Program>> {
  const ProgramViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'programViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$programViewModelHash();

  @$internal
  @override
  ProgramViewModel create() => ProgramViewModel();
}

String _$programViewModelHash() => r'4f4c6c5bc5a70f1848b635a4fe320e0102c1d84f';

abstract class _$ProgramViewModel extends $AsyncNotifier<List<Program>> {
  FutureOr<List<Program>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Program>>, List<Program>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Program>>, List<Program>>,
              AsyncValue<List<Program>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
