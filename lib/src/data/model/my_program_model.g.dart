// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'my_program_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MyProgramImpl _$$MyProgramImplFromJson(Map<String, dynamic> json) =>
    _$MyProgramImpl(
      id: json['id'] as String?,
      programId: json['programId'] as String?,
      createdAt: dateFromTimestampValue(json['createdAt']),
      updatedAt: dateFromTimestampValue(json['updatedAt']),
      deletedAt: dateFromTimestampValue(json['deletedAt']),
    );

Map<String, dynamic> _$$MyProgramImplToJson(_$MyProgramImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'programId': instance.programId,
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
      'deletedAt': timestampFromDateValue(instance.deletedAt),
    };
