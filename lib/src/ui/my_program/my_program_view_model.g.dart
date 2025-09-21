// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'my_program_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MyProgramViewModel)
const myProgramViewModelProvider = MyProgramViewModelProvider._();

final class MyProgramViewModelProvider
    extends $AsyncNotifierProvider<MyProgramViewModel, List<MyProgram>> {
  const MyProgramViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myProgramViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myProgramViewModelHash();

  @$internal
  @override
  MyProgramViewModel create() => MyProgramViewModel();
}

String _$myProgramViewModelHash() =>
    r'644190dc5a61a21c23115ad3e16e9f36c1de5572';

abstract class _$MyProgramViewModel extends $AsyncNotifier<List<MyProgram>> {
  FutureOr<List<MyProgram>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<MyProgram>>, List<MyProgram>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<MyProgram>>, List<MyProgram>>,
              AsyncValue<List<MyProgram>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
