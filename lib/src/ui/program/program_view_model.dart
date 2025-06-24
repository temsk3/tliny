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

part 'program_view_model.g.dart';

final logger = Logger();

@riverpod
class ProgramViewModel extends _$ProgramViewModel {
  late final authRepository = ref.watch(authRepositoryProvider);
  late final userRepository = ref.watch(userRepositoryProvider);
  late final myProgramRepository = ref.watch(myProgramRepositoryProvider);
  late final productRepository = ref.watch(productRepositoryProvider);
  late final staffRepository = ref.watch(staffRepositoryProvider);
  late final programRepository = ref.watch(programRepositoryProvider);

  @override
  FutureOr<List<Program>> build() {
    return readPrograms();
  }

  // 取得
  Future<List<Program>> readPrograms() async {
    logger.d('readProgram');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return programRepository.readEvents();
    });
    return programRepository.readEvents();
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
        await myProgramRepository.createMyProgram(
          uid,
          MyProgram(programId: id),
        );
        //
        return [...?state.value, data.copyWith(id: id)];
      });
    }
  }

  // 更新
  Future<void> updateProgram(Program data) async {
    logger.d('updateProgram');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final id = await programRepository.updateEvent(data);
      return [
        for (final product in state.value!)
          if (product.id == id) data else product
      ];
    });
  }

  //削除
  Future<void> deleteProgram(String id) async {
    logger.d('deleteProgram');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await programRepository.deleteEvent(id);
      return [
        for (final product in state.value!)
          if (product.id != id) product
      ];
    });
  }

  Future<bool> registerProgram(Program data) async {
    if (data.id == null) {
      await addProgram(data);
    } else {
      await updateProgram(data);
    }
    return true;
  }

  Future<Program?> searchProgram(String eventId) async {
    return await programRepository.readEvent(eventId);
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
}
