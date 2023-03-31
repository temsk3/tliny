// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Ticket _$$_TicketFromJson(Map<String, dynamic> json) => _$_Ticket(
      id: json['id'] as String?,
      paidUserId: json['paidUserId'] as String?,
      paidUserName: json['paidUserName'] as String?,
      purchaseTime: json['purchaseTime'] as String?,
      ownerId: json['ownerId'] as String?,
      ownerName: json['ownerName'] as String?,
      assignment: (json['assignment'] as List<dynamic>?)
          ?.map((e) => Assignment.fromJson(e as Map<String, dynamic>))
          .toList(),
      isActive: json['isActive'] as bool? ?? true,
      isPrinting: json['isPrinting'] as bool? ?? false,
      productId: json['productId'] as String?,
      exchangeNumber: json['exchangeNumber'] as int?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      desc: json['desc'] as String?,
      price: json['price'] as int?,
      pictureURL: (json['pictureURL'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      expirationFrom: dateFromTimestampValue(json['expirationFrom']),
      expirationTo: dateFromTimestampValue(json['expirationTo']),
      register: json['register'] as String?,
      organizerDocRef: documentReference(
          json['organizerDocRef'] as DocumentReference<Map<String, dynamic>>?),
      organizerId: json['organizerId'] as String?,
      eventDocRef: documentReference(
          json['eventDocRef'] as DocumentReference<Map<String, dynamic>>?),
      eventId: json['eventId'] as String?,
      eventName: json['eventName'] as String?,
      expirationLink: json['expirationLink'] as bool? ?? true,
      createdAt: dateFromTimestampValue(json['createdAt']),
      updatedAt: dateFromTimestampValue(json['updatedAt']),
      deletedAt: dateFromTimestampValue(json['deletedAt']),
    );

Map<String, dynamic> _$$_TicketToJson(_$_Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'paidUserId': instance.paidUserId,
      'paidUserName': instance.paidUserName,
      'purchaseTime': instance.purchaseTime,
      'ownerId': instance.ownerId,
      'ownerName': instance.ownerName,
      'assignment': instance.assignment,
      'isActive': instance.isActive,
      'isPrinting': instance.isPrinting,
      'productId': instance.productId,
      'exchangeNumber': instance.exchangeNumber,
      'code': instance.code,
      'name': instance.name,
      'desc': instance.desc,
      'price': instance.price,
      'pictureURL': instance.pictureURL,
      'expirationFrom': timestampFromDateValue(instance.expirationFrom),
      'expirationTo': timestampFromDateValue(instance.expirationTo),
      'register': instance.register,
      'organizerDocRef': documentReference(instance.organizerDocRef),
      'organizerId': instance.organizerId,
      'eventDocRef': documentReference(instance.eventDocRef),
      'eventId': instance.eventId,
      'eventName': instance.eventName,
      'expirationLink': instance.expirationLink,
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
      'deletedAt': timestampFromDateValue(instance.deletedAt),
    };

_$_Assignment _$$_AssignmentFromJson(Map<String, dynamic> json) =>
    _$_Assignment(
      from: json['from'] as String?,
      to: json['to'] as String?,
      assignmentDate: dateFromTimestampValue(json['assignmentDate']),
    );

Map<String, dynamic> _$$_AssignmentToJson(_$_Assignment instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'assignmentDate': timestampFromDateValue(instance.assignmentDate),
    };

_$_UsageHistory _$$_UsageHistoryFromJson(Map<String, dynamic> json) =>
    _$_UsageHistory(
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

Map<String, dynamic> _$$_UsageHistoryToJson(_$_UsageHistory instance) =>
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
