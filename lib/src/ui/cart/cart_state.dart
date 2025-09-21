import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/cart_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/cart_repository.dart';
import '../../data/repository/product_repository.dart';
import '../../utils/logger.dart';

part 'cart_state.g.dart';

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

/// 商品価格のキャッシュを管理するプロバイダー
final AutoDisposeFutureProviderFamily<Map<String, int>, List<String>>
productPriceCacheProvider = FutureProvider.autoDispose.family<
  Map<String, int>,
  List<String>
>((ref, productIds) async {
  logger.d(
    'productPriceCacheProvider: start, productIds.length=${productIds.length}',
    time: DateTime.now(),
  );

  if (productIds.isEmpty) {
    return {};
  }

  final priceCache = <String, int>{};

  for (final productId in productIds) {
    try {
      final product = await ref
          .read(productRepositoryProvider)
          .getProductOnce(productId);
      priceCache[productId] = product?.price ?? 0;
    } on Exception catch (e, st) {
      logger.e('productPriceCacheProvider: product取得エラー - $e', stackTrace: st);
      priceCache[productId] = 0;
    }
  }

  logger.d(
    'productPriceCacheProvider: cache size=${priceCache.length}',
    time: DateTime.now(),
  );

  return priceCache;
});

/// リストのハッシュ値を計算する
int _calculateListHash(List<Cart> list) {
  return list.fold<int>(0, (hash, cart) {
    return hash +
        cart.hashCode +
        (cart.quantity * 31) +
        (cart.id?.hashCode ?? 0);
  });
}

/// 合計金額を管理する AsyncNotifier（根本的解決版）
@riverpod
class TotalAmountNotifier extends _$TotalAmountNotifier {
  // 前回の値を保持するキャッシュ
  int? _cachedValue;
  int? _cachedHash;
  var _isInitialized = false;
  var _isUpdating = false;

  @override
  Future<int> build(List<Cart> list) async {
    final listHash = _calculateListHash(list);

    logger.d(
      'TotalAmountNotifier: build, list.length=${list.length}, listHash=$listHash, cachedValue=$_cachedValue, cachedHash=$_cachedHash, isInitialized=$_isInitialized, isUpdating=$_isUpdating',
      time: DateTime.now(),
    );

    // 空のリストの場合は早期リターン
    if (list.isEmpty) {
      _cachedValue = 0;
      _cachedHash = listHash;
      _isInitialized = true;
      return 0;
    }

    // ハッシュ値が同じ場合はキャッシュされた値を返す
    if (_cachedHash == listHash && _cachedValue != null) {
      logger.d(
        'TotalAmountNotifier: ハッシュキャッシュヒット, cachedValue=$_cachedValue',
        time: DateTime.now(),
      );
      return _cachedValue!;
    }

    // 初期化済みでキャッシュがある場合は、まずキャッシュ値を返してから非同期で更新
    if (_isInitialized && _cachedValue != null && !_isUpdating) {
      logger.d(
        'TotalAmountNotifier: 初期値としてキャッシュ値を返す, cachedValue=$_cachedValue',
        time: DateTime.now(),
      );

      // 非同期で新しい値を計算（重複実行を防ぐ）
      _isUpdating = true;
      _updateValueAsync(list, listHash);

      return _cachedValue!;
    }

    try {
      _isUpdating = true;

      // 必要な商品IDを抽出
      final productIds = <String>{};
      for (final cart in list) {
        if (cart.productDocRef != null && cart.productDocRef!.isNotEmpty) {
          final productId = cart.productDocRef!.split('/').last;
          productIds.add(productId);
        }
      }

      // 商品価格のキャッシュを取得
      final priceCache = await ref.read(
        productPriceCacheProvider(productIds.toList()).future,
      );

      // 合計金額を計算
      var totalAmount = 0;
      for (final cart in list) {
        if (cart.productDocRef != null && cart.productDocRef!.isNotEmpty) {
          final productId = cart.productDocRef!.split('/').last;
          final productPrice = priceCache[productId] ?? 0;
          totalAmount += productPrice * cart.quantity;
        }
      }

      // キャッシュを更新
      _cachedValue = totalAmount;
      _cachedHash = listHash;
      _isInitialized = true;
      _isUpdating = false;

      logger.d(
        'TotalAmountNotifier: totalAmount=$totalAmount (キャッシュ更新)',
        time: DateTime.now(),
      );

      return totalAmount;
    } on Exception catch (e, st) {
      _isUpdating = false;
      logger.e(
        'TotalAmountNotifier: error=$e, stackTrace=$st',
        time: DateTime.now(),
      );
      // エラー時はキャッシュされた値を返す
      if (_cachedValue != null) {
        logger.d(
          'TotalAmountNotifier: エラー時キャッシュ値を使用, cachedValue=$_cachedValue',
          time: DateTime.now(),
        );
        return _cachedValue!;
      }
      rethrow;
    }
  }

  /// 非同期で値を更新する
  Future<void> _updateValueAsync(List<Cart> list, int listHash) async {
    try {
      // 必要な商品IDを抽出
      final productIds = <String>{};
      for (final cart in list) {
        if (cart.productDocRef != null && cart.productDocRef!.isNotEmpty) {
          final productId = cart.productDocRef!.split('/').last;
          productIds.add(productId);
        }
      }

      // 商品価格のキャッシュを取得
      final priceCache = await ref.read(
        productPriceCacheProvider(productIds.toList()).future,
      );

      // 合計金額を計算
      var totalAmount = 0;
      for (final cart in list) {
        if (cart.productDocRef != null && cart.productDocRef!.isNotEmpty) {
          final productId = cart.productDocRef!.split('/').last;
          final productPrice = priceCache[productId] ?? 0;
          totalAmount += productPrice * cart.quantity;
        }
      }

      // 値が変更された場合のみ状態を更新
      if (_cachedValue != totalAmount) {
        _cachedValue = totalAmount;
        _cachedHash = listHash;
        state = AsyncValue.data(totalAmount);

        logger.d(
          'TotalAmountNotifier: 非同期更新完了, totalAmount=$totalAmount',
          time: DateTime.now(),
        );
      }
    } on Exception catch (e, st) {
      logger.e(
        'TotalAmountNotifier: 非同期更新エラー - $e',
        stackTrace: st,
        time: DateTime.now(),
      );
    } finally {
      _isUpdating = false;
    }
  }

  /// 合計金額を手動で更新する
  Future<void> updateTotalAmount(List<Cart> newList) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build(newList));
  }

  /// キャッシュをクリアする
  void clearCache() {
    _cachedValue = null;
    _cachedHash = null;
    _isInitialized = false;
    _isUpdating = false;
  }
}
