import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../data/model/zip_code/zipcode_model.dart';
import '../../../data/repository/stripe/stripe_test_repository_impl.dart';
import '../../../data/repository/zip_code/zipcode_repository_impl.dart';

final logger = Logger();

// final zipCodeToAddressViewModelProvider =
//     FutureProvider.family<List<Address>?, String>((ref, zipCode) async {
//   final zipCodeToAddressRepository =
//       ref.read(zipCodeToAddressRepositoryProvider);
//   final address =
//       await zipCodeToAddressRepository.readZipCodeToAddress(zipcode: zipCode);
//   return address;
// });

final sampleViewModelProvider = Provider(SampleViewModel.new);

class SampleViewModel {
  SampleViewModel(this._ref);
  final Ref _ref;

  Future<List<Address>?> getAddress(String zipCode) async {
    return _ref
        .read(zipCodeToAddressRepositoryProvider)
        .readZipCodeToAddress(zipcode: zipCode);
  }

  Future<void> accountLink() async {
    // final accountId = await _ref
    //     .read(stripeRepositoryProvider)
    //     .createAccounts(email: "temsk3@gmail.com");
    // logger.i(accountId);

    const accountId = 'acct_1M8qe1Pr0W8Poldq';
    // const refreshUrl = "http://localhost:53875/#/";
    // const returnUrl = "http://localhost:53875/#/success";
    // const type = "account_onboarding";
    // final url = await _ref.read(stripeRepositoryProvider).createAccountLink(
    //     accountId: accountId,
    //     refreshUrl: refreshUrl,
    //     returnUrl: returnUrl,
    //     type: type);
    // logger.i(url);

    // return goUrl(url);
    // final result = await _ref
    //     .read(firebaseFunctionsProvider)
    //     .httpsCallable('test1-now2')
    //     .call();
    // logger.i(result.data);
    // final individualId = _ref
    //     .read(stripeRepositoryProvider)
    //     .retrieveAccounts(accountId: accountId);
    // logger.i(individualId);
    Map<String, String> idempotencyKey() {
      final idempotencyKey = {
        'idempotencyKey': const Uuid().v4(),
      };
      return idempotencyKey;
    }

    final idempotency = idempotencyKey();
    // {
    //   'idempotencyKey': const Uuid().v4(),
    // };
    final params = {
      'accountId': accountId,
      'idempotencyKey': idempotency,
    };
    logger.d(params);
    // final callable = FirebaseFunctions.instanceFor(
    //   region: 'asia-northeast1',
    // ).httpsCallable('v1-stripe-account-onRetrieve');
    // final functionResult = await callable.call(params);
    // logger.d(functionResult);
    // final data = functionResult.data;
    // logger.d(data);
    // logger.d(data['id']);
  }

  Future<void> checkoutSession() async {
    final url =
        await _ref.read(stripeRepositoryProvider).setupCheckoutSession();
    return goUrl(url);
  }

  Future<void> goUrl(String url) async {
    // final url = "https://www.mechengjp.com/";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), webOnlyWindowName: '_self');
    } else {
      logger.e('Could not launch URL');
      final Error error = ArgumentError('Error launching $url');
      throw error;
    }
  }
}
