import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/exception/app_exception.dart';
import '../../data/model/product_model.dart';
import '../../data/model/program_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/product_repository.dart';
import '../../utils/logger.dart';
import '../common/loading_screen.dart';

part 'product_view_model.g.dart';

// final logger = Logger();

@riverpod
class ProductViewModel extends _$ProductViewModel {
  late ProductRepository productRepository = ref.read(
    productRepositoryProvider,
  );
  late AuthRepository authRepository = ref.read(authRepositoryProvider);

  @override
  FutureOr<List<Product>> build() {
    return _readProductDirectly();
  }

  // 直接商品を取得（buildメソッド用）
  Future<List<Product>> _readProductDirectly() async {
    logger.d('_readProductDirectly');
    try {
      return await productRepository.readProducts();
    } on AppException catch (e, st) {
      logger.e(
        '_readProductDirectly: AppException - ${e.message}',
        stackTrace: st,
      );
      rethrow;
    } on Exception catch (e, st) {
      logger.e('_readProductDirectly: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      rethrow;
    }
  }

  // 取得（ローディング付き）
  Future<List<Product>> readProduct() async {
    logger.d('readProduct');
    final loading = ref.read(globalLoadingControllerProvider.notifier);
    state = const AsyncLoading();
    try {
      final products = await loading.guardFuture(() async {
        return productRepository.readProducts();
      });
      state = AsyncValue.data(products);
      return products;
    } on AppException catch (e, st) {
      logger.e('readProduct: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('readProduct: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  // 追加
  Future<void> addProduct(Program program, Product product) async {
    logger.d('addProduct');
    final loading = ref.read(globalLoadingControllerProvider.notifier);
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    final data = product.copyWith(
      register: uid,
      organizerId: program.organizerId,
      eventId: program.id,
      eventName: program.name,
    );
    state = const AsyncLoading();
    try {
      final id = await loading.guardFuture(() async {
        return productRepository.createProduct(data);
      });
      final newProduct = data.copyWith(id: id);
      final updatedProducts = [...?state.value, newProduct];
      state = AsyncValue.data(updatedProducts);
    } on AppException catch (e, st) {
      logger.e('addProduct: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('addProduct: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  // 更新
  Future<void> updateProduct(Product data) async {
    logger.d('updatedProduct');
    final loading = ref.read(globalLoadingControllerProvider.notifier);
    state = const AsyncLoading();
    try {
      final id = await loading.guardFuture(() async {
        return productRepository.updateProduct(data);
      });
      final updatedProducts = [
        for (final product in state.value!)
          if (product.id == id) data else product,
      ];
      state = AsyncValue.data(updatedProducts);
    } on AppException catch (e, st) {
      logger.e('updateProduct: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('updateProduct: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  //削除
  Future<void> deleteProduct(String id) async {
    logger.d('deleteProduct');
    final loading = ref.read(globalLoadingControllerProvider.notifier);
    state = const AsyncLoading();
    try {
      await loading.guardFuture(() async {
        await productRepository.deleteProduct(id);
      });
      final updatedProducts = [
        for (final product in state.value!)
          if (product.id != id) product,
      ];
      state = AsyncValue.data(updatedProducts);
    } on AppException catch (e, st) {
      logger.e('deleteProduct: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('deleteProduct: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  Future<bool> registerProduct(Program program, Product product) async {
    if (product.id == null) {
      await addProduct(program, product);
    } else {
      await updateProduct(product);
    }
    return true;
  }
}
