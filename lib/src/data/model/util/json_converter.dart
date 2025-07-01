import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../product_model.dart';

// firestore から受け取った Timestamp型を DateTime型に変換するためにJsonKeyを作成 @Timestamp DateTime
DateTime? dateFromTimestampValue(dynamic value) =>
    value != null ? (value as Timestamp).toDate() : null;

Timestamp? timestampFromDateValue(dynamic value) =>
    value is DateTime ? Timestamp.fromDate(value) : null;

const timestampKey = JsonKey(
  fromJson: dateFromTimestampValue,
  toJson: timestampFromDateValue,
);

// firestore から受け取った document型を保存するためのJsonKey
DocumentReference<Map<String, dynamic>>? documentReference(
  DocumentReference<Map<String, dynamic>>? value,
) => value;

const documentReferenceKey = JsonKey(
  fromJson: documentReference,
  toJson: documentReference,
);

// enum型を String型に変換するためにJsonKeyを作成 @document
Enum? genreTypeEnumFromString(String? value) =>
    EnumToString.fromString(GenreType.values, value ?? '');

String? stringFromGenreTypeEnum(GenreType? value) =>
    value != null ? EnumToString.convertToString(value) : null;

const genreTypeKey = JsonKey(
  fromJson: genreTypeEnumFromString,
  toJson: stringFromGenreTypeEnum,
);
