// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'product_model.dart';
import 'staff_model.dart';
import 'util/json_converter.dart';

part 'program_model.freezed.dart';
part 'program_model.g.dart';

//
@freezed
class Program with _$Program {
  const factory Program({
    String? id,
    required String? organizerId,
    required String? name,
    required String? message,
    @timestampKey required DateTime? salesStart,
    @timestampKey required DateTime? salesEnd,
    @timestampKey required DateTime? eventFrom,
    @timestampKey required DateTime? eventTo,
    required String? place,
    String? storageId,
    @Default([]) List<String> pictureURL,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
    required bool? isActive,
    required bool? isPublish, //
    String? staffCode,
    List<Staff>? staff,
    List<Product>? product,
  }) = _Program;

  const Program._();

  factory Program.empty() => const Program(
        organizerId: '',
        name: '',
        message: '',
        salesStart: null,
        salesEnd: null,
        eventFrom: null,
        eventTo: null,
        place: '',
        isActive: true,
        isPublish: false,
        staff: [],
      );

  factory Program.fromJson(Map<String, dynamic> json) =>
      _$ProgramFromJson(json);

  // factory Program.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();
  //   return Program(
  //     id: data?['id'],
  //     organizerId: data?['organizerId'],
  //     name: data?['name'],
  //     message: data?['message'],
  //     salesStart: data?['salesStart'],
  //     salesEnd: data?['salesEnd'],
  //     eventFrom: data?['eventFrom'],
  //     eventTo: data?['eventTo'],
  //     place: data?['place'],
  //     pictureURL: ['pictureURL'],
  //     isActive: data?['isActive'],
  //     isPublish: data?['isPublish'],
  //   );
  // }
}
