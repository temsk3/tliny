import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../data/model/product_model.dart';
import '../../../data/model/program_model.dart';
import '../../../settings/hooks/use_l10n.dart';
import '../../../settings/hooks/use_router.dart';
import '../../../settings/routes/app_route.gr.dart';
import '../../../settings/theme/app_text_theme.dart';
import '../../../settings/theme/app_theme.dart';
import '../../image/image_screen.dart';

final logger = Logger();

class ProductCard extends HookConsumerWidget {
  const ProductCard({
    super.key,
    // required this.index,
    required this.product,
    this.program,
  });
  // final int index;
  final Product product;
  final Program? program;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    // final today = DateTime.now();
    // final now = DateTime(today.year, today.month, today.day, 0, 0, 0);
    final now = DateTime.now();
    // logger.d(now);
    // final NumberFormat formatter = NumberFormat.simpleCurrency(
    //     locale: Localizations.localeOf(context).toString());

    final salesStart = product.salesStart!;
    final start = DateTime(salesStart.year, salesStart.month, salesStart.day);
    final salesEnd = product.salesEnd!;
    final end = DateTime(salesEnd.year, salesEnd.month, salesEnd.day);
    final isOpened = now.compareTo(start) >= 0 && now.compareTo(end) <= 0;

    // logger.d(program);
    // logger.d(product);

    return Stack(
      children: [
        Card(
          color: (product.stock == 0 || isOpened)
              ? null
              : Colors.black.withOpacity(0.3),
          // : theme.appColors.background,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsets.all(10),
          elevation: 10,
          child: Column(
            //
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 12,
                // child: PictureCover(picture: product.pictureURL![0])
                child: PictureDetailView(
                  picture: product.pictureURL,
                  height: 90,
                  width: 160,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        // child: FittedBox(
                        //   fit: BoxFit.fitWidth,
                        child: Text(
                          product.name.toString(),
                          style: theme.textTheme.h40.bold(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // ),
                      ),
                      // const SizedBox(height: 8.0),
                      Expanded(
                        child: Text(
                          l10n.currency(product.price),
                          style: theme.textTheme.h40,
                          // .copyWith(color: theme.appColors.onBackground),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        RawMaterialButton(
          onPressed:
              // product.stock == 0
              //     ? null
              //     :
              () async {
            if (program != null) {
              await appRoute.push(
                ProductDetailsRoute(product: product, program: program!),
              );
            }

            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return const AlertDialog(
            //       title: Text('購入処理'),
            //     );
            //   },
            // );
          },
          // shape: const CircleBorder(),
          elevation: 0,
          child: const SizedBox(
            width: 240,
            height: 240,
          ),
        ),
        (product.stock == 0)
            ? Positioned(
                top: 4,
                child: Text(
                  'SOLD OUT', style: theme.textTheme.h60.bold(),
                  // .copyWith(color: theme.appColors.onPrimary),
                ),
              )
            : isOpened
                ? const Positioned(child: Text(''))
                : Positioned(
                    top: 4,
                    child: Text(
                      'Out of term', style: theme.textTheme.h60.bold(),
                      // .copyWith(color: theme.appColors.onPrimary),
                    ),
                  ),
      ],
    );
  }
}
