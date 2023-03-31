import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../data/model/stripe/stripe_customer_params.dart';
import '../../../data/repository/zip_code/zipcode_repository_impl.dart';
import '../../../settings/hooks/use_router.dart';
import '../../../settings/routes/app_route.gr.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../utils/remove_nulls.dart';
import 'sample_view_model.dart';

final logger = Logger();

@RoutePage()
class SamplePage extends HookConsumerWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    // final l10n = useL10n();
    final appRoute = useRouter();
    // final appMQ = useMediaQuery();

    final addressController = useTextEditingController();
    final zipCodeController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('郵便番号から住所を補完したい'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
              // maxWidth: 400,
              ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: '郵便番号',
                ),
                maxLength: 7,
                onChanged: (value) async {
                  // 入力された文字数が7以外なら終了
                  if (value.length != 7) {
                    return;
                  }
                  // final result = ref
                  //     .watch(sampleViewModelProvider)
                  //     .value!
                  //     .getAddress(value);
                  final result = await ref
                      .watch(zipCodeToAddressRepositoryProvider)
                      .readZipCodeToAddress(zipcode: value);

                  // logger.i(result);
                  if (result == null) {
                    return;
                  }
                  final addressMap = result.first;
                  final address =
                      '${addressMap.address1} ${addressMap.address2} ${addressMap.address3}'; // 住所を連結する。

                  // final address = await zipCodeToAddress(value, ref);
                  // 返ってきた値がnullなら終了
                  // if (address == null) {
                  //   return;
                  // }
                  // 住所が帰ってきたら、addressControllerの中身を上書きする。
                  addressController.text = address;
                },
                controller: zipCodeController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: '住所',
                ),
                controller: addressController,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    appRoute.push(const Sample2Route());
                  },
                  child: const Text('sample'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    appRoute.push(const StripeRoute());
                  },
                  child: const Text('stripe'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  // onPressed: _handlePayPress,
                  onPressed: () async {
                    await ref.watch(sampleViewModelProvider).accountLink();
                    // logger.i("start");
                    // final callable = FirebaseFunctions.instanceFor(
                    //   region: 'asia-northeast1',
                    // ).httpsCallable('test1-now2');
                    // // final callable =
                    // //     FirebaseFunctions.instance.httpsCallable('test1-now2');
                    // final result = await callable.call();
                    // logger.i(result.data);
                    // logger.i("end");
                  },
                  child: const Text('url link'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () async {
                    logger.i('start');
                    final json = {'email': 'aaa@aaa.a.aa'};
                    final result = CustomerParams.fromJson(json);
                    logger.d(result);
                    final map = result.toJson();
                    logger.d(map);
                    // final m = map as Map;
                    final m = map.removeNulls();
                    logger.d(m);

                    logger.i('end');
                  },
                  child: const Text('params'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                // child: ElevatedButton(
                //   onPressed: () => showCupertinoModalBottomSheet(
                //     context: context,
                //     builder: (context) {
                //       return const Scaffold(body: Text('123'));
                //     },
                //   ),
                //   child: const Text('bottomsheet'),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Future<String?> zipCodeToAddress(String zipCode, ref) async {
//   if (zipCode.length != 7) {
//     return null;
//   }
  // ZipCodeToAddress response =ZipCodeToAddress.empty();
  // List<Address>? result;
  // final result =
      // await ref.watch(zipCodeToAddressViewModelProvider(zipCode)).value;
  // 正常なステータスコードが返ってきているか
  // if (response.status != 200) {
  //   return null;
  // }
  // ヒットした住所はあるか
  // final result = jsonDecode(response.body);
  // final result = response.results;
  // if (result!.isEmpty || result == null) {
  //   return null;
  // }
  // final addressMap = (result)!.first; // 結果が2つ以上のこともあるが、簡易的に最初のひとつを採用することとする。
  // final address =
  //     '${addressMap.address1} ${addressMap.address2} ${addressMap.address3}'; // 住所を連結する。
  // return address;
// }
