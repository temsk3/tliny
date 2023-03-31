import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/program_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/program_repository.dart';
import '../../data/repository/staff_repository.dart';
import '../../data/repository/user_repository.dart';

part 'program_state.freezed.dart';

final programListStateProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(programRepositoryProvider).watchEventList(),
);

// final programStateProvider = StreamProvider.autoDispose.family<Program, String>(
//   (ref, programId) =>
//       ref.watch(programRepositoryProvider).streamEvent(programId),
// );

final addProgramButtonStateProvider = StreamProvider.autoDispose(
  (ref) {
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      return ref.watch(userRepositoryProvider).streamCheckExistenceAccount(uid);
    }
    return Stream<bool>.value(false);
  },
);

final editProgramButtonStateProvider =
    StreamProvider.family.autoDispose<bool, Program>(
  (ref, program) {
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == program.organizerId) {
      return Stream<bool>.value(true);
    }
    return Stream<bool>.value(false);
  },
);

final addStaffButtonStateProvider =
    StreamProvider.family.autoDispose<bool, Program>(
  (ref, program) {
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
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
  },
);

@freezed
class ProgramState with _$ProgramState {
  const factory ProgramState({
    @Default(<Program>[]) List<Program> programList,
    @Default(false) bool addProgramButton,
    @Default(false) bool addStaffButton,
  }) = _ProgramState;
}
