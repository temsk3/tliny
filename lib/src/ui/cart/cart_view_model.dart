import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/cart_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/cart_repository.dart';
import '../../data/repository/product_repository.dart';

part 'cart_view_model.g.dart';

final logger = Logger();

@riverpod
class CartViewModel extends _$CartViewModel {
  late final authRepository = ref.watch(authRepositoryProvider);
  late final cartRepository = ref.watch(cartRepositoryProvider);
  late final productRepository = ref.watch(productRepositoryProvider);

  @override
  FutureOr<List<Cart>> build() {
    return readCart();
  }

  // 取得
  Future<List<Cart>> readCart() async {
    logger.d('readCart');
    state = const AsyncLoading();
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      return [];
    }
    state = await AsyncValue.guard(
      () async {
        return cartRepository.readCart(uid);
      },
    );
    return cartRepository.readCart(uid);
  }

  Future<void> cart(int quantity, String productId, String programId) async {
    final cart = Cart(
      quantity: quantity,
      productId: productId,
      programId: programId,
    );
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      final data = await cartRepository.readCart(uid);
      if (data.isNotEmpty) {
        for (final item in data) {
          if (item.productId == productId) {
            final productAsyncValue =
                ref.watch(productDocStreamProvider(item.productDocRef!));
            final product = productAsyncValue.value!;
            final update = Cart(
              id: item.id,
              quantity: (item.quantity + quantity >= product.stock)
                  ? product.stock
                  : item.quantity + quantity,
              productDocRef: item.productDocRef,
              productId: productId,
              programId: item.programId,
              createdAt: item.createdAt,
              updatedAt: item.updatedAt,
            );
            await updateCart(uid, update);
            return;
          }
        }
      }
      await addCart(uid, cart);
    }
  }

  // 追加
  Future<void> addCart(String uid, Cart data) async {
    logger.d('addCart', [data]);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final item = await cartRepository.createCart(uid, data);
        return [...?state.value, item];
      },
    );
  }

  // 更新
  Future<void> updateCart(String uid, Cart data) async {
    logger.d('updateCart', [data]);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final id = await cartRepository.updateCart(uid, data);
        return [
          for (final cart in state.value!)
            if (cart.id == id) cart.copyWith(quantity: data.quantity) else cart
        ];
      },
    );
  }

  //削除
  Future<void> deleteCart(String cartId) async {
    logger.d('deleteCart');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    state = const AsyncLoading();
    if (uid != null) {
      state = await AsyncValue.guard(
        () async {
          await cartRepository.deleteCart(uid, cartId);
          return [
            for (final cart in state.value!)
              if (cart.id != cartId) cart
          ];
        },
      );
    }
  }

  Future<int> sumCart() async {
    logger.d('sumCart');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    var sum = 0;
    if (uid != null) {
      final list = await cartRepository.readCart(uid);
      for (final cart in list) {
        final product =
            ref.watch(productDocStreamProvider(cart.productDocRef!)).value!;
        sum += product.price * cart.quantity;
      }
    }
    logger.d('sum', [sum]);
    return sum;
  }
}
