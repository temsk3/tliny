import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/my_program_model.dart';
import '../../data/model/program_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/my_program_repository.dart';
import '../../data/repository/product_repository.dart';
import '../../data/repository/program_repository.dart';
import '../../data/repository/staff_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../ui/program/program_state.dart';
import '../my_program/my_program_view_model.dart';

part 'program_view_model.g.dart';

final logger = Logger();

// final eventStreamViewModelProvider = Provider(
//   (ref) => EventStreamViewModel(ref),
// );
@riverpod
class ProgramViewModel extends _$ProgramViewModel {
  // EventViewModel(this._ref);
  // final Ref _ref;

  late final authRepository = ref.watch(authRepositoryProvider);
  late final userRepository = ref.watch(userRepositoryProvider);
  late final myProgramRepository = ref.watch(myProgramRepositoryProvider);
  late final productRepository = ref.watch(productRepositoryProvider);
  late final staffRepository = ref.watch(staffRepositoryProvider);
  late final programRepository = ref.read(programRepositoryProvider);

  @override
  FutureOr<ProgramState> build() {
    readPrograms();
    return const ProgramState();
  }

  Future<void> setProgramState(ProgramState data) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return data;
    });
    logger.d(state);
  }

  // 取得
  Future<void> readPrograms() async {
    logger.d('readProgram');
    final programList = await programRepository.readEvents();
    final list = <Program>[];
    for (final program in programList) {
      final staffList = await staffRepository.readStaffs(program.id.toString());
      final productList =
          await productRepository.programProducts(program.id.toString());
      list.add(program.copyWith(staff: staffList, product: productList));
    }
    final data = ProgramState(
      programList: list,
      addProgramButton: await checkAccount,
    );
    await setProgramState(data);
  }

  // 追加
  Future<void> addProgram(Program data) async {
    logger.d('addProgram');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    final newData = data.copyWith(
      organizerId: uid,
    );
    if (uid != null) {
      state = const AsyncLoading();
      state = await AsyncValue.guard(() async {
        final id = await programRepository.createEvent(newData);
        //
        await ref.watch(myProgramViewModelProvider.notifier).addMyProgram(
              MyProgram(programId: id),
            );
        //
        return ProgramState(
          programList: [...?state.value?.programList, newData.copyWith(id: id)],
          addProgramButton: await checkAccount,
        );
      });
    }
  }

  // // 更新
  Future<void> updateProgram(Program data) async {
    logger.d('updateProgram');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final id = await programRepository.updateEvent(data);
      return ProgramState(
        programList: [
          for (final program in state.value!.programList)
            if (program.id == id) data else program
        ],
        addProgramButton: await checkAccount,
      );
    });
  }

  // //削除
  Future<void> deleteProgram(String id) async {
    logger.d('deleteProgram');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await programRepository.deleteEvent(id);
      return ProgramState(
        programList: [
          for (final program in state.value!.programList)
            if (program.id != id) program
        ],
        addProgramButton: await checkAccount,
      );
    });
  }

  Future<void> registerProgram(Program data) async {
    if (data.id == null) {
      await addProgram(data);
    } else {
      await updateProgram(data);
    }
  }

  //
  //
  Future<bool> get checkAccount async {
    final userId = await authRepository.userId.last;
    if (userId != null) {
      return userRepository.checkExistenceAccount(userId);
    } else {
      return false;
    }
  }

  // Future<bool> isStaff(String programId) async {
  //   final user = await authRepository.authStateChanges.last;
  //   if (user) {
  //     final userId = await authRepository.userId.last;
  //     return await staffRepository.checkExistenceStaff(programId, userId);
  //   } else {
  //     return false;
  //   }
  // }
}
