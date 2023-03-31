import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/cart_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/cart_repository.dart';
import '../../data/repository/product_repository.dart';

final AutoDisposeStreamProvider<List<Cart>> cartStateProvider =
    StreamProvider.autoDispose(
  (ref) {
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      return ref.watch(cartRepositoryProvider).watchCart(uid);
    }
    return Stream.value([]);
  },
);

final totalAmountStateProvider =
    StreamProvider.autoDispose.family<int, List<Cart>>(
  (ref, list) {
    var totalAmount = 0;
    for (final cart in list) {
      final productAsyncValue =
          ref.watch(productDocStreamProvider(cart.productDocRef!));
      final product = productAsyncValue.value;
      totalAmount += product!.price * cart.quantity;
    }
    return Stream.value(totalAmount);
  },
);
