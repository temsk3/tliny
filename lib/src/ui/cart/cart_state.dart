import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/cart_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/cart_repository.dart';
import '../../data/repository/product_repository.dart';
import '../../utils/logger.dart';

/// カートの状態を管理する StreamProvider
final AutoDisposeStreamProvider<List<Cart>> cartStateProvider =
    StreamProvider.autoDispose(
  (ref) {
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
      logger.e('cartStateProvider: error=$e, stackTrace=$st',
          time: DateTime.now());
      rethrow;
    }
  },
);

/// カート内の商品の合計金額を計算する StreamProvider
final totalAmountStateProvider =
    StreamProvider.autoDispose.family<int, List<Cart>>(
  (ref, list) {
    logger.d('totalAmountStateProvider: start', time: DateTime.now());
    try {
      var totalAmount = 0;
      for (final cart in list) {
        logger.d('totalAmountStateProvider: cart=$cart', time: DateTime.now());
        final productAsyncValue =
            ref.watch(productDocStreamProvider(cart.productDocRef!));
        final product = productAsyncValue.value;
        if (product != null) {
          totalAmount += product.price * cart.quantity;
        }
      }
      logger.d('totalAmountStateProvider: totalAmount=$totalAmount',
          time: DateTime.now());
      return Stream.value(totalAmount);
    } on Exception catch (e, st) {
      logger.e('totalAmountStateProvider: error=$e, stackTrace=$st',
          time: DateTime.now());
      rethrow;
    }
  },
);
