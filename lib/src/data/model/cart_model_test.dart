// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_model_test.freezed.dart';
part 'cart_model_test.g.dart';

@freezed
class CartTest with _$CartTest {
  const factory CartTest({
    String? id,
    required int quantity,
    String? productId,
  }) = _CartTest;

  const CartTest._();

  factory CartTest.fromJson(Map<String, dynamic> json) =>
      _$CartTestFromJson(json);
}

