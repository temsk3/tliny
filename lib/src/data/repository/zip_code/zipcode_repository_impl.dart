import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../model/zip_code/zipcode_model.dart';
import '../../service/zipcode_api_client.dart';
import 'zipcode_repository.dart';

final logger = Logger();

final zipCodeToAddressRepositoryProvider = Provider<ZipCodeToAddressRepository>(
    (ref) => ZipCodeToAddressRepositoryImpl());

class ZipCodeToAddressRepositoryImpl implements ZipCodeToAddressRepository {
  ZipCodeToAddressRepositoryImpl();

  final api = ZipCodeToAddressApiClient();

  @override
  Future<List<Address>?> readZipCodeToAddress({required String zipcode}) async {
    final addressList = await api.getZipCodeToAddress(zipcode);

    // final dio = Dio();
    // final client = ZipCodeToAddressApiClient(dio);
    // final response = await client.getZipCodeToAddress(zipcode);

    return addressList;
  }
}
