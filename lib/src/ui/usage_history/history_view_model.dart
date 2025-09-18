import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/exception/app_exception.dart';
import '../../data/model/ticket_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/ticket_repository.dart';
import '../../utils/logger.dart';
import '../common/loading_screen.dart';

part 'history_view_model.g.dart';

// final logger = Logger();

@riverpod
class UsageHistoryViewModel extends _$UsageHistoryViewModel {
  late final UsageHistoryRepository usageHistoryRepository = ref.read(
    usageHistoryRepositoryProvider,
  );
  late final AuthRepository authRepository = ref.read(authRepositoryProvider);

  @override
  FutureOr<List<UsageHistory>> build() {
    return _readUsageHistoryDirectly();
  }

  // 直接利用履歴を取得（buildメソッド用）
  Future<List<UsageHistory>> _readUsageHistoryDirectly() async {
    logger.d('_readUsageHistoryDirectly');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      logger.w('_readUsageHistoryDirectly: uid is null');
      return [];
    }
    logger.d('_readUsageHistoryDirectly: uid=$uid');
    try {
      final result = await usageHistoryRepository.readUsageHistory(uid);
      logger.d('_readUsageHistoryDirectly: result count=${result.length}');
      for (final history in result) {
        logger.d(
          '_readUsageHistoryDirectly: history=${history.eventId}, useTicket=${history.useTicket}',
        );
      }
      return result;
    } on AppException catch (e, st) {
      logger.e(
        '_readUsageHistoryDirectly: AppException - ${e.message}',
        stackTrace: st,
      );
      rethrow;
    } on Exception catch (e, st) {
      logger.e('_readUsageHistoryDirectly: Exception - $e', stackTrace: st);
      throw GeneralException(
        message: e.toString(),
        stackTrace: st,
      
      );
    }
  }

  // 取得（ローディング付き）
  Future<List<UsageHistory>> readUsageHistory() async {
    logger.d('readUsageHistory');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      return [];
    }
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      final history = await loading.guardFuture(() async {
        return usageHistoryRepository.readUsageHistory(uid);
      });
      state = AsyncValue.data(history);
      return history;
    } on AppException catch (e, st) {
      logger.e('readUsageHistory: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('readUsageHistory: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  // 追加
  Future<void> addUsageHistory(
    String uid,
    String eventId,
    List<String> useTicket,
  ) async {
    logger.d('addUsageHistory');
    final uidAsyncValue = ref.watch(userIdProvider);
    final id = uidAsyncValue.value;
    if (id != null) {
      final data = UsageHistory(
        dateOfUse: DateTime.now(),
        eventId: eventId,
        receptionistId: id,
        useTicket: useTicket,
      );
      try {
        final loading = ref.read(globalLoadingControllerProvider.notifier);
        final historyId = await loading.guardFuture(() async {
          return usageHistoryRepository.createUsageHistory(uid, data);
        });
        final updatedHistory = [...?state.value, data.copyWith(id: historyId)];
        state = AsyncValue.data(updatedHistory);
      } on AppException catch (e, st) {
        logger.e(
          'addUsageHistory: AppException - ${e.message}',
          stackTrace: st,
        );
        state = AsyncValue.error(e, st);
        rethrow;
      } on Exception catch (e, st) {
        logger.e('addUsageHistory: Exception - $e', stackTrace: st);
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
  Future<void> updateUsageHistory(String uid, UsageHistory data) async {
    logger.d('updateUsageHistory');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      try {
        final loading = ref.read(globalLoadingControllerProvider.notifier);
        final id = await loading.guardFuture(() async {
          return usageHistoryRepository.updateUsageHistory(uid, data);
        });
        final updatedHistory = [
          for (final ticket in state.value!)
            if (ticket.id == id) data else ticket,
        ];
        state = AsyncValue.data(updatedHistory);
      } on AppException catch (e, st) {
        logger.e(
          'updateUsageHistory: AppException - ${e.message}',
          stackTrace: st,
        );
        state = AsyncValue.error(e, st);
        rethrow;
      } on Exception catch (e, st) {
        logger.e('updateUsageHistory: Exception - $e', stackTrace: st);
        final appException = GeneralException(
          message: e.toString(),
          stackTrace: st,
        );
        state = AsyncValue.error(appException, st);
        rethrow;
      }
    }
  }
}
