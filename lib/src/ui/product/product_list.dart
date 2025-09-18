import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/product_model.dart';
import '../../data/model/program_model.dart';
import '../../ui/common/asyncvalue_widget.dart';
import 'product_state.dart';
import 'widget/product_card.dart';

class ProductListPage extends HookConsumerWidget {
  const ProductListPage({super.key, required this.program, this.genre});
  final Program program;
  final GenreType? genre;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    // // final l10n = useL10n();
    // final appRoute = useRouter();
    // final state = ref.watch(
    //   productListStateProvider(ProductQueryParameter(program.id, genre)),
    // );
    final state = ref.watch(productsStateProvider(program.id!, genre));
    // final state = ref.watch(productViewModelProvider);
    return AsyncValueWidget(
      value: state,
      data: (list) {
        // 高価な操作をメモ化して最適化
        final sortedProducts = useMemoized(() {
          final filtered =
              list.where((element) => element.isActive == true).toList();
          filtered.sort((a, b) => a.name!.compareTo(b.name!));
          return filtered;
        }, [list]);
        final data = sortedProducts;
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.8,
          ),
          padding: const EdgeInsets.all(16),
          itemCount: data.length,
          itemBuilder: (_, index) {
            final product = data[index];
            return ProductCard(
              // index: index,
              product: product,
              program: program,
            );
          },
        );
        // return SliverGrid.builder(
        //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        //     maxCrossAxisExtent: 200,
        //     childAspectRatio: 0.8,
        //   ),
        //   itemCount: data.length,
        //   itemBuilder: (_, index) {
        //     final product = data[index];
        //     logger.d(product);
        //     return ProductCard(
        //       // index: index,
        //       product: product,
        //       program: program,
        //     );
        //   },
        // );
      },
    );
  }
}
