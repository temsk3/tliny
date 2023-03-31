import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../data/model/product_model.dart';
import '../../data/model/program_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../../settings/hooks/use_router.dart';
import '../../settings/theme/app_theme.dart';
import '../../ui/common/main_body.dart';
import '../../ui/product/widget/product_button.dart';
import '../common/asyncvalue_widget.dart';
import '../image/image_screen.dart';
import 'product_state.dart';
import 'product_view_model.dart';

final logger = Logger();

@RoutePage()
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
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final appMediaQuery = useMediaQuery();
    final state = ref.watch(productStateProvider(product.id.toString()));
    // final state = ref.watch(productViewModelProvider);
    final viewModel = ref.watch(productViewModelProvider.notifier);

    final quantity = useState<int>(1);

    return AsyncValueWidget(
      value: state,
      data: (data) {
        logger.d(data);

        final code = data.code ?? 'No Image';
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
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      //
                      PictureDetailView(
                        picture: picture,
                        height: 90,
                        width: 160,
                      ),
                      //
                      const SizedBox(height: 8),
                      Text(
                        code,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        name,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        genre,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        desc,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.decimalPattern(stock),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.currency(price),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.dataTime(expirationFrom),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.dataTime(expirationTo),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      AmountDropdownButton(
                        product: product,
                        value: quantity.value.toString(),
                        onChanged: (value) =>
                            {quantity.value = int.parse(value!)},
                      ),
                      const SizedBox(height: 8),
                      InCartElevatedButton(
                        product: product,
                        quantity: quantity.value,
                        programId: program.id!,
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
