// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'util/json_converter.dart';

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
    String? purchaseTime,
    // 所有者
    String? ownerId,
    String? ownerName,
    List<Assignment>? assignment,
    @Default(true) bool isActive,
    @Default(false) bool isPrinting,
    // 商品情報
    String? productId,
    int? exchangeNumber,
    String? code,
    String? name,
    // genre: string
    String? desc,
    int? price,
    @Default([]) List<String> pictureURL,
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
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  }) = _Ticket;

  const Ticket._();

  factory Ticket.empty() => const Ticket(
        assignment: [],
        isActive: true,
        isPrinting: false,
        pictureURL: [],
        expirationLink: true,
        // Stripe
        // priceId: string
      );

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
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
