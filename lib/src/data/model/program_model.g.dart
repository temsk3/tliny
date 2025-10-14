// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'program_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProgramImpl _$$ProgramImplFromJson(Map<String, dynamic> json) =>
    _$ProgramImpl(
      id: json['id'] as String?,
      organizerId: json['organizerId'] as String?,
      name: json['name'] as String?,
      message: json['message'] as String?,
      salesStart: dateFromTimestampValue(json['salesStart']),
      salesEnd: dateFromTimestampValue(json['salesEnd']),
      eventFrom: dateFromTimestampValue(json['eventFrom']),
      eventTo: dateFromTimestampValue(json['eventTo']),
      place: json['place'] as String?,
      storageId: json['storageId'] as String?,
      pictureURL: (json['pictureURL'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: dateFromTimestampValue(json['createdAt']),
      updatedAt: dateFromTimestampValue(json['updatedAt']),
      deletedAt: dateFromTimestampValue(json['deletedAt']),
      isActive: json['isActive'] as bool?,
      isPublish: json['isPublish'] as bool?,
      isSecret: json['isSecret'] as bool? ?? false,
      secretUrl: json['secretUrl'] as String?,
      staffCode: json['staffCode'] as String?,
      staff: (json['staff'] as List<dynamic>?)
          ?.map((e) => Staff.fromJson(e as Map<String, dynamic>))
          .toList(),
      product: (json['product'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProgramImplToJson(_$ProgramImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizerId': instance.organizerId,
      'name': instance.name,
      'message': instance.message,
      'salesStart': timestampFromDateValue(instance.salesStart),
      'salesEnd': timestampFromDateValue(instance.salesEnd),
      'eventFrom': timestampFromDateValue(instance.eventFrom),
      'eventTo': timestampFromDateValue(instance.eventTo),
      'place': instance.place,
      'storageId': instance.storageId,
      'pictureURL': instance.pictureURL,
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
      'deletedAt': timestampFromDateValue(instance.deletedAt),
      'isActive': instance.isActive,
      'isPublish': instance.isPublish,
      'isSecret': instance.isSecret,
      'secretUrl': instance.secretUrl,
      'staffCode': instance.staffCode,
      'staff': instance.staff,
      'product': instance.product,
    };
