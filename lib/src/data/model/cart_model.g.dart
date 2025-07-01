// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartImpl _$$CartImplFromJson(Map<String, dynamic> json) => _$CartImpl(
  id: json['id'] as String?,
  quantity: (json['quantity'] as num).toInt(),
  productDocRef: const DocumentReferenceNullStringConverter().fromJson(
    json['productDocRef'] as DocumentReference<Object?>?,
  ),
  productId: json['productId'] as String?,
  programId: json['programId'] as String?,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp?,
  ),
  updatedAt: const TimestampConverter().fromJson(
    json['updatedAt'] as Timestamp?,
  ),
);

Map<String, dynamic> _$$CartImplToJson(_$CartImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'productDocRef': const DocumentReferenceNullStringConverter().toJson(
        instance.productDocRef,
      ),
      'productId': instance.productId,
      'programId': instance.programId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
