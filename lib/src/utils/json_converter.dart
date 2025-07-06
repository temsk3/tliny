import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// firestore から受け取った Timestamp型を DateTime型に変換するためにJsonKeyを作成 @Timestamp DateTime
DateTime? dateFromTimestampValue(dynamic value) =>
    value != null ? (value as Timestamp).toDate() : null;

Timestamp? timestampFromDateValue(dynamic value) =>
    value is DateTime ? Timestamp.fromDate(value) : null;

const timestampKey = JsonKey(
  fromJson: dateFromTimestampValue,
  toJson: timestampFromDateValue,
);

class TimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Timestamp? json) => json?.toDate();

  @override
  Timestamp? toJson(DateTime? object) =>
      object == null ? null : Timestamp.fromDate(object);
}

// firestore から受け取った document型を保存するためのJsonKey
DocumentReference<Map<String, dynamic>>? documentReference(
  DocumentReference<Map<String, dynamic>>? value,
) => value;

const documentReferenceKey = JsonKey(
  fromJson: documentReference,
  toJson: documentReference,
);

class DocumentReferenceConverter
    implements JsonConverter<DocumentReference, DocumentReference> {
  const DocumentReferenceConverter();

  @override
  DocumentReference fromJson(DocumentReference docRef) => docRef;

  @override
  DocumentReference toJson(DocumentReference docRef) => docRef;
}

class DocumentReferenceStringConverter
    implements JsonConverter<String, DocumentReference> {
  const DocumentReferenceStringConverter();

  @override
  String fromJson(DocumentReference ref) => ref.id;

  @override
  DocumentReference toJson(String str) => FirebaseFirestore.instance.doc(str);
}

class DocumentReferenceNullStringConverter
    implements JsonConverter<String?, DocumentReference?> {
  const DocumentReferenceNullStringConverter();

  @override
  String? fromJson(DocumentReference? ref) => ref?.path;

  @override
  DocumentReference? toJson(String? str) =>
      str == null ? null : FirebaseFirestore.instance.doc(str);
}
