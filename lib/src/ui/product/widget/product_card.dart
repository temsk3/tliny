import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/settings/routes/routes.dart';

import '../../../data/model/product_model.dart';
import '../../../data/model/program_model.dart';
import '../../../settings/hooks/use_l10n.dart';
import '../../../ui/common/error_handler.dart';
import '../../../utils/logger.dart';
import '../../image/image_screen.dart';

// final logger = Logger();

class ProductCard extends HookConsumerWidget {
  const ProductCard({
    super.key,
    // required this.index,
    required this.product,
    required this.program,
  });
  // final int index;
  final Product product;
  final Program program;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    // final appRoute = useRouter();
    // final today = DateTime.now();
    // final now = DateTime(today.year, today.month, today.day, 0, 0, 0);
    // logger.d(now);
    // final NumberFormat formatter = NumberFormat.simpleCurrency(
    //     locale: Localizations.localeOf(context).toString());

    final now = DateTime.now();
    final salesStart = program.salesStart!;
    final salesEnd = program.salesEnd!;
    final isOpened = salesStart.isBefore(now) && salesEnd.isAfter(now);
    final stateIndicate = isOpened && product.stock != 0;

    // logger.d(program);
    // logger.d(product);

    return Stack(
      children: [
        InkWell(
          onTap: () async {
            try {
              if (program.id != null && product.id != null) {
                // await appRoute.push(
                ProductDetailsRoute(
                  programId: program.id!,
                  productId: product.id!,
                ).push(context);
                // );
              }
            } catch (e) {
              logger.e('Failed to navigate to product details: $e');
              if (context.mounted) {
                ErrorHandler.showErrorSnackBar(context, e, l10n);
              }
            }
          },
          child: Card(
            color: stateIndicate ? null : Colors.black.withValues(alpha: 0.3),
            // : theme.appColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: const EdgeInsets.all(10),
            elevation: 10,
            child: Column(
              //
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                  child: PictureView(
                    picture: product.pictureURL,
                    index: 0,
                    height: 90,
                    width: 160,
                    tap: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product.name.toString(),
                        // style: theme.textTheme.h40.bold(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        l10n.currency(product.price),
                        // style: theme.textTheme.h40,
                        // .copyWith(color: theme.appColors.onBackground),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // RawMaterialButton(
        //   onPressed: () async {
        //     await appRoute.push(
        //       ProductDetailsRoute(product: product, program: program),
        //     );
        //   },
        //   // shape: const CircleBorder(),
        //   elevation: 0,
        //   child: const SizedBox(
        //     width: 240,
        //     height: 240,
        //   ),
        // ),
        (product.stock == 0)
            ? const Positioned(
              top: 4,
              child: Text(
                'SOLD OUT',
                // style: theme.textTheme.h60.bold(),
                // .copyWith(color: theme.appColors.onPrimary),
              ),
            )
            : isOpened
            ? const Positioned(child: Text(''))
            : Positioned(
              top: 4,
              child: Text(
                l10n.outOfTerm,
                //  style: theme.textTheme.h60.bold(),
                // .copyWith(color: theme.appColors.onPrimary),
              ),
            ),
      ],
    );
  }
}
