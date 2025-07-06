import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/cart_model.dart';
import '../../data/model/exception/app_exception.dart';
import '../../data/model/product_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/cart_repository.dart';
import '../../data/repository/product_repository.dart';
import '../../utils/logger.dart';
import '../common/loading_screen.dart';

part 'cart_view_model.g.dart';

/// カートの状態を管理する ViewModel
@riverpod
class CartViewModel extends _$CartViewModel {
  /// 依存するリポジトリを初期化
  late final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  late final CartRepository cartRepository = ref.watch(cartRepositoryProvider);
  late final ProductRepository productRepository = ref.watch(
    productRepositoryProvider,
  );

  /// ViewModel が初期化された際に呼ばれる
  @override
  FutureOr<List<Cart>> build() {
    logger.i('cart state build - 開始');
    try {
      final result = _readCartDirectly();
      logger.i('cart state build - 完了: $result');
      return result;
    } catch (e, st) {
      logger.e('cart state build - エラー: $e', stackTrace: st);
      rethrow;
    }
  }

  /// 直接カートを取得（buildメソッド用）
  Future<List<Cart>> _readCartDirectly() async {
    logger.d('_readCartDirectly - 開始', time: DateTime.now());
    final uidAsyncValue = ref.watch(userIdProvider);
    logger
      ..d(
        '_readCartDirectly - userIdProvider: $uidAsyncValue',
        time: DateTime.now(),
      )
      ..d(
        '_readCartDirectly - userIdProvider.isLoading: ${uidAsyncValue.isLoading}',
        time: DateTime.now(),
      )
      ..d(
        '_readCartDirectly - userIdProvider.hasValue: ${uidAsyncValue.hasValue}',
        time: DateTime.now(),
      )
      ..d(
        '_readCartDirectly - userIdProvider.hasError: ${uidAsyncValue.hasError}',
        time: DateTime.now(),
      );
    final uid = uidAsyncValue.value;
    logger.d('_readCartDirectly - uid: $uid', time: DateTime.now());
    if (uid == null) {
      logger.d('_readCartDirectly - uid is null, 空配列を返す', time: DateTime.now());
      return [];
    }
    try {
      logger.d(
        '_readCartDirectly - cartRepository.readCartを呼び出し',
        time: DateTime.now(),
      );
      final result = await cartRepository.readCart(uid);
      logger.d(
        '_readCartDirectly - cartRepository.readCart完了: $result',
        time: DateTime.now(),
      );
      return result;
    } on AppException catch (e, st) {
      logger.e(
        '_readCartDirectly: AppException - ${e.message}',
        stackTrace: st,
      );
      rethrow;
    } on Exception catch (e, st) {
      logger.e('_readCartDirectly: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      throw appException;
    }
  }

  /// カート内の商品一覧を取得する（ローディング付き）
  Future<List<Cart>> readCart() async {
    logger.d('readCart', time: DateTime.now());
    final loading = ref.read(globalLoadingControllerProvider.notifier);
    state = const AsyncLoading();
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      return [];
    }
    try {
      final carts = await loading.guardFuture(() {
        return cartRepository.readCart(uid);
      });
      state = AsyncValue.data(carts);
      return carts;
    } on AppException catch (e, st) {
      logger.e('readCart: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('readCart: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  /// カートに商品を追加または数量を変更する
  Future<void> cart(int quantity, String productId, String programId) async {
    logger.d(
      'cart: quantity=$quantity, productId=$productId, programId=$programId',
      time: DateTime.now(),
    );
    final cart = Cart(
      quantity: quantity,
      productId: productId,
      programId: programId,
    );
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      return;
    }
    final data = await cartRepository.readCart(uid);
    if (data.isNotEmpty) {
      for (final item in data) {
        if (item.productId == productId) {
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
    await addCart(uid, cart);
  }

  /// カートに商品を追加する
  Future<void> addCart(String uid, Cart data) async {
    logger.d('addCart: $data', time: DateTime.now());
    final loading = ref.read(globalLoadingControllerProvider.notifier);
    state = const AsyncLoading();
    try {
      final item = await loading.guardFuture(() {
        return cartRepository.createCart(uid, data);
      });
      final updatedCarts = [...?state.value, item];
      state = AsyncValue.data(updatedCarts);
    } on AppException catch (e, st) {
      logger.e('addCart: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('addCart: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  /// カート内の商品を更新する
  Future<void> updateCart(String uid, Cart data) async {
    logger.d('updateCart: $data', time: DateTime.now());
    final loading = ref.read(globalLoadingControllerProvider.notifier);
    state = const AsyncLoading();
    try {
      final id = await loading.guardFuture(() {
        return cartRepository.updateCart(uid, data);
      });
      final updatedCarts = [
        for (final cart in state.value!)
          if (cart.id == id) cart.copyWith(quantity: data.quantity) else cart,
      ];
      state = AsyncValue.data(updatedCarts);
    } on AppException catch (e, st) {
      logger.e('updateCart: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('updateCart: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  /// カート内の商品を更新する（最適化版 - リビルドを最小限に）
  Future<void> updateCartOptimized(String uid, Cart data) async {
    logger.d('updateCartOptimized: $data', time: DateTime.now());
    final loading = ref.read(globalLoadingControllerProvider.notifier);
    try {
      final id = await loading.guardFuture(() {
        return cartRepository.updateCart(uid, data);
      });

      // 現在の状態を直接更新（AsyncLoadingを使わない）
      if (state.value != null) {
        final updatedCarts = [
          for (final cart in state.value!)
            if (cart.id == id) cart.copyWith(quantity: data.quantity) else cart,
        ];
        state = AsyncValue.data(updatedCarts);
      }
    } on AppException catch (e, st) {
      logger.e(
        'updateCartOptimized: AppException - ${e.message}',
        stackTrace: st,
      );
      // エラー時のみAsyncLoadingに変更
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('updateCartOptimized: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      // エラー時のみAsyncLoadingに変更
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  /// カート内の商品を削除する
  Future<void> deleteCart(String cartId) async {
    logger.d('deleteCart: cartId=$cartId', time: DateTime.now());
    final loading = ref.read(globalLoadingControllerProvider.notifier);
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    state = const AsyncLoading();
    if (uid != null) {
      try {
        await loading.guardFuture(() async {
          await cartRepository.deleteCart(uid, cartId);
        });
        final updatedCarts = [
          for (final cart in state.value!)
            if (cart.id != cartId) cart,
        ];
        state = AsyncValue.data(updatedCarts);
      } on AppException catch (e, st) {
        logger.e('deleteCart: AppException - ${e.message}', stackTrace: st);
        state = AsyncValue.error(e, st);
        rethrow;
      } on Exception catch (e, st) {
        logger.e('deleteCart: Exception - $e', stackTrace: st);
        final appException = GeneralException(
          message: e.toString(),
          stackTrace: st,
        );
        state = AsyncValue.error(appException, st);
        rethrow;
      }
    }
  }

  /// カート内の商品の合計金額を計算する
  Future<int> sumCart() async {
    logger.d('sumCart', time: DateTime.now());
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    var sum = 0;
    if (uid != null) {
      final list = await cartRepository.readCart(uid);
      for (final cart in list) {
        if (cart.productDocRef != null && cart.productDocRef!.isNotEmpty) {
          // 商品IDを抽出（パスから最後の部分を取得）
          final productId = cart.productDocRef!.split('/').last;

          try {
            // リアルタイムで商品データを取得
            final product =
                await productRepository.watchProduct(productId).first;
            sum += product.price * cart.quantity;
          } on Exception catch (e, st) {
            logger.e('sumCart: product取得エラー - $e', stackTrace: st);
            // エラーの場合は何もしない（0を加算）
          }
        }
      }
    }
    logger.d('sum: $sum', time: DateTime.now());
    return sum;
  }

  /// カート内の商品の合計数量を計算する
  Future<int> quantityInCart() async {
    logger.d('quantity', time: DateTime.now());
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    var quantity = 0;
    if (uid != null) {
      final list = await cartRepository.readCart(uid);
      for (final cart in list) {
        quantity += cart.quantity;
      }
    }
    logger.d('quantity: $quantity', time: DateTime.now());
    return quantity;
  }

  /// 在庫不足のカートアイテムを自動調整する
  Future<void> adjustCartForStock({
    Future<bool> Function(
      Product product,
      int currentQuantity,
      int availableStock,
    )?
    showConfirmationDialog,
  }) async {
    logger.d('adjustCartForStock: 在庫不足のカートアイテムを調整します', time: DateTime.now());
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      return;
    }

    try {
      final currentCarts = state.value ?? [];
      var hasChanges = false;

      for (final cart in currentCarts) {
        if (cart.productDocRef != null && cart.productDocRef!.isNotEmpty) {
          final productId = cart.productDocRef!.split('/').last;
          // リアルタイムで商品データを取得
          final product =
              await ref
                  .read(productRepositoryProvider)
                  .watchProduct(productId)
                  .first;

          if (cart.quantity > product.stock) {
            // 確認ダイアログが指定されている場合は表示
            var shouldAdjust = true;
            if (showConfirmationDialog != null) {
              shouldAdjust = await showConfirmationDialog(
                product,
                cart.quantity,
                product.stock,
              );
            }

            if (shouldAdjust) {
              // 在庫不足の場合、数量を在庫数に調整
              final adjustedCart = cart.copyWith(quantity: product.stock);
              await updateCartOptimized(uid, adjustedCart);
              hasChanges = true;
              logger.d(
                'adjustCartForStock: カートID ${cart.id} の数量を ${cart.quantity} → ${product.stock} に調整',
                time: DateTime.now(),
              );
            }
          }
        }
      }

      if (hasChanges) {
        // 調整後にカートを再読み込み
        await readCart();
        logger.d('adjustCartForStock: 在庫調整完了', time: DateTime.now());
      } else {
        logger.d('adjustCartForStock: 在庫調整不要', time: DateTime.now());
      }
    } on Exception catch (e, st) {
      logger.e('adjustCartForStock: エラー - $e', stackTrace: st);
    }
  }
}
