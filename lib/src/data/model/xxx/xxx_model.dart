// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../util/json_converter.dart';

part 'xxx_model.freezed.dart';
part 'xxx_model.g.dart';

//
@freezed
class Xxx with _$Xxx {
  const Xxx._();

  const factory Xxx({
    String? id,
    required String data,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  }) = _Xxx;

  factory Xxx.fromJson(Map<String, dynamic> json) => _$XxxFromJson(json);
}
