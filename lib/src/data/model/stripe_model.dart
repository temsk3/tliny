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
class PriceData with _$PriceData {
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
  factory MetaData({@JsonKey(name: 'product_id') required String productId}) = _MetaData;

  factory MetaData.fromJson(Map<String, dynamic> json) =>
      _$MetaDataFromJson(json);
}
