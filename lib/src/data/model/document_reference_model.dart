import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/json_converter.dart';

part 'document_reference_model.freezed.dart';
part 'document_reference_model.g.dart';

@freezed
class DocRefModel with _$DocRefModel {
  factory DocRefModel(@DocumentReferenceNullStringConverter() String? docRef) =
      _DocRefModel;

  factory DocRefModel.fromJson(Map<String, dynamic> json) =>
      _$DocRefModelFromJson(json);
}
