import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/product_model.dart';
import '../../data/model/program_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../ui/common/main_body.dart';
import '../../ui/product/widget/product_button.dart';
import '../../utils/logger.dart';
import '../image/image_screen.dart';

// @RoutePage()
class ProductDetailsPage extends HookConsumerWidget {
  const ProductDetailsPage({
    super.key,
    required this.program,
    required this.product,
  });
  final Program program;
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    // final appRoute = useRouter();
    // // final appMediaQuery = useMediaQuery();
    // final state = ref.watch(productStateProvider(product.id?.toString() ?? ''));
    // final state = ref.watch(productViewModelProvider);
    // // final viewModel = ref.watch(productViewModelProvider.notifier);

    final quantity = useState<int>(1);

    // 渡されたproductオブジェクトを直接使用
    final data = product;
    logger.d('ProductDetailsPage: using passed product data=$data');
    logger.d('ProductDetailsPage: product.id=${data.id}');
    logger.d('ProductDetailsPage: product.name=${data.name}');
    logger.d('ProductDetailsPage: product.price=${data.price}');

    // final code = data.code ?? l10n.noCode;
    final name = data.name ?? l10n.noName;
    final desc = data.desc ?? l10n.noDesc;
    final stock = data.stock;
    final price = data.price;
    final picture = data.pictureURL;
    final expirationFrom = data.expirationFrom ?? DateTime.now();
    final expirationTo = data.expirationTo ?? DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.product),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: MainBodyWidget(
        width: 400,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                  PictureView(
                    picture: picture,
                    index: 0,
                    height: 90,
                    width: 160,
                  ),
                  const SizedBox(height: 24),
                  // Row(
                  //   children: [
                  //     Flexible(
                  //       child: TextFormField(
                  //         enabled: false,
                  //         initialValue: code,
                  //         decoration: InputDecoration(
                  //           border: const OutlineInputBorder(),
                  //           labelText: l10n.code,
                  //         ),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ),
                  //     const Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 8),
                  //     ),
                  //     Flexible(
                  //       child: TextFormField(
                  //         enabled: false,
                  //         initialValue: genre,
                  //         decoration: InputDecoration(
                  //           border: const OutlineInputBorder(),
                  //           labelText: l10n.genre,
                  //         ),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                  TextFormField(
                    initialValue: name,
                    readOnly: true,
                    enableInteractiveSelection: false,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: l10n.productName,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                  TextFormField(
                    initialValue: desc,
                    readOnly: true,
                    enableInteractiveSelection: false,
                    style: const TextStyle(color: Colors.black),
                    maxLines: 2,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: l10n.productDescription,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          initialValue: l10n.decimalPattern(stock),
                          readOnly: true,
                          enableInteractiveSelection: false,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: l10n.stock,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      Flexible(
                        child: TextFormField(
                          initialValue: l10n.currency(price),
                          readOnly: true,
                          enableInteractiveSelection: false,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: l10n.price,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                  //
                  Row(
                    children: [
                      Text(l10n.validPeriod),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      Flexible(
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          initialValue: l10n.date(expirationFrom),
                          readOnly: true,
                          enableInteractiveSelection: false,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'From',
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                      ),
                      Flexible(
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          initialValue: l10n.date(expirationTo),
                          readOnly: true,
                          enableInteractiveSelection: false,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'To',
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 12)),
                  //   //
                  //   PictureView(
                  //     picture: picture,
                  //     index: 0,
                  //     height: 90,
                  //     width: 160,
                  //   ),
                  //   //
                  //   const SizedBox(height: 8),
                  //   Text(
                  //     code,
                  //     maxLines: 1,
                  //   ),
                  //   const SizedBox(height: 8),
                  //   Text(
                  //     name,
                  //     maxLines: 1,
                  //   ),
                  //   const SizedBox(height: 8),
                  //   Text(
                  //     genre,
                  //     maxLines: 1,
                  //   ),
                  //   const SizedBox(height: 8),
                  //   Text(
                  //     desc,
                  //     maxLines: 2,
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                  //   const SizedBox(height: 8),
                  //   Text(
                  //     l10n.decimalPattern(stock),
                  //     maxLines: 1,
                  //   ),
                  //   const SizedBox(height: 8),
                  //   Text(
                  //     l10n.currency(price),
                  //     maxLines: 1,
                  //   ),
                  //   const SizedBox(height: 8),
                  //   Text(
                  //     l10n.dataTime(expirationFrom),
                  //     maxLines: 1,
                  //   ),
                  //   const SizedBox(height: 8),
                  //   Text(
                  //     l10n.dataTime(expirationTo),
                  //     maxLines: 1,
                  // ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${l10n.quantity} : '),
                      const SizedBox(width: 12),
                      Flexible(
                        child: AmountDropdownButton(
                          product: product,
                          value: quantity.value.toString(),
                          onChanged:
                              (value) => {quantity.value = int.parse(value!)},
                        ),
                      ),
                      const SizedBox(width: 24),
                      Flexible(
                        child: InCartElevatedButton(
                          product: product,
                          quantity: quantity.value,
                          program: program,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: EditProductElevatedButton(
                          program: program,
                          product: product,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Flexible(
                        child: DeleteProductElevatedButton(product: product),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
