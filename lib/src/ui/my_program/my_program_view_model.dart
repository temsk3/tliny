import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tliny/src/data/repository/my_program_repository.dart';

import '../../data/model/my_program_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../utils/logger.dart';

part 'my_program_view_model.g.dart';

@riverpod
class MyProgramViewModel extends _$MyProgramViewModel {
  late final myProgramRepository = ref.read(myProgramRepositoryProvider);
  late final authRepository = ref.read(authRepositoryProvider);

  @override
  FutureOr<List<MyProgram>> build() {
    logger.d('MyProgramViewModel build');
    return readMyProgram();
  }

  // 取得
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
      state = await AsyncValue.guard(
        () async {
          return myProgramRepository.readMyPrograms(uid);
        },
      );
      logger.d('readMyProgram success');
      return myProgramRepository.readMyPrograms(uid);
    } on Exception catch (e, st) {
      logger.e('readMyProgram error: $e');
      state = AsyncError(e, st);
      return [];
    }
  }

  // 追加
  Future<void> addMyProgram(MyProgram data) async {
    logger.d('addMyProgram');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      state = const AsyncLoading();
      try {
        state = await AsyncValue.guard(
          () async {
            final myProgramId =
                await myProgramRepository.createMyProgram(uid, data);
            logger.d('addMyProgram success');
            return [...?state.value, data.copyWith(id: myProgramId)];
          },
        );
      } on Exception catch (e, st) {
        logger.e('addMyProgram error: $e');
        state = AsyncError(e, st);
      }
    }
  }

  // 更新
  Future<void> updateMyProgram(String uid, MyProgram data) async {
    logger.d('updateMyProgram');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      state = const AsyncLoading();
      try {
        state = await AsyncValue.guard(
          () async {
            final id = await myProgramRepository.updateMyProgram(uid, data);
            logger.d('updateMyProgram success');
            return [
              for (final myProgram in state.value!)
                if (myProgram.id == id) data else myProgram
            ];
          },
        );
      } on Exception catch (e, st) {
        logger.e('updateMyProgram error: $e');
        state = AsyncError(e, st);
      }
    }
  }

  //削除
  Future<void> deleteMyProgram(String myProgramId) async {
    logger.d('deleteMyProgram');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      state = const AsyncLoading();
      try {
        state = await AsyncValue.guard(
          () async {
            await myProgramRepository.deleteMyProgram(uid, myProgramId);
            logger.d('deleteMyProgram success');
            return [
              for (final myProgram in state.value!)
                if (myProgram.id != myProgramId) myProgram
            ];
          },
        );
      } on Exception catch (e, st) {
        logger.e('deleteMyProgram error: $e');
        state = AsyncError(e, st);
      }
    }
  }
}
