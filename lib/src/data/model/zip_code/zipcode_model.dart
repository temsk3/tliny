import 'package:freezed_annotation/freezed_annotation.dart';

part 'zipcode_model.freezed.dart';
part 'zipcode_model.g.dart';

//
// @freezed
// class ZipCodeToAddress with _$ZipCodeToAddress {
//   @JsonSerializable(explicitToJson: true)
//   const ZipCodeToAddress._();

//   const factory ZipCodeToAddress({
//     required String? message,
//     required List<Address>? results,
//     required String status,
//   }) = _ZipCodeToAddress;

//   factory ZipCodeToAddress.fromJson(Map<String, dynamic> json) =>
//       _$ZipCodeToAddressFromJson(json);

//   Address toEntity() => Address(
//         address1: results?[0].address1 ?? "",
//         address2: results?[0].address2 ?? "",
//         address3: results?[0].address3 ?? "",
//         kana1: results?[0].kana1 ?? "",
//         kana2: results?[0].kana2 ?? "",
//         kana3: results?[0].kana3 ?? "",
//         prefcode: results?[0].prefcode ?? "",
//         zipcode: results?[0].zipcode ?? "",
//       );

//   factory ZipCodeToAddress.empty() => const ZipCodeToAddress(
//         message: '',
//         results: [],
//         status: "400",
//       );
// }

@freezed
class Address with _$Address {
  // @JsonSerializable(explicitToJson: true)
  const Address._();
  const factory Address({
    required String address1,
    required String address2,
    required String address3,
    required String kana1,
    required String kana2,
    required String kana3,
    required String prefcode,
    required String zipcode,
  }) = _Address;
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}
