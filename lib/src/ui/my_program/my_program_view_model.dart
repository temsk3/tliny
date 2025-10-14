import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tliny/src/data/repository/my_program_repository.dart';

import '../../data/model/exception/app_exception.dart';
import '../../data/model/my_program_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../utils/logger.dart';
import '../common/loading_screen.dart';

part 'my_program_view_model.g.dart';

@riverpod
class MyProgramViewModel extends _$MyProgramViewModel {
  late final MyProgramRepository myProgramRepository = ref.read(
    myProgramRepositoryProvider,
  );
  late final AuthRepository authRepository = ref.read(authRepositoryProvider);

  @override
  FutureOr<List<MyProgram>> build() {
    logger.d('MyProgramViewModel build');
    return _readMyProgramDirectly();
  }

  // 直接マイプログラムを取得（buildメソッド用）
  Future<List<MyProgram>> _readMyProgramDirectly() async {
    logger.d('_readMyProgramDirectly');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      logger.d('uid is null');
      return [];
    }
    try {
      return await myProgramRepository.readMyPrograms(uid);
    } on AppException catch (e, st) {
      logger.e(
        '_readMyProgramDirectly: AppException - ${e.message}',
        stackTrace: st,
      );
      rethrow;
    } on Exception catch (e, st) {
      logger.e('_readMyProgramDirectly: Exception - $e', stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  // 取得（ローディング付き）
  Future<List<MyProgram>> readMyProgram() async {
    logger.d('readMyProgram');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      logger.d('uid is null');
      return [];
    }
    state = const AsyncLoading();
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      final programs = await loading.guardFuture(() async {
        return myProgramRepository.readMyPrograms(uid);
      });
      state = AsyncValue.data(programs);
      logger.d('readMyProgram success');
      return programs;
    } on AppException catch (e, st) {
      logger.e('readMyProgram: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('readMyProgram: Exception - $e', stackTrace: st);
      state = AsyncValue.error(
        GeneralException(message: e.toString(), stackTrace: st),
        st,
      );
      rethrow;
    }
  }

  // 追加
  Future<void> addMyProgram(MyProgram data) async {
    logger.d('addMyProgram');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      return;
    }
    state = const AsyncLoading();
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      final id = await loading.guardFuture(() async {
        return myProgramRepository.createMyProgram(uid, data);
      });
      final newProgram = data.copyWith(id: id);
      final updatedPrograms = [...?state.value, newProgram];
      state = AsyncValue.data(updatedPrograms);
    } on AppException catch (e, st) {
      logger.e('addMyProgram: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('addMyProgram: Exception - $e', stackTrace: st);
      state = AsyncValue.error(
        GeneralException(message: e.toString(), stackTrace: st),
        st,
      );
      rethrow;
    }
  }

  // 更新
  Future<void> updateMyProgram(MyProgram data) async {
    logger.d('updateMyProgram');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      return;
    }
    state = const AsyncLoading();
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      final id = await loading.guardFuture(() async {
        return myProgramRepository.updateMyProgram(uid, data);
      });
      final updatedPrograms = [
        for (final program in state.value!)
          if (program.id == id) data else program,
      ];
      state = AsyncValue.data(updatedPrograms);
    } on AppException catch (e, st) {
      logger.e('updateMyProgram: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('updateMyProgram: Exception - $e', stackTrace: st);
      state = AsyncValue.error(
        GeneralException(message: e.toString(), stackTrace: st),
        st,
      );
      rethrow;
    }
  }

  // 削除
  Future<void> deleteMyProgram(String id) async {
    logger.d('deleteMyProgram');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      return;
    }
    state = const AsyncLoading();
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      await loading.guardFuture(() async {
        await myProgramRepository.deleteMyProgram(uid, id);
      });
      final updatedPrograms = [
        for (final program in state.value!)
          if (program.id != id) program,
      ];
      state = AsyncValue.data(updatedPrograms);
    } on AppException catch (e, st) {
      logger.e('deleteMyProgram: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('deleteMyProgram: Exception - $e', stackTrace: st);
      state = AsyncValue.error(
        GeneralException(message: e.toString(), stackTrace: st),
        st,
      );
      rethrow;
    }
  }
}
