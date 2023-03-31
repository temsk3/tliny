import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/product_model.dart';
import '../../data/model/program_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/product_repository.dart';

part 'product_view_model.g.dart';

final logger = Logger();

@riverpod
class ProductViewModel extends _$ProductViewModel {
  late ProductRepository productRepository =
      ref.read(productRepositoryProvider);
  late AuthRepository authRepository = ref.read(authRepositoryProvider);

  @override
  FutureOr<List<Product>> build() {
    return readProduct();
  }

  // 取得
  Future<List<Product>> readProduct() async {
    logger.d('readProduct');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return productRepository.readProducts();
    });
    return productRepository.readProducts();
  }

  // 追加
  Future<void> addProduct(Program program, Product product) async {
    logger.d('addProduct');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    // logger.d(uid);
    final data = product.copyWith(
      register: uid,
      // organizerDocRef: program.,
      organizerId: program.organizerId,
      // eventDocRef: program.,
      eventId: program.id,
      eventName: program.name,
    );
    // logger.d(data);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final id = await productRepository.createProduct(data);
      return [...?state.value, data.copyWith(id: id)];
    });
  }

  // 更新
  Future<void> updateProduct(Product data) async {
    logger.d('updatedProduct');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final id = await productRepository.updateProduct(data);
      return [
        for (final product in state.value!)
          if (product.id == id) data else product
      ];
    });
  }

  //削除
  Future<void> deleteProduct(String id) async {
    logger.d('deleteProduct');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await productRepository.deleteProduct(id);
      return [
        for (final product in state.value!)
          if (product.id != id) product
      ];
    });
  }

  Future<void> registerProduct(Program program, Product product) async {
    if (product.id == null) {
      await addProduct(program, product);
    } else {
      await updateProduct(product);
    }
  }
}
