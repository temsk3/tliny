// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'program_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(programsState)
const programsStateProvider = ProgramsStateProvider._();

final class ProgramsStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Program>>,
          List<Program>,
          Stream<List<Program>>
        >
    with $FutureModifier<List<Program>>, $StreamProvider<List<Program>> {
  const ProgramsStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'programsStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$programsStateHash();

  @$internal
  @override
  $StreamProviderElement<List<Program>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Program>> create(Ref ref) {
    return programsState(ref);
  }
}

String _$programsStateHash() => r'ad3d1dda06125f9a1c29dd99fde2b80e102778bb';

@ProviderFor(programsStateAsync)
const programsStateAsyncProvider = ProgramsStateAsyncProvider._();

final class ProgramsStateAsyncProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Program>>,
          List<Program>,
          FutureOr<List<Program>>
        >
    with $FutureModifier<List<Program>>, $FutureProvider<List<Program>> {
  const ProgramsStateAsyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'programsStateAsyncProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$programsStateAsyncHash();

  @$internal
  @override
  $FutureProviderElement<List<Program>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Program>> create(Ref ref) {
    return programsStateAsync(ref);
  }
}

String _$programsStateAsyncHash() =>
    r'f35d77d400c7d52bd6e480912ad3de3949b2a1ac';

@ProviderFor(programState)
const programStateProvider = ProgramStateFamily._();

final class ProgramStateProvider
    extends $FunctionalProvider<AsyncValue<Program>, Program, Stream<Program>>
    with $FutureModifier<Program>, $StreamProvider<Program> {
  const ProgramStateProvider._({
    required ProgramStateFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'programStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$programStateHash();

  @override
  String toString() {
    return r'programStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Program> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Program> create(Ref ref) {
    final argument = this.argument as String?;
    return programState(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProgramStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$programStateHash() => r'c6fe483208bfe5fcded5085b735818d2cea3a164';

final class ProgramStateFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Program>, String?> {
  const ProgramStateFamily._()
    : super(
        retry: null,
        name: r'programStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProgramStateProvider call(String? programId) =>
      ProgramStateProvider._(argument: programId, from: this);

  @override
  String toString() => r'programStateProvider';
}

@ProviderFor(myProgramListState)
const myProgramListStateProvider = MyProgramListStateProvider._();

final class MyProgramListStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Program>>,
          List<Program>,
          Stream<List<Program>>
        >
    with $FutureModifier<List<Program>>, $StreamProvider<List<Program>> {
  const MyProgramListStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myProgramListStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myProgramListStateHash();

  @$internal
  @override
  $StreamProviderElement<List<Program>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Program>> create(Ref ref) {
    return myProgramListState(ref);
  }
}

String _$myProgramListStateHash() =>
    r'39901ee3093ccc77e32af291a9400a595ddc2993';
