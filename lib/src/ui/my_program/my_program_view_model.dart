import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tliny/src/data/repository/my_program_repository.dart';

import '../../data/model/my_program_model.dart';
import '../../data/repository/auth_repository.dart';

part 'my_program_view_model.g.dart';

final logger = Logger();

@riverpod
class MyProgramViewModel extends _$MyProgramViewModel {
  late final myProgramRepository = ref.read(myProgramRepositoryProvider);
  late final authRepository = ref.read(authRepositoryProvider);

  @override
  FutureOr<List<MyProgram>> build() {
    return readMyProgram();
  }

  // 取得
  Future<List<MyProgram>> readMyProgram() async {
    logger.d('readMyProgram');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      return [];
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        return myProgramRepository.readMyPrograms(uid);
      },
    );
    return myProgramRepository.readMyPrograms(uid);
  }

  // 追加
  Future<void> addMyProgram(MyProgram data) async {
    logger.d('addMyProgram');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      state = const AsyncLoading();
      state = await AsyncValue.guard(
        () async {
          final myProgramId =
              await myProgramRepository.createMyProgram(uid, data);
          return [...?state.value, data.copyWith(id: myProgramId)];
        },
      );
    }
  }

  // 更新
  Future<void> updateMyProgram(String uid, MyProgram data) async {
    logger.d('updateMyProgram');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      state = const AsyncLoading();
      state = await AsyncValue.guard(
        () async {
          final id = await myProgramRepository.updateMyProgram(uid, data);
          return [
            for (final myProgram in state.value!)
              if (myProgram.id == id) data else myProgram
          ];
        },
      );
    }
  }

  //削除
  Future<void> deleteMyProgram(String myProgramId) async {
    logger.d('deleteMyProgram');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      state = const AsyncLoading();
      state = await AsyncValue.guard(
        () async {
          await myProgramRepository.deleteMyProgram(uid, myProgramId);
          return [
            for (final myProgram in state.value!)
              if (myProgram.id != myProgramId) myProgram
          ];
        },
      );
    }
  }
}
