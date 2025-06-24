import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/ui/checkout/checkout_view_model.dart';

import '../../../data/model/cart_model.dart';
import '../../../data/model/product_model.dart';
import '../../../data/model/program_model.dart';
import '../../../settings/hooks/use_l10n.dart';
import '../../../settings/routes/routes.dart';
import '../../../ui/cart/cart_view_model.dart';
import '../../../ui/common/asyncvalue_widget.dart';
import '../../../ui/program/program_state.dart';
import '../../../utils/logger.dart';
import '../../common/base_button_widget.dart';
import '../../common/loading_screen.dart';
import '../cart_state.dart';

/// 商品詳細画面への遷移ボタン
class ToProductDetailsTextButton extends HookWidget {
  const ToProductDetailsTextButton({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    // final appRoute = useRouter();

    return Consumer(
      child: Text(l10n.productDetails),
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(programListStateProvider),
          data: (list) {
            logger.d('ToProductDetailsTextButton: list=$list',
                time: DateTime.now());
            try {
              final program =
                  list.firstWhere((program) => program.id == product.eventId);
              return TextButton(
                child: child!,
                onPressed: () {
                  logger.d(
                      'ToProductDetailsTextButton: onPressed, program=$program',
                      time: DateTime.now());
                  // appRoute.push(
                  //   ProductDetailsRoute(
                  //     program: program,
                  //     product: product,
                  //   ),
                  // );
                  ProductDetailsRoute($extra: (program, product)).go(context);
                },
              );
            } on Exception catch (e, st) {
              logger.e('ToProductDetailsTextButton: error=$e, stackTrace=$st',
                  time: DateTime.now());
              return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }
}

/// カートアイテム削除ボタン
class DeleteCartTextButton extends HookWidget {
  const DeleteCartTextButton({
    super.key,
    required this.cartId,
  });
  final String cartId;

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();

    return Consumer(
      child: Text(l10n.delete),
      builder: (context, ref, child) {
        final viewModel = ref.watch(cartViewModelProvider.notifier);
        return TextButton(
          child: child!,
          onPressed: () {
            logger.d('DeleteCartTextButton: onPressed, cartId=$cartId',
                time: DateTime.now());
            viewModel.deleteCart(cartId);
          },
        );
      },
    );
  }
}

/// 数量増減ボタン
class PlusMinusButtons extends StatelessWidget {
  const PlusMinusButtons({
    super.key,
    required this.product,
    required this.addQuantity,
    required this.deleteQuantity,
    required this.text,
  });
  final Product product;
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: deleteQuantity, icon: const Icon(Icons.remove)),
        Text(text),
        IconButton(onPressed: addQuantity, icon: const Icon(Icons.add)),
      ],
    );
  }
}

/// 全商品購入ボタン
class AllPaymentButton extends HookWidget {
  const AllPaymentButton({super.key, required this.list});
  final List<Cart> list;
  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(totalAmountStateProvider(list)),
          data: (value) {
            return ElevatedButton(
              onPressed: () {},
              child: Text(l10n.currency(value)),
            );
          },
        );
      },
    );
  }
}

/// イベントごとの購入ボタン
class PaymentButton extends HookWidget {
  const PaymentButton(
    // this.appRoute,
    this.ctx, {
    super.key,
    required this.list,
    required this.event,
    // required this.eventId,
  });
  // final StackRouter appRoute;
  final BuildContext ctx;
  final List<Cart> list;
  final Program event;
  // final String eventId;
  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    final eventId = event.id;
    final newList = list.where((e) => e.programId == eventId).toList();
    var sales = true;
    if (event.salesStart == null ||
        event.salesStart!.isAfter(DateTime.now()) ||
        event.salesEnd == null ||
        event.salesEnd!.isBefore(DateTime.now())) {
      sales = false;
    } else {
      sales = true;
    }
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(totalAmountStateProvider(newList)),
          data: (value) {
            return BaseElevatedButton(
              onPressed: sales
                  ? () async {
                      logger.d(
                          'PaymentButton: onPressed, eventId=$eventId, value=$value',
                          time: DateTime.now());
                      final result = await ref
                          .read(isLoadingProvider.notifier)
                          .guardFuture<bool>(
                            () async => ref
                                .watch(stripeCheckoutViewModelProvider.notifier)
                                .getCheckoutPaymentLink(
                                  // appRoute,
                                  ctx,
                                  eventId!,
                                ),
                          );
                      if (context.mounted && result) {
                        logger.d('PaymentButton: result=$result',
                            time: DateTime.now());
                        // await appRoute.pop();
                        ctx.pop();
                      }
                    }
                  : null,
              child: Text('${l10n.buy} : ${l10n.currency(value)}'),
            );
          },
        );
      },
    );
  }
}
