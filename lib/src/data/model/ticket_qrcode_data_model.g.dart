// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'ticket_qrcode_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TicketQRCodeDataModelImpl _$$TicketQRCodeDataModelImplFromJson(
  Map<String, dynamic> json,
) => _$TicketQRCodeDataModelImpl(
  id: json['id'] as String?,
  codeData: json['codeData'] as String,
  isActive: json['isActive'] as bool? ?? true,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp?,
  ),
  updatedAt: const TimestampConverter().fromJson(
    json['updatedAt'] as Timestamp?,
  ),
  deletedAt: const TimestampConverter().fromJson(
    json['deletedAt'] as Timestamp?,
  ),
);

Map<String, dynamic> _$$TicketQRCodeDataModelImplToJson(
  _$TicketQRCodeDataModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'codeData': instance.codeData,
  'isActive': instance.isActive,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'deletedAt': const TimestampConverter().toJson(instance.deletedAt),
};
