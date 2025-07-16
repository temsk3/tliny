import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/program_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/program_repository.dart';
import '../../data/repository/staff_repository.dart';
import '../../data/repository/user_repository.dart';

part 'program_state.g.dart';

@riverpod
Stream<List<Program>> programsState(Ref ref) {
  return ref.watch(programRepositoryProvider).watchEventList();
}

@riverpod
Stream<Program> programState(Ref ref, String? programId) {
  if (programId == null) {
    return Stream.error('Program ID is required');
  }
  return ref.watch(programRepositoryProvider).watchEvent(programId);
}

@riverpod
Stream<List<Program>> myProgramListState(Ref ref) {
  final program = ref.watch(programsStateProvider).value;
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

final AutoDisposeStreamProvider<bool> addProgramButtonStateProvider =
    StreamProvider.autoDispose((ref) {
      final uidAsyncValue = ref.watch(userIdProvider);
      final uid = uidAsyncValue.value;

      // 認証されていない場合は作成不可
      if (uid == null) {
        return Stream<bool>.value(false);
      }

      // 販売者登録のステータスをチェック（chargesEnabledがtrueかどうか）
      return ref.read(userRepositoryProvider).streamCheckAccountStatus(uid);
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
