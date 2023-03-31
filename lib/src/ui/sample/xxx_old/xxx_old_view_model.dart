import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../data/model/xxx/xxx_model.dart';
import '../../../data/repository/xxx/xxx_repository.dart';
import '../../../data/repository/xxx/xxx_repository_impl.dart';
import 'xxx_old_state.dart';

final logger = Logger();

final xxxOldViewModelProvider =
    StateNotifierProvider.autoDispose<XxxOldViewModel, AsyncValue<XxxState>>(
  (ref) => XxxOldViewModel(ref),
);

class XxxOldViewModel extends StateNotifier<AsyncValue<XxxState>> {
  final AutoDisposeStateNotifierProviderRef _ref;
  late final XxxRepository _xxxRepository;
  XxxOldViewModel(this._ref) : super(const AsyncValue.data(XxxState())) {
    _xxxRepository = _ref.read(xxxRepositoryProvider);
    load();
  }

  // repository
  // final XxxRepository xxxRepository = ref.read(xxxRepositoryProvider);

  // 取得
  Future<void> load() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final list = await _xxxRepository.readXxx();
      return XxxState(xxxList: list);
    });
  }

  // // 追加
  Future<void> addXxx({
    required String data,
  }) async {
    var xxx = Xxx(data: data);
    final List<Xxx> xxxList = state.value!.xxxList;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final id = await _xxxRepository.createXxx(xxx: xxx);
      final Xxx x = xxx.copyWith(id: id);
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
    final xxxList = state.value!.xxxList;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _xxxRepository.updateXxx(xxx: updateXxx);
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
    final xxxList = state.value!.xxxList;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _xxxRepository.deleteXxx(xxxId: id);
      final list = [
        for (final xxx in xxxList)
          if (xxx.id != id) xxx
      ];
      final data = XxxState(xxxList: list);
      return data;
    });
  }
}
