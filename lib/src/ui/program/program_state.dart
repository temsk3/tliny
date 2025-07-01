import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/program_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/program_repository.dart';
import '../../data/repository/staff_repository.dart';
import '../../data/repository/user_repository.dart';

part 'program_state.g.dart';

@riverpod
Stream<List<Program>> programListState(ProgramListStateRef ref) {
  return ref.watch(programRepositoryProvider).watchEventList();
}

@riverpod
Stream<Program> programState(ProgramStateRef ref, String? programId) {
  final list = ref.watch(programsStreamProvider).value;
  if (programId != null && list != null) {
    return Stream.value(list.firstWhere((element) => element.id == programId));
  }
  return Stream.value(Program.empty());
}

@riverpod
Stream<List<Program>> myProgramListState(MyProgramListStateRef ref) {
  final program = ref.watch(programListStateProvider).value;
  final uid = ref.watch(userIdProvider).value;
  if (uid != null && program != null) {
    final list =
        program.where((element) => element.organizerId == uid).toList();
    return Stream.value(list);
  }
  return Stream.value([]);
}
// final programStateProvider = StreamProvider.autoDispose.family<Program, String>(
//   (ref, programId) =>
//       ref.watch(programRepositoryProvider).streamEvent(programId),
// );

final AutoDisposeStreamProvider<bool>
addProgramButtonStateProvider = StreamProvider.autoDispose((ref) {
  final uidAsyncValue = ref.watch(userIdProvider);
  final uid = uidAsyncValue.value;
  if (uid != null) {
    //
    // return ref.watch(userRepositoryProvider).streamCheckExistenceAccount(uid);
    return ref.watch(userRepositoryProvider).streamCheckAccountStatus(uid);
  }
  return Stream<bool>.value(false);
});

final AutoDisposeStreamProviderFamily<bool, Program>
editProgramButtonStateProvider = StreamProvider.family
    .autoDispose<bool, Program>((ref, program) {
      final uidAsyncValue = ref.watch(userIdProvider);
      final uid = uidAsyncValue.value;
      if (uid == program.organizerId) {
        return Stream<bool>.value(true);
      }
      return Stream<bool>.value(false);
    });

final AutoDisposeStreamProviderFamily<bool, Program>
addStaffButtonStateProvider = StreamProvider.family.autoDispose<bool, Program>((
  ref,
  program,
) {
  final uidAsyncValue = ref.watch(userIdProvider);
  final uid = uidAsyncValue.value;
  if (uid != null) {
    if (uid == program.organizerId) return Stream<bool>.value(false); //
    if (program.staffCode != null) {
      if (program.staffCode!.isNotEmpty) {
        final existence = ref.watch(staffCheckExistenceProvider(program.id!));
        final result = existence.value;
        if (result != null) {
          return Stream<bool>.value(!result);
        }
      }
    }
  }
  return Stream<bool>.value(false);
});
