import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/product_model.dart';
import '../../data/model/program_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../../ui/common/main_body.dart';
import '../../ui/product/widget/product_button.dart';
import '../../utils/logger.dart';
import '../common/asyncvalue_widget.dart';
import '../image/image_screen.dart';
import 'product_state.dart';
import 'product_view_model.dart';

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
    // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    // final appRoute = useRouter();
    final appMediaQuery = useMediaQuery();
    final state = ref.watch(productStateProvider(product.id.toString()));
    // final state = ref.watch(productViewModelProvider);
    final viewModel = ref.watch(productViewModelProvider.notifier);

    final quantity = useState<int>(1);

    return AsyncValueWidget(
      value: state,
      data: (data) {
        logger.d(data);

        final code = data.code ?? 'No code';
        final name = data.name ?? 'No Name';
        final genre = data.genre!.name;
        final desc = data.desc ?? 'No Desc';
        final stock = data.stock;
        final price = data.price;
        final picture = data.pictureURL;
        final expirationFrom = data.expirationFrom!;
        final expirationTo = data.expirationTo!;

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.product),
          ),
          body: MainBodyWidget(
            width: 400,
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                      ),
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
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      TextFormField(
                        enabled: false,
                        initialValue: name,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: l10n.productName,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      TextFormField(
                        enabled: false,
                        initialValue: desc,
                        maxLines: 2,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: l10n.productDescription,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              enabled: false,
                              initialValue: l10n.decimalPattern(stock),
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
                              enabled: false,
                              initialValue: l10n.currency(price),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: l10n.price,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      //
                      Row(
                        children: [
                          Text(
                            l10n.validPeriod,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                          Flexible(
                            child: TextFormField(
                              style: const TextStyle(fontSize: 12),
                              initialValue: l10n.date(expirationFrom),
                              enabled: false,
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
                              style: const TextStyle(fontSize: 12),
                              initialValue: l10n.date(expirationTo),
                              enabled: false,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'To',
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
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
                              onChanged: (value) =>
                                  {quantity.value = int.parse(value!)},
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
                          const SizedBox(
                            width: 24,
                          ),
                          Flexible(
                            child: DeleteProductElevatedButton(
                              product: product,
                            ),
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
      },
    );
  }
}
