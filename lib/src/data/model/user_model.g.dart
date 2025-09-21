// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String?,
  photoUrl: json['photoUrl'] as String?,
  displayName: json['displayName'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  createdAt: dateFromTimestampValue(json['createdAt']),
  updatedAt: dateFromTimestampValue(json['updatedAt']),
  deletedAt: dateFromTimestampValue(json['deletedAt']),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'photoUrl': instance.photoUrl,
  'displayName': instance.displayName,
  'name': instance.name,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'createdAt': timestampFromDateValue(instance.createdAt),
  'updatedAt': timestampFromDateValue(instance.updatedAt),
  'deletedAt': timestampFromDateValue(instance.deletedAt),
};

_PublicUsers _$PublicUsersFromJson(Map<String, dynamic> json) => _PublicUsers(
  id: json['id'] as String?,
  displayName: json['displayName'] as String?,
  profileImageURL: json['profileImageURL'] as String?,
  createdAt: dateFromTimestampValue(json['createdAt']),
  updatedAt: dateFromTimestampValue(json['updatedAt']),
  deletedAt: dateFromTimestampValue(json['deletedAt']),
);

Map<String, dynamic> _$PublicUsersToJson(_PublicUsers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'profileImageURL': instance.profileImageURL,
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
      'deletedAt': timestampFromDateValue(instance.deletedAt),
    };
