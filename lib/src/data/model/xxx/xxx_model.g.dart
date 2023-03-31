// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'xxx_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Xxx _$$_XxxFromJson(Map<String, dynamic> json) => _$_Xxx(
      id: json['id'] as String?,
      data: json['data'] as String,
      createdAt: dateFromTimestampValue(json['createdAt']),
      updatedAt: dateFromTimestampValue(json['updatedAt']),
      deletedAt: dateFromTimestampValue(json['deletedAt']),
    );

Map<String, dynamic> _$$_XxxToJson(_$_Xxx instance) => <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
      'deletedAt': timestampFromDateValue(instance.deletedAt),
    };
