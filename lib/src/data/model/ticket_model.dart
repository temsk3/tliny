// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/json_converter.dart';

part 'ticket_model.freezed.dart';
part 'ticket_model.g.dart';

//
@freezed
class Ticket with _$Ticket {
  const factory Ticket({
    String? id,
    // 購入者
    String? paidUserId,
    String? paidUserName,
    @TimestampConverter() DateTime? purchaseTime,
    // 所有者
    String? ownerId,
    String? ownerName,
    List<Assignment>? assignment,
    @Default(true) bool isActive,
    @Default(false) bool isPrinting,
    @Default(false) bool isUsed,
    String? uuid,
    String? pdfUuid,
    // 商品情報
    @DocumentReferenceNullStringConverter() String? productDocRef,
    String? productId,
    // int? exchangeNumber,
    String? code,
    String? name,
    // genre: string
    String? desc,
    int? price,
    @Default([]) List<String> pictureURL,
    @TimestampConverter() DateTime? expirationFrom,
    @TimestampConverter() DateTime? expirationTo,
    // 登録者
    String? register,
    String? registerName,
    // 開催者
    @DocumentReferenceNullStringConverter() String? organizerDocRef,
    String? organizerId,
    // イベント情報
    @DocumentReferenceNullStringConverter() String? eventDocRef,
    String? eventId,
    String? eventName,
    // @Default(true) bool expirationLink,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? deletedAt,
  }) = _Ticket;

  const Ticket._();

  factory Ticket.empty() => const Ticket(
    assignment: [],
    // Stripe
    // priceId: string
  );

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  factory Ticket.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Ticket.fromJson(data).copyWith(id: doc.id);
  }

  Map<String, dynamic> toFirestore() {
    final data = toJson()..remove('id');
    if (data['assignment'] != null) {
      data['assignment'] =
          (data['assignment'] as List<dynamic>)
              .map((e) => (e as Assignment).toJson())
              .toList();
    }
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ticket && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

@freezed
class Assignment with _$Assignment {
  const factory Assignment({
    String? from,
    String? to,
    @timestampKey DateTime? assignmentDate,
  }) = _Assignment;
  factory Assignment.fromJson(Map<String, dynamic> json) =>
      _$AssignmentFromJson(json);
}

@freezed
class UsageHistory with _$UsageHistory {
  factory UsageHistory({
    String? id,
    @timestampKey required DateTime? dateOfUse,
    required String? eventId,
    required String? receptionistId,
    required List<String>? useTicket,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  }) = _UsageHistory;

  const UsageHistory._();

  factory UsageHistory.empty() => UsageHistory(
    dateOfUse: DateTime(1999, 12, 31, 23, 59),
    eventId: null,
    receptionistId: null,
    useTicket: [],
  );
  factory UsageHistory.fromJson(Map<String, dynamic> json) =>
      _$UsageHistoryFromJson(json);
}
