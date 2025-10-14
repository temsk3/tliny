import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tliny/l10n/app_localizations.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';

import '../../data/model/cart_model.dart';
import '../../data/model/exception/app_exception.dart';
import '../../data/model/order_model.dart';
import '../../data/model/product_model.dart';
import '../../data/model/program_model.dart';
import '../../data/model/ticket_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/order_repository.dart';
import '../../data/repository/product_repository.dart';
import '../../data/repository/stripe_repository.dart';
import '../../data/repository/ticket_repository.dart';
import '../../settings/routes/routes.dart';
import '../../utils/logger.dart';
import '../cart/cart_view_model.dart';
import '../common/error_handler.dart';
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
      throw GeneralException(message: e.toString(), stackTrace: st);
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

      // エラーをアラートダイアログで表示
      if (context.mounted) {
        final l10n = AppLocalizations.of(context)!;
        ErrorHandler.showError(
          context,
          e,
          l10n,
          errorContext: 'getCheckoutPaymentLink',
          onRetry: () => getCheckoutPaymentLink(context, eventId),
        );
      }
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

      // エラーをアラートダイアログで表示
      if (context.mounted) {
        final l10n = AppLocalizations.of(context)!;
        ErrorHandler.showError(
          context,
          appException,
          l10n,
          errorContext: 'getCheckoutPaymentLink',
          onRetry: () => getCheckoutPaymentLink(context, eventId),
        );
      }
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
          if (context.mounted) {
            context.go(
              '${AppRoutes.checkoutSuccessPage}?session_id=$sessionId',
            );
          }
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

        // エラーをアラートダイアログで表示
        if (context.mounted) {
          final l10n = AppLocalizations.of(context)!;
          ErrorHandler.showError(
            context,
            e,
            l10n,
            errorContext: 'paymentWithBrowser',
            onRetry:
                () => paymentWithBrowser(
                  context,
                  url,
                  sessionId,
                  accountId,
                  orderId,
                ),
          );
        }
        completer.completeError(e);
      } on Exception catch (e, st) {
        logger.e('paymentWithBrowser: Exception - $e', stackTrace: st);
        final appException = GeneralException(
          message: e.toString(),
          stackTrace: st,
        );

        // エラーをアラートダイアログで表示
        if (context.mounted) {
          final l10n = AppLocalizations.of(context)!;
          ErrorHandler.showError(
            context,
            appException,
            l10n,
            errorContext: 'paymentWithBrowser',
            onRetry:
                () => paymentWithBrowser(
                  context,
                  url,
                  sessionId,
                  accountId,
                  orderId,
                ),
          );
        }
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
                      if (context.mounted) {
                        context.go(
                          '${AppRoutes.checkoutCancelPage}?session_id=$sessionId',
                        );
                      }
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
                        'paymentWithBrowser: cancel AppException -  [${e.message}',
                        stackTrace: st,
                      );
                      if (context.mounted) {
                        final l10n = AppLocalizations.of(context)!;
                        ErrorHandler.showErrorSnackBar(context, e, l10n);
                      }
                      completer.completeError(e);
                    } on Exception catch (e, st) {
                      loading.stopLoading();
                      logger.e(
                        'paymentWithBrowser: cancel Exception - $e',
                        stackTrace: st,
                      );
                      if (context.mounted) {
                        final l10n = AppLocalizations.of(context)!;
                        ErrorHandler.showErrorSnackBar(context, e, l10n);
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
    try {
      return await completer.future;
    } on AppException catch (e, st) {
      logger.e(
        'paymentWithBrowser: Completer AppException - ${e.message}',
        stackTrace: st,
      );

      // エラーをアラートダイアログで表示
      if (context.mounted) {
        final l10n = AppLocalizations.of(context)!;
        ErrorHandler.showError(
          context,
          e,
          l10n,
          errorContext: 'paymentWithBrowser_completer',
          onRetry:
              () => paymentWithBrowser(
                context,
                url,
                sessionId,
                accountId,
                orderId,
              ),
        );
      }
      rethrow;
    } on Exception catch (e, st) {
      logger.e('paymentWithBrowser: Completer Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );

      // エラーをアラートダイアログで表示
      if (context.mounted) {
        final l10n = AppLocalizations.of(context)!;
        ErrorHandler.showError(
          context,
          appException,
          l10n,
          errorContext: 'paymentWithBrowser_completer',
          onRetry:
              () => paymentWithBrowser(
                context,
                url,
                sessionId,
                accountId,
                orderId,
              ),
        );
      }
      rethrow;
    }
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

      // チェックアウトセッションの状態をクリア
      await clearCheckoutSessionState(sessionId);

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

  /// チェックアウトセッションの状態をクリア
  Future<void> clearCheckoutSessionState(String sessionId) async {
    try {
      // 現在のチェックアウトセッションの状態をリセット
      state = const AsyncValue.data(null);

      logger.d('Checkout session state cleared', time: DateTime.now());
    } catch (e, st) {
      logger.e(
        'Failed to clear checkout session state',
        error: e,
        stackTrace: st,
        time: DateTime.now(),
      );
    }
  }

  /// 0円購入時の注文・チケット発行処理
  Future<void> freeOrderAndIssueTickets(
    BuildContext context,
    List<Cart> cartList,
    Program event,
  ) async {
    logger.d('freeOrderAndIssueTickets: start', time: DateTime.now());
    final loading = ref.read(globalLoadingControllerProvider.notifier);
    try {
      // ユーザー情報取得
      final user = ref.read(authRepositoryProvider).getCurrentUser();
      if (user == null) {
        throw const AuthenticationException(message: 'ユーザーが認証されていません');
      }
      final uid = user.uid;
      final userName = user.displayName;
      final now = DateTime.now();

      // 商品情報取得
      final productRepo = ref.read(productRepositoryProvider);
      final orderProducts = <SnapshotProduct>[];
      final tickets = <Ticket>[];
      final updatedProducts = <Product>[];
      for (final cart in cartList) {
        final product = await productRepo.getProduct(cart.productId!);
        // 在庫減少
        final newStock = (product.stock) - cart.quantity;
        final updatedProduct = product.copyWith(stock: newStock);
        await productRepo.updateProduct(updatedProduct);
        updatedProducts.add(updatedProduct);
        orderProducts.add(
          SnapshotProduct(
            quantity: cart.quantity,
            userId: uid,
            userName: userName,
            productId: product.id,
            code: product.code,
            name: product.name,
            desc: product.desc,
            price: product.price,
            pictureURL: product.pictureURL,
            expirationFrom: product.expirationFrom,
            expirationTo: product.expirationTo,
            register: product.register,
            organizerId: product.organizerId,
            eventId: product.eventId,
            eventName: product.eventName,
            expirationLink: product.expirationLink ?? false,
          ),
        );
        for (var i = 0; i < cart.quantity; i++) {
          tickets.add(
            Ticket(
              paidUserId: uid,
              paidUserName: userName,
              purchaseTime: now,
              ownerId: uid,
              ownerName: userName,
              productId: product.id,
              code: product.code,
              name: product.name,
              desc: product.desc,
              price: product.price,
              pictureURL: product.pictureURL,
              expirationFrom: product.expirationFrom,
              expirationTo: product.expirationTo,
              register: product.register,
              organizerId: product.organizerId,
              eventId: product.eventId,
              eventName: product.eventName,
              createdAt: now,
              updatedAt: now,
            ),
          );
        }
      }

      // 注文作成
      final order = Order(
        userId: uid,
        eventId: event.id,
        purchaseTime: now,
        snapshotProducts: orderProducts,
        createdAt: now,
        updatedAt: now,
        status: StatusType.order, // ← preに変更
      );
      final orderRepo = ref.read(orderRepositoryProvider);
      await loading.guardFuture(() async {
        await orderRepo.createOrder(uid, order);
      });

      // チケット発行
      final ticketRepo = ref.read(ticketRepositoryProvider);
      final ticketIds = <String>[];
      for (final ticket in tickets) {
        final id = await loading.guardFuture(() async {
          return ticketRepo.createTicket(ticket);
        });
        ticketIds.add(id);
      }

      // カートクリア
      await ref.read(cartViewModelProvider.notifier).clearCart();

      // サンクス画面へ遷移
      if (context.mounted) {
        context.go(AppRoutes.checkoutSuccessPage);
      }
    } on Exception catch (e, st) {
      logger.e('freeOrderAndIssueTickets: error=$e', stackTrace: st);
      if (context.mounted) {
        final l10n = AppLocalizations.of(context)!;
        ErrorHandler.showErrorSnackBar(context, e, l10n);
      }
      rethrow;
    }
  }
}
