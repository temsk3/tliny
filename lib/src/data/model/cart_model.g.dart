// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartImpl _$$CartImplFromJson(Map<String, dynamic> json) => _$CartImpl(
  id: json['id'] as String?,
  quantity: (json['quantity'] as num).toInt(),
  productDocRef: documentReference(
    json['productDocRef'] as DocumentReference<Map<String, dynamic>>?,
  ),
  productId: json['productId'] as String?,
  programId: json['programId'] as String?,
  createdAt: dateFromTimestampValue(json['createdAt']),
  updatedAt: dateFromTimestampValue(json['updatedAt']),
);

Map<String, dynamic> _$$CartImplToJson(_$CartImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'productDocRef': documentReference(instance.productDocRef),
      'productId': instance.productId,
      'programId': instance.programId,
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
    };
