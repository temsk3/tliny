// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/json_converter.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

//
@freezed
class Cart with _$Cart {
  const factory Cart({
    String? id,
    required int quantity,
    @DocumentReferenceNullStringConverter() String? productDocRef,
    required String? productId,
    required String? programId,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _Cart;

  const Cart._();

  factory Cart.empty() =>
      const Cart(quantity: 0, productId: null, programId: null);
  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}
