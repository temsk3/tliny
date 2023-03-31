import '../../model/zip_code/zipcode_model.dart';

abstract class ZipCodeToAddressRepository {
  //
  Future<List<Address>?> readZipCodeToAddress({required String zipcode});
}
