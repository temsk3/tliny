import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/json_converter.dart';

part 'ticket_qrcode_data_model.freezed.dart';
part 'ticket_qrcode_data_model.g.dart';

@freezed
class TicketQRCodeDataModel with _$TicketQRCodeDataModel {
  factory TicketQRCodeDataModel({
    String? id,
    required String codeData,
    @Default(true) bool isActive,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? deletedAt,
  }) = _TicketQRCodeDataModel;

  factory TicketQRCodeDataModel.fromJson(Map<String, dynamic> json) =>
      _$TicketQRCodeDataModelFromJson(json);
}
