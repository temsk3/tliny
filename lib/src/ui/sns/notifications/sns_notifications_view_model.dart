import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/model/sns/notification_model.dart';
import '../../../data/repository/sns_repository.dart';
import '../../../utils/logger.dart';

part 'sns_notifications_view_model.g.dart';

@riverpod
class SnsNotificationsViewModel extends _$SnsNotificationsViewModel {
  bool _hasMore = true;
  bool _isLoading = false;

  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;

  @override
  FutureOr<List<AppNotification>> build() async {
    logger.d('SnsNotificationsViewModel.build() called');
    return loadNotifications();
  }

  Future<List<AppNotification>> loadNotifications({
    bool refresh = false,
  }) async {
    if (_isLoading) return state.value ?? [];

    try {
      _isLoading = true;

      if (refresh) {
        _hasMore = true;
      }

      final snsRepository = ref.read(snsRepositoryProvider);
      final notifications = await snsRepository.getNotifications(
        limit: 20,
        unreadOnly: false,
      );

      _hasMore = notifications.length >= 20;
      logger.d(
        'loadNotifications success: ${notifications.length} notifications loaded',
      );

      return notifications;
    } catch (e, st) {
      logger.e('loadNotifications error: $e', error: e, stackTrace: st);
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  Future<void> refreshNotifications() async {
    try {
      final notifications = await loadNotifications(refresh: true);
      state = AsyncValue.data(notifications);
    } catch (e, st) {
      logger.e('refreshNotifications error: $e', error: e, stackTrace: st);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      final snsRepository = ref.read(snsRepositoryProvider);
      await snsRepository.markNotificationAsRead(notificationId);

      // 既読状態を反映
      final currentNotifications = state.value ?? [];
      final updatedNotifications = currentNotifications.map((notification) {
        if (notification.id == notificationId) {
          return notification.copyWith(isRead: true, readAt: DateTime.now());
        }
        return notification;
      }).toList();

      state = AsyncValue.data(updatedNotifications);
      logger.d('markAsRead success: $notificationId');
    } catch (e, st) {
      logger.e('markAsRead error: $e', error: e, stackTrace: st);
      // エラーが発生した場合はスナックバーなどで通知することを想定
    }
  }
}
