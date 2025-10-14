import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/sns/notification_model.dart';
import '../../common/loading_screen.dart';
import 'sns_notifications_view_model.dart';
import 'widget/notification_card.dart';

class SnsNotificationsPage extends HookConsumerWidget {
  const SnsNotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsState = ref.watch(snsNotificationsViewModelProvider);
    final notificationsNotifier = ref.read(
      snsNotificationsViewModelProvider.notifier,
    );
    final scrollController = useScrollController();

    // スクロール監視でページネーション（将来の拡張用）
    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * 0.8) {
          // TODO: loadMoreNotifications実装
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('通知'),
        actions: [
          // 全て既読にするボタン（将来の拡張用）
          // IconButton(
          //   icon: const Icon(Icons.done_all),
          //   onPressed: () => _markAllAsRead(context, notificationsNotifier),
          // ),
        ],
      ),
      body: notificationsState.when(
        data:
            (notifications) => RefreshIndicator(
              onRefresh: notificationsNotifier.refreshNotifications,
              child:
                  notifications.isEmpty
                      ? const Center(
                        child: Text(
                          '通知はありません',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                      : ListView.builder(
                        controller: scrollController,
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final notification = notifications[index];
                          return NotificationCard(
                            notification: notification,
                            onTap:
                                () => _handleNotificationTap(
                                  context,
                                  notification,
                                  notificationsNotifier,
                                ),
                          );
                        },
                      ),
            ),
        loading: () => const LoadingScreen(),
        error:
            (error, stackTrace) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('通知の読み込みに失敗しました'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: notificationsNotifier.refreshNotifications,
                    child: const Text('再試行'),
                  ),
                ],
              ),
            ),
      ),
    );
  }

  void _handleNotificationTap(
    BuildContext context,
    AppNotification notification,
    SnsNotificationsViewModel notifier,
  ) {
    // 未読の場合は既読にする
    if (notification.isRead != true) {
      notifier.markAsRead(notification.id!);
    }

    // 通知タイプに応じた遷移処理
    switch (notification.type) {
      case NotificationType.follow:
        // プロフィール画面に遷移
        // TODO: プロフィール画面実装後に追加
        _showSnackBar(context, 'プロフィール画面への遷移（未実装）');
        break;
      case NotificationType.like:
      case NotificationType.comment:
        // 投稿詳細画面に遷移
        // TODO: 投稿詳細画面実装後に追加
        _showSnackBar(context, '投稿詳細画面への遷移（未実装）');
        break;
      case NotificationType.message:
        // メッセージ画面に遷移
        // TODO: メッセージ画面実装後に追加
        _showSnackBar(context, 'メッセージ画面への遷移（未実装）');
        break;
      case NotificationType.eventReminder:
      case NotificationType.purchaseConfirmation:
      case NotificationType.ticketIssued:
      case NotificationType.paymentSuccess:
      case NotificationType.paymentFailed:
        // イベントや決済関連の画面に遷移
        _showSnackBar(context, '関連画面への遷移（未実装）');
        break;
      default:
        // デフォルトは何もしない
        break;
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
