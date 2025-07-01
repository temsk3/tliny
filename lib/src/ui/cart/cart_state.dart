import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/cart_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/cart_repository.dart';
import '../../data/repository/product_repository.dart';
import '../../utils/logger.dart';

/// カートの状態を管理する StreamProvider
final AutoDisposeStreamProvider<List<Cart>> cartStateProvider =
    StreamProvider.autoDispose((ref) {
      logger.d('cartStateProvider: start', time: DateTime.now());
      try {
        final uidAsyncValue = ref.watch(userIdProvider);
        final uid = uidAsyncValue.value;
        if (uid != null) {
          logger.d('cartStateProvider: uid=$uid', time: DateTime.now());
          return ref.watch(cartRepositoryProvider).watchCart(uid);
        }
        logger.d('cartStateProvider: uid is null', time: DateTime.now());
        return Stream.value([]);
      } on Exception catch (e, st) {
        logger.e(
          'cartStateProvider: error=$e, stackTrace=$st',
          time: DateTime.now(),
        );
        rethrow;
      }
    });

/// カート内の商品の合計金額を計算する FutureProvider（最適化版）
final AutoDisposeFutureProviderFamily<int, List<Cart>>
totalAmountStateProvider = FutureProvider.autoDispose.family<int, List<Cart>>((
  ref,
  list,
) async {
  logger.d(
    'totalAmountStateProvider: start, list.length=${list.length}',
    time: DateTime.now(),
  );

  // 空のリストの場合は早期リターン
  if (list.isEmpty) {
    return 0;
  }

  try {
    var totalAmount = 0;
    final processedProducts = <String, int>{}; // 商品ID -> 価格のキャッシュ

    for (final cart in list) {
      if (cart.productDocRef != null && cart.productDocRef!.isNotEmpty) {
        // 商品IDを抽出（パスから最後の部分を取得）
        final productId = cart.productDocRef!.split('/').last;

        // キャッシュされた価格を使用
        int productPrice;
        if (processedProducts.containsKey(productId)) {
          productPrice = processedProducts[productId]!;
        } else {
          // 商品データを一度だけ取得
          try {
            final product = await ref
                .read(productRepositoryProvider)
                .getProductOnce(productId);
            productPrice = product?.price ?? 0;
            processedProducts[productId] = productPrice;
          } catch (e, st) {
            logger.e(
              'totalAmountStateProvider: product取得エラー - $e',
              stackTrace: st,
            );
            productPrice = 0;
            processedProducts[productId] = productPrice;
          }
        }

        totalAmount += productPrice * cart.quantity;
      }
    }

    logger.d(
      'totalAmountStateProvider: totalAmount=$totalAmount',
      time: DateTime.now(),
    );
    return totalAmount;
  } on Exception catch (e, st) {
    logger.e(
      'totalAmountStateProvider: error=$e, stackTrace=$st',
      time: DateTime.now(),
    );
    rethrow;
  }
});
