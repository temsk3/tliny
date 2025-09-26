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

@ProviderFor(addProgramButtonState)
const addProgramButtonStateProvider = AddProgramButtonStateProvider._();

final class AddProgramButtonStateProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  const AddProgramButtonStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addProgramButtonStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addProgramButtonStateHash();

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    return addProgramButtonState(ref);
  }
}

String _$addProgramButtonStateHash() =>
    r'7ded6e8a58b446fae458a0c93bfe8d3240921de2';

@ProviderFor(editProgramButtonState)
const editProgramButtonStateProvider = EditProgramButtonStateFamily._();

final class EditProgramButtonStateProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  const EditProgramButtonStateProvider._({
    required EditProgramButtonStateFamily super.from,
    required Program super.argument,
  }) : super(
         retry: null,
         name: r'editProgramButtonStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$editProgramButtonStateHash();

  @override
  String toString() {
    return r'editProgramButtonStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    final argument = this.argument as Program;
    return editProgramButtonState(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EditProgramButtonStateProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$editProgramButtonStateHash() =>
    r'4d88246e0bceed4aa603f1bd21997a23297c71fe';

final class EditProgramButtonStateFamily extends $Family
    with $FunctionalFamilyOverride<Stream<bool>, Program> {
  const EditProgramButtonStateFamily._()
    : super(
        retry: null,
        name: r'editProgramButtonStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EditProgramButtonStateProvider call(Program program) =>
      EditProgramButtonStateProvider._(argument: program, from: this);

  @override
  String toString() => r'editProgramButtonStateProvider';
}

@ProviderFor(addStaffButtonState)
const addStaffButtonStateProvider = AddStaffButtonStateFamily._();

final class AddStaffButtonStateProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  const AddStaffButtonStateProvider._({
    required AddStaffButtonStateFamily super.from,
    required Program super.argument,
  }) : super(
         retry: null,
         name: r'addStaffButtonStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$addStaffButtonStateHash();

  @override
  String toString() {
    return r'addStaffButtonStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    final argument = this.argument as Program;
    return addStaffButtonState(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AddStaffButtonStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$addStaffButtonStateHash() =>
    r'2c120d23537646af39ad68978c96486a147c8328';

final class AddStaffButtonStateFamily extends $Family
    with $FunctionalFamilyOverride<Stream<bool>, Program> {
  const AddStaffButtonStateFamily._()
    : super(
        retry: null,
        name: r'addStaffButtonStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AddStaffButtonStateProvider call(Program program) =>
      AddStaffButtonStateProvider._(argument: program, from: this);

  @override
  String toString() => r'addStaffButtonStateProvider';
}
