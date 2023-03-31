// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'util/json_converter.dart';

part 'staff_model.freezed.dart';
part 'staff_model.g.dart';

//
@freezed
class Staff with _$Staff {
  const factory Staff({
    String? id,
    required String? displayName,
    required String? name,
    required String? email,
    @Default(true) bool? isCreated,
    @Default(true) bool? isRetrieve,
    @Default(true) bool? isUpdated,
    @Default(true) bool? isDeleted,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
    @Default(false) bool? isActive,
  }) = _Staff;

  const Staff._();

  factory Staff.empty() => const Staff(
        displayName: '',
        name: '',
        email: '',
      );

  factory Staff.fromJson(Map<String, dynamic> json) => _$StaffFromJson(json);
}
