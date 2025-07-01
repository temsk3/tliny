// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'util/json_converter.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

//
@freezed
class User with _$User {
  const factory User({
    String? id,
    String? photoUrl,
    String? displayName,
    required String? name,
    required String? email,
    required String? phoneNumber,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  }) = _User;
  const User._();

  factory User.empty() => const User(name: '', email: '', phoneNumber: null);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

//
@freezed
class PublicUsers with _$PublicUsers {
  factory PublicUsers({
    String? id,
    String? displayName,
    String? profileImageURL,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  }) = _PublicUsers;

  factory PublicUsers.fromJson(Map<String, dynamic> json) =>
      _$PublicUsersFromJson(json);
}
