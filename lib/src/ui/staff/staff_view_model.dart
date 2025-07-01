import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tliny/src/data/repository/my_program_repository.dart';

import '../../data/model/exception/app_exception.dart';
import '../../data/model/my_program_model.dart';
import '../../data/model/staff_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/staff_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../utils/logger.dart';
import '../common/loading_screen.dart';

part 'staff_view_model.g.dart';

// final logger = Logger();

@riverpod
class StaffViewModel extends _$StaffViewModel {
  late final StaffRepository staffRepository = ref.watch(
    staffRepositoryProvider,
  );
  late final MyProgramRepository myProgramRepository = ref.watch(
    myProgramRepositoryProvider,
  );

  @override
  FutureOr<List<Staff>> build(String programId) {
    listStaff(programId);
    return [];
  }

  // Stream<Staff> getStaff(String programId, String uid) {
  //   return staffRepository.streamStaff(programId, uid);
  // }

  // 取得
  Future<void> listStaff(String programId) async {
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      final staffs = await loading.guardFuture(() async {
        return staffRepository.readStaffs(programId);
      });
      state = AsyncValue.data(staffs);
    } on AppException catch (e, st) {
      logger.e('listStaff: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('listStaff: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  // 追加
  Future<void> addStaff(String programId) async {
    logger.d('addStaff');
    final staff = Staff.empty();
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      try {
        final user = await ref.watch(userRepositoryProvider).readUser(uid);
        final Staff data;
        data = staff.copyWith(
          displayName: user.displayName,
          name: user.name,
          email: user.email,
        );
        //
        await myProgramRepository.createMyProgram(
          uid,
          MyProgram(programId: programId),
        );
        //
        final loading = ref.read(globalLoadingControllerProvider.notifier);
        final id = await loading.guardFuture(() async {
          return staffRepository.createStaff(programId, data, uid);
        });
        final updatedStaffs = [...?state.value, data.copyWith(id: id)];
        state = AsyncValue.data(updatedStaffs);
      } on AppException catch (e, st) {
        logger.e('addStaff: AppException - ${e.message}', stackTrace: st);
        state = AsyncValue.error(e, st);
        rethrow;
      } on Exception catch (e, st) {
        logger.e('addStaff: Exception - $e', stackTrace: st);
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
  Future<void> updateStaff(String programId, Staff data) async {
    logger.d('updateStaff');
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      final id = await loading.guardFuture(() async {
        return staffRepository.updateStaff(programId, data);
      });
      final updatedStaffs = [
        for (final staff in state.value!)
          if (staff.id == id) data else staff,
      ];
      state = AsyncValue.data(updatedStaffs);
    } on AppException catch (e, st) {
      logger.e('updateStaff: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('updateStaff: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  // 削除
  Future<void> deleteStaff(String programId, String id) async {
    logger.d('deleteStaff');
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      await loading.guardFuture(() async {
        await staffRepository.deleteStaff(programId, id);
      });
      final updatedStaffs = [
        for (final staff in state.value!)
          if (staff.id != id) staff,
      ];
      state = AsyncValue.data(updatedStaffs);
    } on AppException catch (e, st) {
      logger.e('deleteStaff: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('deleteStaff: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  // 検索
  // Future<Staff> searchStaff(String programId, String uid) async {
  //   return await staffRepository.searchStaff(programId, uid);
  // }
  Staff? searchStaff(String programId, String uid) {
    final staff = state.value?.firstWhere((staff) => staff.id == uid);
    return staff;
  }
}
