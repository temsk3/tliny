import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/exception/app_exception.dart';
import '../../data/model/my_program_model.dart';
import '../../data/model/program_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/my_program_repository.dart';
import '../../data/repository/product_repository.dart';
import '../../data/repository/program_repository.dart';
import '../../data/repository/staff_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../utils/logger.dart';
import '../common/loading_screen.dart';

part 'program_view_model.g.dart';

@riverpod
class ProgramViewModel extends _$ProgramViewModel {
  late final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  late final UserRepository userRepository = ref.watch(userRepositoryProvider);
  late final MyProgramRepository myProgramRepository = ref.watch(
    myProgramRepositoryProvider,
  );
  late final ProductRepository productRepository = ref.watch(
    productRepositoryProvider,
  );
  late final StaffRepository staffRepository = ref.watch(
    staffRepositoryProvider,
  );
  late final ProgramRepository programRepository = ref.watch(
    programRepositoryProvider,
  );

  @override
  FutureOr<List<Program>> build() {
    return _readProgramsDirectly();
  }

  // 直接プログラムを取得（buildメソッド用）
  Future<List<Program>> _readProgramsDirectly() async {
    logger.d('_readProgramsDirectly');
    try {
      return await programRepository.readEvents();
    } on AppException catch (e, st) {
      logger.e(
        '_readProgramsDirectly: AppException - ${e.message}',
        stackTrace: st,
      );
      rethrow;
    } on Exception catch (e, st) {
      logger.e('_readProgramsDirectly: Exception - $e', stackTrace: st);
      throw GeneralException(
        message: e.toString(),
        stackTrace: st,
      
      );
    }
  }

  // 取得（ローディング付き）
  Future<List<Program>> readPrograms() async {
    logger.d('readProgram');
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      final programs = await loading.guardFuture(() async {
        return programRepository.readEvents();
      });
      state = AsyncValue.data(programs);
      return programs;
    } on AppException catch (e, st) {
      logger.e('readPrograms: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('readPrograms: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  // 追加
  Future<void> addProgram(Program data) async {
    logger.d('addProgram');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    final newData = data.copyWith(organizerId: uid);
    if (uid != null) {
      try {
        final loading = ref.read(globalLoadingControllerProvider.notifier);
        final id = await loading.guardFuture(() async {
          final programId = await programRepository.createEvent(newData);
          await myProgramRepository.createMyProgram(
            uid,
            MyProgram(programId: programId),
          );
          return programId;
        });
        final updatedPrograms = [...?state.value, data.copyWith(id: id)];
        state = AsyncValue.data(updatedPrograms);
      } on AppException catch (e, st) {
        logger.e('addProgram: AppException - ${e.message}', stackTrace: st);
        state = AsyncValue.error(e, st);
        rethrow;
      } on Exception catch (e, st) {
        logger.e('addProgram: Exception - $e', stackTrace: st);
        final appException = GeneralException(
          message: e.toString(),
          stackTrace: st,
        );
        state = AsyncValue.error(appException, st);
        rethrow;
      }
    }
  }

  // 更新
  Future<void> updateProgram(Program data) async {
    logger.d('updateProgram');
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      final id = await loading.guardFuture(() async {
        return programRepository.updateEvent(data);
      });
      final updatedPrograms = [
        for (final program in state.value!)
          if (program.id == id) data else program,
      ];
      state = AsyncValue.data(updatedPrograms);
    } on AppException catch (e, st) {
      logger.e('updateProgram: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('updateProgram: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  //削除
  Future<void> deleteProgram(String id) async {
    logger.d('deleteProgram');
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      await loading.guardFuture(() async {
        await programRepository.deleteEvent(id);
      });
      final updatedPrograms = [
        for (final program in state.value!)
          if (program.id != id) program,
      ];
      state = AsyncValue.data(updatedPrograms);
    } on AppException catch (e, st) {
      logger.e('deleteProgram: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('deleteProgram: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
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
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      return await loading.guardFuture(() async {
        return programRepository.readEvent(eventId);
      });
    } on AppException catch (e, st) {
      logger.e('searchProgram: AppException - ${e.message}', stackTrace: st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('searchProgram: Exception - $e', stackTrace: st);
      throw GeneralException(
        message: e.toString(),
        stackTrace: st,
      
      );
    }
  }

  //
  //
  Future<bool> get checkAccount async {
    try {
      final userId = await authRepository.userId.last;
      if (userId != null) {
        final loading = ref.read(globalLoadingControllerProvider.notifier);
        return await loading.guardFuture(() async {
          return userRepository.checkExistenceAccount(userId);
        });
      } else {
        return false;
      }
    } on AppException catch (e, st) {
      logger.e('checkAccount: AppException - ${e.message}', stackTrace: st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('checkAccount: Exception - $e', stackTrace: st);
      throw GeneralException(
        message: e.toString(),
        stackTrace: st,
      
      );
    }
  }
}
