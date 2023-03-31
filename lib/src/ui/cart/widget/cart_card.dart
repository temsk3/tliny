import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../../data/model/cart_model.dart';
import '../../../data/repository/product_repository.dart';
import '../../../settings/hooks/use_l10n.dart';
import '../../../settings/hooks/use_media_query.dart';
import '../../../settings/hooks/use_router.dart';
import '../../../settings/theme/app_theme.dart';
import '../../../ui/common/asyncvalue_widget.dart';
import '../../image/image_screen.dart';
import '../cart_view_model.dart';
import 'cart_button.dart';

final logger = Logger();

class CartCard extends HookConsumerWidget {
  const CartCard({super.key, required this.cart});
  final Cart cart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final appMediaQuery = useMediaQuery();

    final now = DateTime.now();
    final formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString(),
    );

    // final state = ref.watch(cartViewModelProvider);
    final state = ref.watch(productDocStreamProvider(cart.productDocRef!));
    final viewModel = ref.watch(cartViewModelProvider.notifier);

    return AsyncValueButtonWidget(
      value: state,
      data: (product) {
        // logger.d(product);
        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: PictureDetailView(
                  picture: product.pictureURL,
                ),
                //  (product.pictureURL.isEmpty)
                //     ? Image.asset(
                //         'assets/img/cat.jpg',
                //         fit: BoxFit.fitHeight,
                //       )
                //     : CachedNetworkImage(
                //         imageUrl: product.pictureURL[0],
                //         placeholder: (context, url) =>
                //             const CircularProgressIndicator(),
                //         errorWidget: (context, url, error) =>
                //             const Icon(Icons.error),
                //       ),
                title: Text(product.name.toString()),
                subtitle: Text(product.desc.toString()),
                trailing: Text('${l10n.quantity} : ${cart.quantity}'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: ToProductDetailsTextButton(product: product),
                  ),
                  // const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: DeleteCartTextButton(cartId: cart.id.toString()),
                  ),
                  // const SizedBox(width: 8),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
