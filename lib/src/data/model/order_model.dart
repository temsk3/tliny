// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'util/json_converter.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

//
@freezed
class Order with _$Order {
  @JsonSerializable(explicitToJson: true)
  const factory Order({
    String? id,
    StatusType? status,
    String? paymentIntentId,
    String? checkoutSessionId,
    String? userId,
    String? eventId,
    @timestampKey DateTime? purchaseTime,
    List<SnapshotProduct>? snapshotProducts,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

@freezed
class SnapshotProduct with _$SnapshotProduct {
  @JsonSerializable(explicitToJson: true)
  const factory SnapshotProduct({
    @documentReferenceKey
        DocumentReference<Map<String, dynamic>>? productDocRef,
    int? quantity,
    // 購入者
    String? userId,
    String? userName,
    // 商品情報
    String? productId,
    int? exchangeNumber,
    String? code,
    String? name,
    // genre: string
    String? desc,
    int? price,
    List<String>? pictureURL,
    @timestampKey DateTime? expirationFrom,
    @timestampKey DateTime? expirationTo,
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
    @Default(true) bool expirationLink,
    // Stripe
    String? priceId,
  }) = _SnapshotProduct;
  factory SnapshotProduct.fromJson(Map<String, dynamic> json) =>
      _$SnapshotProductFromJson(json);
}

enum StatusType {
  pre(name: 'Pre'),
  order(name: 'Order'),
  cancel(name: 'Cancel');

  const StatusType({required this.name});
  final String name;
}
