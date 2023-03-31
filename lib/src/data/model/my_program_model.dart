// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'util/json_converter.dart';

part 'my_program_model.freezed.dart';
part 'my_program_model.g.dart';

@freezed
class MyProgram with _$MyProgram {
  factory MyProgram({
    String? id,
    required String? programId,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  }) = _MyProgram;

  const MyProgram._();
  factory MyProgram.empty() => MyProgram(
        programId: '123',
      );
  factory MyProgram.fromJson(Map<String, dynamic> json) =>
      _$MyProgramFromJson(json);
}
