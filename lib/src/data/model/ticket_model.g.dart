// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ticket _$TicketFromJson(Map<String, dynamic> json) => _Ticket(
  id: json['id'] as String?,
  paidUserId: json['paidUserId'] as String?,
  paidUserName: json['paidUserName'] as String?,
  purchaseTime: const TimestampConverter().fromJson(
    json['purchaseTime'] as Timestamp?,
  ),
  ownerId: json['ownerId'] as String?,
  ownerName: json['ownerName'] as String?,
  assignment: (json['assignment'] as List<dynamic>?)
      ?.map((e) => Assignment.fromJson(e as Map<String, dynamic>))
      .toList(),
  isActive: json['isActive'] as bool? ?? true,
  isPrinting: json['isPrinting'] as bool? ?? false,
  isUsed: json['isUsed'] as bool? ?? false,
  uuid: json['uuid'] as String?,
  pdfUuid: json['pdfUuid'] as String?,
  productDocRef: const DocumentReferenceNullStringConverter().fromJson(
    json['productDocRef'] as DocumentReference<Object?>?,
  ),
  productId: json['productId'] as String?,
  code: json['code'] as String?,
  name: json['name'] as String?,
  desc: json['desc'] as String?,
  price: (json['price'] as num?)?.toInt(),
  pictureURL:
      (json['pictureURL'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  expirationFrom: const TimestampConverter().fromJson(
    json['expirationFrom'] as Timestamp?,
  ),
  expirationTo: const TimestampConverter().fromJson(
    json['expirationTo'] as Timestamp?,
  ),
  register: json['register'] as String?,
  registerName: json['registerName'] as String?,
  organizerDocRef: const DocumentReferenceNullStringConverter().fromJson(
    json['organizerDocRef'] as DocumentReference<Object?>?,
  ),
  organizerId: json['organizerId'] as String?,
  eventDocRef: const DocumentReferenceNullStringConverter().fromJson(
    json['eventDocRef'] as DocumentReference<Object?>?,
  ),
  eventId: json['eventId'] as String?,
  eventName: json['eventName'] as String?,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp?,
  ),
  updatedAt: const TimestampConverter().fromJson(
    json['updatedAt'] as Timestamp?,
  ),
  deletedAt: const TimestampConverter().fromJson(
    json['deletedAt'] as Timestamp?,
  ),
);

Map<String, dynamic> _$TicketToJson(_Ticket instance) => <String, dynamic>{
  'id': instance.id,
  'paidUserId': instance.paidUserId,
  'paidUserName': instance.paidUserName,
  'purchaseTime': const TimestampConverter().toJson(instance.purchaseTime),
  'ownerId': instance.ownerId,
  'ownerName': instance.ownerName,
  'assignment': instance.assignment,
  'isActive': instance.isActive,
  'isPrinting': instance.isPrinting,
  'isUsed': instance.isUsed,
  'uuid': instance.uuid,
  'pdfUuid': instance.pdfUuid,
  'productDocRef': const DocumentReferenceNullStringConverter().toJson(
    instance.productDocRef,
  ),
  'productId': instance.productId,
  'code': instance.code,
  'name': instance.name,
  'desc': instance.desc,
  'price': instance.price,
  'pictureURL': instance.pictureURL,
  'expirationFrom': const TimestampConverter().toJson(instance.expirationFrom),
  'expirationTo': const TimestampConverter().toJson(instance.expirationTo),
  'register': instance.register,
  'registerName': instance.registerName,
  'organizerDocRef': const DocumentReferenceNullStringConverter().toJson(
    instance.organizerDocRef,
  ),
  'organizerId': instance.organizerId,
  'eventDocRef': const DocumentReferenceNullStringConverter().toJson(
    instance.eventDocRef,
  ),
  'eventId': instance.eventId,
  'eventName': instance.eventName,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'deletedAt': const TimestampConverter().toJson(instance.deletedAt),
};

_Assignment _$AssignmentFromJson(Map<String, dynamic> json) => _Assignment(
  from: json['from'] as String?,
  to: json['to'] as String?,
  assignmentDate: dateFromTimestampValue(json['assignmentDate']),
);

Map<String, dynamic> _$AssignmentToJson(_Assignment instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'assignmentDate': timestampFromDateValue(instance.assignmentDate),
    };

_UsageHistory _$UsageHistoryFromJson(Map<String, dynamic> json) =>
    _UsageHistory(
      id: json['id'] as String?,
      dateOfUse: dateFromTimestampValue(json['dateOfUse']),
      eventId: json['eventId'] as String?,
      receptionistId: json['receptionistId'] as String?,
      useTicket: (json['useTicket'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: dateFromTimestampValue(json['createdAt']),
      updatedAt: dateFromTimestampValue(json['updatedAt']),
      deletedAt: dateFromTimestampValue(json['deletedAt']),
    );

Map<String, dynamic> _$UsageHistoryToJson(_UsageHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dateOfUse': timestampFromDateValue(instance.dateOfUse),
      'eventId': instance.eventId,
      'receptionistId': instance.receptionistId,
      'useTicket': instance.useTicket,
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
      'deletedAt': timestampFromDateValue(instance.deletedAt),
    };
