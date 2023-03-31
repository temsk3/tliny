import 'package:freezed_annotation/freezed_annotation.dart';

part 'stripe_model.freezed.dart';
part 'stripe_model.g.dart';

//
@freezed
class LineItem with _$LineItem {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory LineItem({
    required int quantity,
    required PriceData priceDate,
  }) = _LineItem;

  factory LineItem.fromJson(Map<String, dynamic> json) =>
      _$LineItemFromJson(json);
}

@freezed
class PriceData with _$PriceData {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  factory PriceData({
    required int unitAmount,
    required String currency,
    required ProductData productData,
  }) = _PriceData;

  factory PriceData.fromJson(Map<String, dynamic> json) =>
      _$PriceDataFromJson(json);
}

@freezed
class ProductData with _$ProductData {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  factory ProductData({
    required String name,
    required String description,
    required List<String> images,
    required MetaData metaData, // { productId: string }
  }) = _ProductData;

  factory ProductData.fromJson(Map<String, dynamic> json) =>
      _$ProductDataFromJson(json);
}

@freezed
class MetaData with _$MetaData {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory MetaData({
    required String productId,
  }) = _MetaData;

  factory MetaData.fromJson(Map<String, dynamic> json) =>
      _$MetaDataFromJson(json);
}
