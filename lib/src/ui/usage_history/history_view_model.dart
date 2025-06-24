import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/ticket_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/ticket_repository.dart';
import '../../utils/logger.dart';

part 'history_view_model.g.dart';

// final logger = Logger();

@riverpod
class UsageHistoryViewModel extends _$UsageHistoryViewModel {
  late final usageHistoryRepository = ref.read(usageHistoryRepositoryProvider);
  late final authRepository = ref.read(authRepositoryProvider);

  @override
  FutureOr<List<UsageHistory>> build() {
    return readUsageHistory();
  }

  // 取得
  Future<List<UsageHistory>> readUsageHistory() async {
    logger.d('readUsageHistory');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      return [];
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        return usageHistoryRepository.readUsageHistory(uid);
      },
    );
    return usageHistoryRepository.readUsageHistory(uid);
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
      state = const AsyncLoading();
      state = await AsyncValue.guard(
        () async {
          final id = await usageHistoryRepository.createUsageHistory(uid, data);
          return [...?state.value, data.copyWith(id: id)];
        },
      );
    }
  }

  // 更新
  Future<void> updateUsageHistory(String uid, UsageHistory data) async {
    logger.d('updateUsageHistory');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      state = const AsyncLoading();
      state = await AsyncValue.guard(
        () async {
          final id = await usageHistoryRepository.updateUsageHistory(uid, data);
          return [
            for (final ticket in state.value!)
              if (ticket.id == id) data else ticket
          ];
        },
      );
    }
  }
}
