import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/cart_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/cart_repository.dart';
import '../../data/repository/product_repository.dart';
import '../../utils/logger.dart';

part 'cart_view_model.g.dart';

/// カートの状態を管理する ViewModel
@riverpod
class CartViewModel extends _$CartViewModel {
  /// 依存するリポジトリを初期化
  late final authRepository = ref.watch(authRepositoryProvider);
  late final cartRepository = ref.watch(cartRepositoryProvider);
  late final productRepository = ref.watch(productRepositoryProvider);

  /// ViewModel が初期化された際に呼ばれる
  @override
  FutureOr<List<Cart>> build() {
    logger.i('cart state build');
    return readCart();
  }

  /// カート内の商品一覧を取得する
  Future<List<Cart>> readCart() async {
    logger.d('readCart', time: DateTime.now());
    // 状態を AsyncLoading に設定
    state = const AsyncLoading();
    // ユーザーIDを取得
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    // ユーザーIDが null の場合は空のリストを返す
    if (uid == null) {
      return [];
    }
    // カート内の商品一覧を取得し、状態を更新
    state = await AsyncValue.guard(
      () async {
        return cartRepository.readCart(uid);
      },
    );
    return cartRepository.readCart(uid);
  }

  /// カートに商品を追加または数量を変更する
  Future<void> cart(int quantity, String productId, String programId) async {
    logger.d(
        'cart: quantity=$quantity, productId=$productId, programId=$programId',
        time: DateTime.now());
    // カートアイテムを作成
    final cart = Cart(
      quantity: quantity,
      productId: productId,
      programId: programId,
    );
    // ユーザーIDを取得
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    // ユーザーIDが null の場合は処理を終了
    if (uid == null) {
      return;
    }
    // カート内の商品一覧を取得
    final data = await cartRepository.readCart(uid);
    // カート内に同じ商品が存在する場合
    if (data.isNotEmpty) {
      for (final item in data) {
        if (item.productId == productId) {
          // カートアイテムを更新
          final update = Cart(
            id: item.id,
            quantity: item.quantity + quantity,
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
    // カートに商品を追加
    await addCart(uid, cart);
  }

  /// カートに商品を追加する
  Future<void> addCart(String uid, Cart data) async {
    logger.d('addCart: $data', time: DateTime.now());
    // 状態を AsyncLoading に設定
    state = const AsyncLoading();
    // カートに商品を追加し、状態を更新
    state = await AsyncValue.guard(
      () async {
        final item = await cartRepository.createCart(uid, data);
        return [...?state.value, item];
      },
    );
  }

  /// カート内の商品を更新する
  Future<void> updateCart(String uid, Cart data) async {
    logger.d('updateCart: $data', time: DateTime.now());
    // 状態を AsyncLoading に設定
    state = const AsyncLoading();
    // カート内の商品を更新し、状態を更新
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

  /// カート内の商品を削除する
  Future<void> deleteCart(String cartId) async {
    logger.d('deleteCart: cartId=$cartId', time: DateTime.now());
    // ユーザーIDを取得
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    // 状態を AsyncLoading に設定
    state = const AsyncLoading();
    // ユーザーIDが null の場合は処理を終了
    if (uid != null) {
      // カート内の商品を削除し、状態を更新
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

  /// カート内の商品の合計金額を計算する
  Future<int> sumCart() async {
    logger.d('sumCart', time: DateTime.now());
    // ユーザーIDを取得
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    // 合計金額を初期化
    var sum = 0;
    // ユーザーIDが null の場合は 0 を返す
    if (uid != null) {
      // カート内の商品一覧を取得
      final list = await cartRepository.readCart(uid);
      // 各商品について、価格と数量を掛け合わせて合計金額に加算
      for (final cart in list) {
        final product =
            ref.watch(productDocStreamProvider(cart.productDocRef!)).value!;
        sum += product.price * cart.quantity;
      }
    }
    logger.d('sum: $sum', time: DateTime.now());
    return sum;
  }

  /// カート内の商品の合計数量を計算する
  Future<int> quantityInCart() async {
    logger.d('quantity', time: DateTime.now());
    // ユーザーIDを取得
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    // 合計数量を初期化
    var quantity = 0;
    // ユーザーIDが null の場合は 0 を返す
    if (uid != null) {
      // カート内の商品一覧を取得
      final list = await cartRepository.readCart(uid);
      // 各商品について、数量を合計数量に加算
      for (final cart in list) {
        quantity += cart.quantity;
      }
    }
    logger.d('quantity: $quantity', time: DateTime.now());
    return quantity;
  }
}
