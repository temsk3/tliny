import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tliny/src/data/repository/my_program_repository.dart';

import '../../data/model/my_program_model.dart';
import '../../data/model/staff_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/staff_repository.dart';
import '../../data/repository/user_repository.dart';

part 'staff_view_model.g.dart';

final logger = Logger();

@riverpod
class StaffViewModel extends _$StaffViewModel {
  late final staffRepository = ref.watch(staffRepositoryProvider);
  late final myProgramRepository = ref.watch(myProgramRepositoryProvider);

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
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await staffRepository.readStaffs(programId);
    });
    // return state.value!;
  }

  // 追加
  Future<void> addStaff(String programId) async {
    logger.d('addStaff');
    final staff = Staff.empty();
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
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
      state = const AsyncLoading();
      state = await AsyncValue.guard(() async {
        final id = await staffRepository.createStaff(programId, data, uid);
        return [...?state.value, data.copyWith(id: id)];
      });
    }
  }

  // 更新
  Future<void> updateStaff(String programId, Staff data) async {
    logger.d('updateStaff');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final id = await staffRepository.updateStaff(programId, data);
      return [
        for (final staff in state.value!)
          if (staff.id == id) data else staff
      ];
    });
  }

  // 削除
  Future<void> deleteStaff(String programId, String id) async {
    logger.d('deleteStaff');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await staffRepository.deleteStaff(programId, id);
      return [
        for (final staff in state.value!)
          if (staff.id != id) staff
      ];
    });
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
