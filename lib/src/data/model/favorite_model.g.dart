// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'favorite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FavoriteImpl _$$FavoriteImplFromJson(Map<String, dynamic> json) =>
    _$FavoriteImpl(
      id: json['id'] as String?,
      programId: json['programId'] as String?,
      createdAt: dateFromTimestampValue(json['createdAt']),
      updatedAt: dateFromTimestampValue(json['updatedAt']),
      deletedAt: dateFromTimestampValue(json['deletedAt']),
    );

Map<String, dynamic> _$$FavoriteImplToJson(_$FavoriteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'programId': instance.programId,
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
      'deletedAt': timestampFromDateValue(instance.deletedAt),
    };
