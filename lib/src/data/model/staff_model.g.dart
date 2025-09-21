// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'staff_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Staff _$StaffFromJson(Map<String, dynamic> json) => _Staff(
  id: json['id'] as String?,
  displayName: json['displayName'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  isCreated: json['isCreated'] as bool? ?? true,
  isRetrieve: json['isRetrieve'] as bool? ?? true,
  isUpdated: json['isUpdated'] as bool? ?? true,
  isDeleted: json['isDeleted'] as bool? ?? true,
  createdAt: dateFromTimestampValue(json['createdAt']),
  updatedAt: dateFromTimestampValue(json['updatedAt']),
  deletedAt: dateFromTimestampValue(json['deletedAt']),
  isActive: json['isActive'] as bool? ?? false,
);

Map<String, dynamic> _$StaffToJson(_Staff instance) => <String, dynamic>{
  'id': instance.id,
  'displayName': instance.displayName,
  'name': instance.name,
  'email': instance.email,
  'isCreated': instance.isCreated,
  'isRetrieve': instance.isRetrieve,
  'isUpdated': instance.isUpdated,
  'isDeleted': instance.isDeleted,
  'createdAt': timestampFromDateValue(instance.createdAt),
  'updatedAt': timestampFromDateValue(instance.updatedAt),
  'deletedAt': timestampFromDateValue(instance.deletedAt),
  'isActive': instance.isActive,
};
