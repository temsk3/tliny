import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/exception/app_exception.dart';
import '../../data/model/product_model.dart';
import '../../data/model/program_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/product_repository.dart';
import '../../data/repository/staff_repository.dart';
import '../../data/repository/user_repository.dart';
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
  late UserRepository userRepository = ref.read(userRepositoryProvider);
  late StaffRepository staffRepository = ref.read(staffRepositoryProvider);

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

    if (uid == null) {
      throw const AuthenticationException(message: 'ユーザーが認証されていません');
    }

    // スタッフかどうかをチェック
    final isStaff = await staffRepository.checkExistenceStaff(program.id!, uid);

    // スタッフでない場合のみ購入者登録の有無をチェック
    if (!isStaff) {
      // 購入者登録の有無をチェック
      final hasAccount = await userRepository.checkExistenceAccount(uid);

      // 価格制限のチェック
      if (hasAccount) {
        // 購入者登録している人: 50円以上のみ（1-49円は不可）
        if (product.price < 50) {
          throw const GeneralException(
            message: '購入者登録済みの場合は¥50以上で設定してください（¥1-¥49は設定できません）',
          );
        }
      } else {
        // 購入者登録していない人: 0円のみ
        if (product.price != 0) {
          throw const GeneralException(message: '購入者登録していないため、¥0のみ設定可能です');
        }
      }
    } else {
      // スタッフの場合: 1-49円の範囲のみ制限
      if (product.price >= 1 && product.price <= 49) {
        throw const GeneralException(message: '¥1-¥49の範囲は設定できません');
      }
    }

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
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;

    if (uid == null) {
      throw const AuthenticationException(message: 'ユーザーが認証されていません');
    }

    // スタッフかどうかをチェック
    final isStaff = await staffRepository.checkExistenceStaff(
      data.eventId!,
      uid,
    );

    // スタッフでない場合のみ購入者登録の有無をチェック
    if (!isStaff) {
      // 購入者登録の有無をチェック
      final hasAccount = await userRepository.checkExistenceAccount(uid);

      // 価格制限のチェック
      if (hasAccount) {
        // 購入者登録している人: 50円以上のみ（1-49円は不可）
        if (data.price < 50) {
          throw const GeneralException(
            message: '購入者登録済みの場合は¥50以上で設定してください（¥1-¥49は設定できません）',
          );
        }
      } else {
        // 購入者登録していない人: 0円のみ
        if (data.price != 0) {
          throw const GeneralException(message: '購入者登録していないため、¥0のみ設定可能です');
        }
      }
    } else {
      // スタッフの場合: 1-49円の範囲のみ制限
      if (data.price >= 1 && data.price <= 49) {
        throw const GeneralException(message: '¥1-¥49の範囲は設定できません');
      }
    }

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
