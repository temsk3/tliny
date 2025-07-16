// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'util/json_converter.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

enum GenreType {
  goods(name: '物品'),
  foods(name: '食品'),
  others(name: 'その他');

  const GenreType({required this.name});

  final String name;
}

//
@freezed
class Product with _$Product {
  const factory Product({
    // 商品情報
    String? id,
    int? exchangeNumber, //
    String? code,
    required String? name,
    @JsonKey(unknownEnumValue: GenreType.others) required GenreType? genre,
    required String? desc,
    @Default(0) int stock,
    @Default(50) int price,
    String? strageId,
    @Default([]) List<String> pictureURL,
    @timestampKey required DateTime? expirationFrom,
    @timestampKey required DateTime? expirationTo,
    required bool? isActive,
    required bool? isPublish, //
    String? priceId, //
    // 登録者
    String? register,
    // 開催者
    @documentReferenceKey
    DocumentReference<Map<String, dynamic>>? organizerDocRef,
    String? organizerId,
    // イベント情報
    @documentReferenceKey DocumentReference<Map<String, dynamic>>? eventDocRef,
    String? eventId,
    String? eventName,
    bool? expirationLink,
    @timestampKey required DateTime? salesStart,
    @timestampKey required DateTime? salesEnd,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  }) = _Product;

  const Product._();

  factory Product.empty() => Product(
    register: '',
    code: '',
    name: '',
    genre: GenreType.others,
    desc: '',
    price: 50,
    pictureURL: [],
    expirationFrom: DateTime(1999, 12, 31, 23, 59),
    expirationTo: DateTime(1999, 12, 31, 23, 59),
    isActive: true,
    isPublish: true,
    salesStart: DateTime(1999, 12, 31, 23, 59),
    salesEnd: DateTime(1999, 12, 31, 23, 59),
    organizerId: '',
    eventId: '',
    eventName: '',
  );

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@freezed
class ProductQueryParameter with _$ProductQueryParameter {
  factory ProductQueryParameter(String? programId, GenreType? genre) =
      _ProductQueryParameter;

  factory ProductQueryParameter.fromJson(Map<String, dynamic> json) =>
      _$ProductQueryParameterFromJson(json);
}
