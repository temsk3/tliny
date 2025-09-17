// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'util/json_converter.dart';

part 'favorite_model.freezed.dart';
part 'favorite_model.g.dart';

//
@freezed
class Favorite with _$Favorite {
  const factory Favorite({
    String? id,
    required String? programId,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  }) = _Favorite;

  const Favorite._();

  factory Favorite.empty() => const Favorite(programId: '');

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);
}
