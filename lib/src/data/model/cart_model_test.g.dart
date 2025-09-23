// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'cart_model_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartTest _$CartTestFromJson(Map<String, dynamic> json) => _CartTest(
  id: json['id'] as String?,
  quantity: (json['quantity'] as num).toInt(),
  productId: json['productId'] as String?,
);

Map<String, dynamic> _$CartTestToJson(_CartTest instance) => <String, dynamic>{
  'id': instance.id,
  'quantity': instance.quantity,
  'productId': instance.productId,
};
