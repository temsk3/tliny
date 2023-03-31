import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/model/xxx/xxx_model.dart';
import '../../../data/repository/xxx/xxx_repository.dart';
import '../../../data/repository/xxx/xxx_repository_impl.dart';
import 'xxx_state.dart';

part 'xxx_view_model.g.dart';

final logger = Logger();

@riverpod
class XxxViewModel extends _$XxxViewModel {
  @override
  FutureOr<XxxState> build() {
    load();
    return const XxxState();
  }

  // repository
  late final XxxRepository xxxRepository = ref.read(xxxRepositoryProvider);

  // 取得
  Future<void> load() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final list = await xxxRepository.readXxx();
      return XxxState(xxxList: list);
    });
  }

  // // 追加
  Future<void> addXxx({
    required String data,
  }) async {
    var xxx = Xxx(data: data);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final id = await xxxRepository.createXxx(xxx: xxx);
      final Xxx x = xxx.copyWith(id: id);
      final List<Xxx> xxxList = state.value!.xxxList;
      final List<Xxx> list = [...xxxList, x];
      return XxxState(xxxList: list);
    });
  }

  // 更新
  Future<void> updateXxx({
    required String id,
    required String data,
  }) async {
    var updateXxx = Xxx(
      id: id,
      data: data,
    );
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await xxxRepository.updateXxx(xxx: updateXxx);
      final xxxList = state.value!.xxxList;
      final list = [
        for (final xxx in xxxList)
          if (xxx.id == updateXxx.id) updateXxx else xxx
      ];
      final data = XxxState(xxxList: list);
      return data;
    });
  }

  //削除
  Future<void> deleteXxx({required String id}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await xxxRepository.deleteXxx(xxxId: id);
      final xxxList = state.value!.xxxList;
      final list = [
        for (final xxx in xxxList)
          if (xxx.id != id) xxx
      ];
      final data = XxxState(xxxList: list);
      return data;
    });
  }
}
