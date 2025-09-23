import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_model.g.dart';
part 'cart_model.freezed.dart';

@freezed
class Cart with _$Cart {
  const factory Cart({
    String? id,
    required int quantity,
    String? productDocRef,
    String? productId,
    String? programId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Cart;

  const Cart._();

  factory Cart.empty() =>
      const Cart(quantity: 0, productId: null, programId: null);
  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}
