import 'package:freezed_annotation/freezed_annotation.dart';

part 'stripe_model.freezed.dart';
part 'stripe_model.g.dart';

//
@freezed
class LineItem with _$LineItem {
  const factory LineItem({
    required int quantity,
    required PriceData priceDate,
  }) = _LineItem;

  factory LineItem.fromJson(Map<String, dynamic> json) =>
      _$LineItemFromJson(json);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PriceData with _$PriceData {
  factory PriceData({
    int? unitAmount,
    String? currency,
    ProductData? productData,
  }) = _PriceData;

  factory PriceData.fromJson(Map<String, dynamic> json) =>
      _$PriceDataFromJson(json);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ProductData with _$ProductData {
  factory ProductData({
    String? name,
    String? description,
    List<String>? images,
    MetaData? metaData, // { productId: string }
  }) = _ProductData;

  factory ProductData.fromJson(Map<String, dynamic> json) =>
      _$ProductDataFromJson(json);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class MetaData with _$MetaData {
  factory MetaData({String? productId}) = _MetaData;

  factory MetaData.fromJson(Map<String, dynamic> json) =>
      _$MetaDataFromJson(json);
}
