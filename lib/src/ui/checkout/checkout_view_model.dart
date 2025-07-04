import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';

import '../../data/model/exception/app_exception.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/stripe_repository.dart';
import '../../settings/routes/routes.dart';
import '../../utils/logger.dart';
import '../common/loading_screen.dart';

part 'checkout_view_model.g.dart';

@riverpod
class StripeCheckoutViewModel extends _$StripeCheckoutViewModel {
  /// 依存するリポジトリを初期化
  late final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  late final StripeRepository stripeRepository = ref.watch(
    stripeRepositoryProvider,
  );

  /// ViewModel が初期化された際に呼ばれる
  @override
  FutureOr<void> build() {}

  /// 指定された URL をブラウザで開く
  Future<void> openUrl(String url) async {
    logger.d('openUrl: url=$url', time: DateTime.now());
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        // await launchUrl(Uri.parse(url), webOnlyWindowName: '_self');
        await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
      } else {
        logger.e('openUrl: Could not launch URL');
        throw ArgumentError('Error launching $url');
      }
    } on AppException catch (e, st) {
      logger.e('openUrl: AppException - ${e.message}', stackTrace: st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('openUrl: error=$e, stackTrace=$st', time: DateTime.now());
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// チェックアウトセッションを作成し、支払い処理を開始する
  Future<bool> getCheckoutPaymentLink(
    // StackRouter appRoute,
    BuildContext context,
    String eventId,
  ) async {
    logger.d('getCheckoutPaymentLink: eventId=$eventId', time: DateTime.now());
    try {
      // チェックアウトセッションを作成
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      final response = await loading.guardFuture(() async {
        return stripeRepository.paymentCheckoutSession(eventId);
      });
      // チェックアウトセッションの URL、セッションID、アカウントID、注文ID を取得
      final url = response['url'].toString();
      final sessionId = response['checkoutSessionId'].toString();
      final accountId = response['accountId'].toString();
      final orderId = response['orderId'].toString();
      // ログ出力
      logger
        ..d('getCheckoutPaymentLink: url=$url', time: DateTime.now())
        ..d(
          'getCheckoutPaymentLink: status=${response['status']}',
          time: DateTime.now(),
        )
        ..d(
          'getCheckoutPaymentLink: sessionId=$sessionId',
          time: DateTime.now(),
        )
        ..d(
          'getCheckoutPaymentLink: lineItem=${response['lineItem']}',
          time: DateTime.now(),
        )
        ..d(
          'getCheckoutPaymentLink: accountId=$accountId',
          time: DateTime.now(),
        )
        ..d('getCheckoutPaymentLink: orderId=$orderId', time: DateTime.now());
      // 画面がマウントされている場合、支払い処理を開始
      if (context.mounted) {
        await paymentWithBrowser(
          // appRoute,
          context,
          url,
          sessionId,
          accountId,
          orderId,
        );
      }
      return true;
    } on AppException catch (e, st) {
      logger.e(
        'getCheckoutPaymentLink: AppException - ${e.message}',
        stackTrace: st,
      );
      return false;
    } on Exception catch (e, st) {
      logger.e(
        'getCheckoutPaymentLinkError: error=$e, stackTrace=$st',
        time: DateTime.now(),
      );
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      return false;
    }
  }

  /// ブラウザで支払い処理を行う
  Future<Map<String, dynamic>> paymentWithBrowser(
    // StackRouter appRoute,
    BuildContext context,
    String url,
    String sessionId,
    String accountId,
    String orderId,
  ) async {
    logger.d(
      'paymentWithBrowser: url=$url, sessionId=$sessionId, accountId=$accountId, orderId=$orderId',
      time: DateTime.now(),
    );
    // 支払い処理の完了を通知するための Completer を作成
    final completer = Completer<Map<String, dynamic>>();
    // フォーカスイベントのリスナーを作成
    late StreamSubscription<html.Event> subscription;
    // フォーカスイベントが発生した場合、チェックアウトセッションの状態を取得
    subscription = html.window.onFocus.listen((event) async {
      logger.d('paymentWithBrowser: onFocus', time: DateTime.now());
      try {
        final loading = ref.read(globalLoadingControllerProvider.notifier);
        final intent = await loading.guardFuture(() async {
          return stripeRepository.retrieveCheckoutSession(sessionId, accountId);
        });
        // 支払いが完了した場合、チェックアウト成功画面へ遷移
        if (intent['payment_status'] != 'unpaid') {
          logger.d(
            'paymentWithBrowser: payment_status=${intent['payment_status']}',
            time: DateTime.now(),
          );
          // await appRoute.replace(CheckoutSuccessRoute(sessionId: sessionId));
          CheckoutSuccessRoute(sessionId: sessionId).go(context);
          // リスナーを解除
          await subscription.cancel();
          // 3 秒間待機
          await Future.delayed(const Duration(seconds: 3));
          // Completer を完了
          completer.complete(intent);
          return;
        }
      } on AppException catch (e, st) {
        logger.e(
          'paymentWithBrowser: AppException - ${e.message}',
          stackTrace: st,
        );
        completer.completeError(e);
      } on Exception catch (e, st) {
        logger.e('paymentWithBrowser: Exception - $e', stackTrace: st);
        final appException = GeneralException(
          message: e.toString(),
          stackTrace: st,
        );
        completer.completeError(appException);
      }
    });

    // チェックアウトセッションの URL をブラウザで開く
    await openUrl(url);

    // 画面がマウントされている場合、ダイアログを表示
    if (context.mounted) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder:
            (_) => SimpleDialog(
              title: const Text(
                // 'awaiting payment. Complete the payment in the window that opens.',
                '支払いを待っています。 支払い画面で支払いを完了して下さい。',
                // l10n.awaitingPayment,
              ),
              children: [
                SimpleDialogOption(
                  // child: Text(l10n.cancel),
                  child: const Text('キャンセル'),
                  onPressed: () async {
                    logger.d(
                      'paymentWithBrowser: cancel',
                      time: DateTime.now(),
                    );
                    final loading = ref.read(
                      globalLoadingControllerProvider.notifier,
                    );
                    try {
                      await loading.guardFuture(() async {
                        await stripeRepository.cancelOrder(orderId);
                      });
                      // ローディングを明示的に解除
                      loading.stopLoading();
                      // チェックアウトキャンセル画面へ遷移
                      CheckoutCancelRoute(sessionId: sessionId).go(context);
                      await subscription.cancel();
                      completer.complete(
                        await stripeRepository.retrieveCheckoutSession(
                          sessionId,
                          accountId,
                        ),
                      );
                    } on AppException catch (e, st) {
                      loading.stopLoading();
                      logger.e(
                        'paymentWithBrowser: cancel AppException - [${e.message}',
                        stackTrace: st,
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('キャンセル処理に失敗しました: ${e.message}'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      completer.completeError(e);
                    } on Exception catch (e, st) {
                      loading.stopLoading();
                      logger.e(
                        'paymentWithBrowser: cancel Exception - $e',
                        stackTrace: st,
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('キャンセル処理に失敗しました'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      completer.completeError(e);
                    }
                  },
                ),
                SimpleDialogOption(
                  // child: Text(l10n.openNewWindow),
                  child: const Text('支払い画面を開く'),
                  onPressed: () {
                    logger.d(
                      'paymentWithBrowser: open new window',
                      time: DateTime.now(),
                    );
                    // チェックアウトセッションの URL をブラウザで開く
                    openUrl(url);
                  },
                ),
              ],
            ),
      );
    }

    // Completer の Future を返す
    return completer.future;
  }

  /// チェックアウトセッションをキャンセルする
  Future<void> cancelCheckout(String sessionId) async {
    logger.d('cancelCheckout: sessionId=$sessionId', time: DateTime.now());
    final loading = ref.read(globalLoadingControllerProvider.notifier);
    try {
      // ユーザーIDを取得
      final uid = ref.watch(userIdProvider).value;
      if (uid == null) {
        logger.w(
          'cancelCheckout: uid is null, skipping cancellation',
          time: DateTime.now(),
        );
        return;
      }

      logger.d('cancelCheckout: uid=$uid', time: DateTime.now());

      // 決済情報を取得
      final settlement = await loading.guardFuture(() async {
        return stripeRepository.getSettlement(uid, sessionId);
      });

      final orderId = settlement['order_id'].toString();
      logger.d('cancelCheckout: orderId=$orderId', time: DateTime.now());

      // 注文をキャンセル
      await loading.guardFuture(() async {
        await stripeRepository.cancelOrder(orderId);
      });

      logger.d('cancelCheckout: completed successfully', time: DateTime.now());
    } on AppException catch (e, st) {
      logger.e('cancelCheckout: AppException - ${e.message}', stackTrace: st);
      // エラーが発生しても処理を継続（ローディングは自動で解除される）
      // エラーは上位でハンドリングされるため、ここではrethrowしない
    } on Exception catch (e, st) {
      logger.e(
        'cancelCheckout: error=$e, stackTrace=$st',
        time: DateTime.now(),
      );
      // エラーが発生しても処理を継続（ローディングは自動で解除される）
      // エラーは上位でハンドリングされるため、ここではrethrowしない
    }
  }
}
