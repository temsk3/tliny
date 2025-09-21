// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'program_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(programRepository)
const programRepositoryProvider = ProgramRepositoryProvider._();

final class ProgramRepositoryProvider
    extends
        $FunctionalProvider<
          ProgramRepository,
          ProgramRepository,
          ProgramRepository
        >
    with $Provider<ProgramRepository> {
  const ProgramRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'programRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$programRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProgramRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProgramRepository create(Ref ref) {
    return programRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProgramRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProgramRepository>(value),
    );
  }
}

String _$programRepositoryHash() => r'50d01370ee4b4eedac548501d03dff7d9d8a8975';

@ProviderFor(programsStream)
const programsStreamProvider = ProgramsStreamProvider._();

final class ProgramsStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Program>>,
          List<Program>,
          Stream<List<Program>>
        >
    with $FutureModifier<List<Program>>, $StreamProvider<List<Program>> {
  const ProgramsStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'programsStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$programsStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<Program>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Program>> create(Ref ref) {
    return programsStream(ref);
  }
}

String _$programsStreamHash() => r'9b5ccb4a0654d7a29f795136fb4648d38a21ad61';

@ProviderFor(programStream)
const programStreamProvider = ProgramStreamFamily._();

final class ProgramStreamProvider
    extends $FunctionalProvider<AsyncValue<Program>, Program, Stream<Program>>
    with $FutureModifier<Program>, $StreamProvider<Program> {
  const ProgramStreamProvider._({
    required ProgramStreamFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'programStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$programStreamHash();

  @override
  String toString() {
    return r'programStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Program> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Program> create(Ref ref) {
    final argument = this.argument as String;
    return programStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProgramStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$programStreamHash() => r'bc5242811f6cdd9baac018abd2efd14163fb9a61';

final class ProgramStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Program>, String> {
  const ProgramStreamFamily._()
    : super(
        retry: null,
        name: r'programStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProgramStreamProvider call(String programId) =>
      ProgramStreamProvider._(argument: programId, from: this);

  @override
  String toString() => r'programStreamProvider';
}

@ProviderFor(programFuture)
const programFutureProvider = ProgramFutureFamily._();

final class ProgramFutureProvider
    extends
        $FunctionalProvider<AsyncValue<Program?>, Program?, FutureOr<Program?>>
    with $FutureModifier<Program?>, $FutureProvider<Program?> {
  const ProgramFutureProvider._({
    required ProgramFutureFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'programFutureProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$programFutureHash();

  @override
  String toString() {
    return r'programFutureProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Program?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Program?> create(Ref ref) {
    final argument = this.argument as String;
    return programFuture(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProgramFutureProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$programFutureHash() => r'e270c5f833c5ab1fa7c4cb2a63b5c5bd0184e76a';

final class ProgramFutureFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Program?>, String> {
  const ProgramFutureFamily._()
    : super(
        retry: null,
        name: r'programFutureProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProgramFutureProvider call(String programId) =>
      ProgramFutureProvider._(argument: programId, from: this);

  @override
  String toString() => r'programFutureProvider';
}

@ProviderFor(programsByOrganizerStream)
const programsByOrganizerStreamProvider = ProgramsByOrganizerStreamFamily._();

final class ProgramsByOrganizerStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Program>>,
          List<Program>,
          Stream<List<Program>>
        >
    with $FutureModifier<List<Program>>, $StreamProvider<List<Program>> {
  const ProgramsByOrganizerStreamProvider._({
    required ProgramsByOrganizerStreamFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'programsByOrganizerStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$programsByOrganizerStreamHash();

  @override
  String toString() {
    return r'programsByOrganizerStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Program>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Program>> create(Ref ref) {
    final argument = this.argument as String;
    return programsByOrganizerStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProgramsByOrganizerStreamProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$programsByOrganizerStreamHash() =>
    r'45d4df871321e7ced10ebd80ce9d3853a3e55026';

final class ProgramsByOrganizerStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Program>>, String> {
  const ProgramsByOrganizerStreamFamily._()
    : super(
        retry: null,
        name: r'programsByOrganizerStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProgramsByOrganizerStreamProvider call(String organizerId) =>
      ProgramsByOrganizerStreamProvider._(argument: organizerId, from: this);

  @override
  String toString() => r'programsByOrganizerStreamProvider';
}
