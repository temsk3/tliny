import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tliny/src/data/repository/order_repository.dart';

import '../../data/model/exception/app_exception.dart';
import '../../data/model/order_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../utils/logger.dart';
import '../common/loading_screen.dart';

part 'order_view_model.g.dart';

@riverpod
class OrderViewModel extends _$OrderViewModel {
  late final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  late final OrderRepository oderRepository = ref.watch(
    orderRepositoryProvider,
  );

  @override
  FutureOr<List<Order>> build() {
    return _readOrderDirectly();
  }

  // 直接注文を取得（buildメソッド用）
  Future<List<Order>> _readOrderDirectly() async {
    logger.d('_readOrderDirectly');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      logger.w('_readOrderDirectly: ユーザーIDがnullです');
      return [];
    }

    logger.d('_readOrderDirectly: ユーザーID=$uid');
    try {
      final orders = await oderRepository.readOrder(uid);
      logger.d('_readOrderDirectly: 注文取得完了 count=${orders.length}');
      return orders;
    } on AppException catch (e, st) {
      logger.e(
        '_readOrderDirectly: AppException - ${e.message}',
        stackTrace: st,
      );
      rethrow;
    } on Exception catch (e, st) {
      logger.e('_readOrderDirectly: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      rethrow;
    }
  }

  // 取得（ローディング付き）
  Future<List<Order>> readOrder() async {
    logger.d('readOrder');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      return [];
    }
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      final orders = await loading.guardFuture(() async {
        return oderRepository.readOrder(uid);
      });
      state = AsyncValue.data(orders);
      return orders;
    } on AppException catch (e, st) {
      logger.e('readOrder: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('readOrder: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }
}
