import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../data/model/xxx/xxx_model.dart';
import '../../../data/repository/xxx/xxx_repository.dart';
import '../../../data/repository/xxx/xxx_repository_impl.dart';

// part 'xxx_stream_view_model.g.dart';

final logger = Logger();

final xxxStreamViewModelProvider = Provider(
  (ref) => XxxStreamViewModel(ref),
);

class XxxStreamViewModel {
  XxxStreamViewModel(this._ref);
  final Ref _ref;

  // repository
  late final XxxRepository xxxRepository = _ref.read(xxxRepositoryProvider);

  // 取得

  // 追加
  Future<void> addXxx({
    required String data,
  }) async {
    var xxx = Xxx(data: data);
    await xxxRepository.createXxx(xxx: xxx);
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
    await xxxRepository.updateXxx(xxx: updateXxx);
  }

  //削除
  Future<void> deleteXxx({required String id}) async {
    await xxxRepository.deleteXxx(xxxId: id);
  }
}
