import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/product_model.dart';
import '../../data/model/program_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/product_repository.dart';
import '../../data/repository/staff_repository.dart';

part 'product_state.g.dart';

@riverpod
Stream<List<Product>> productsState(
  Ref ref,
  String programId,
  GenreType? genre,
) {
  final listAsyncValue = ref.watch(productsStreamProvider);
  final list = listAsyncValue.value;
  if (list != null) {
    if (genre != null) {
      return Stream.value(
        list
            .where((element) => element.genre == genre)
            .where((element) => element.eventId == programId)
            .toList(),
      );
    }
    return Stream.value(
      list.where((element) => element.eventId == programId).toList(),
    );
  }
  return Stream.value([]);
}

@riverpod
Stream<Product> productState(Ref ref, String? productId) {
  return ref.watch(productRepositoryProvider).watchProduct(productId);
}

@riverpod
Stream<bool> addProductButtonState(Ref ref, Program program) {
  final uidAsyncValue = ref.watch(userIdProvider);
  final uid = uidAsyncValue.value;
  final staffAsyncValue = ref.watch(staffCheckExistenceProvider(program.id!));
  final staff = staffAsyncValue.value;

  if (uid == null) {
    return Stream<bool>.value(false);
  }

  // イベント主催者またはスタッフは商品登録可能
  if (uid == program.organizerId) {
    return Stream<bool>.value(true);
  }

  if (staff == null) {
    return Stream<bool>.value(false);
  }

  if (staff) {
    return Stream<bool>.value(true);
  }

  return Stream<bool>.value(false);
}

@riverpod
Stream<bool> editProductButtonState(Ref ref, Product product) {
  final uidAsyncValue = ref.watch(userIdProvider);
  final uid = uidAsyncValue.value;

  if (uid == null) {
    return Stream<bool>.value(false);
  }

  if (uid == product.organizerId || uid == product.register) {
    return Stream<bool>.value(true);
  }
  return Stream<bool>.value(false);
}
