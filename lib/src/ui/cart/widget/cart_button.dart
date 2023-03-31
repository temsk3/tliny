import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/ui/checkout/checkout_view_model.dart';

import '../../../data/model/cart_model.dart';
import '../../../data/model/product_model.dart';
import '../../../settings/hooks/use_l10n.dart';
import '../../../settings/hooks/use_router.dart';
import '../../../settings/routes/app_route.gr.dart';
import '../../../ui/cart/cart_view_model.dart';
import '../../../ui/common/asyncvalue_widget.dart';
import '../../../ui/program/program_state.dart';
import '../cart_state.dart';

class ToProductDetailsTextButton extends HookWidget {
  const ToProductDetailsTextButton({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    final appRoute = useRouter();

    return Consumer(
      child: Text(l10n.productDetails),
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(programListStateProvider),
          data: (list) {
            final program =
                list.firstWhere((program) => program.id == product.eventId);
            return TextButton(
              child: child!,
              onPressed: () {
                appRoute.push(
                  ProductDetailsRoute(
                    program: program,
                    product: product,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

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
            viewModel.deleteCart(cartId);
          },
        );
      },
    );
  }
}

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

class PaymentButton extends HookWidget {
  const PaymentButton(
    this.appRoute,
    this.ctx, {
    super.key,
    required this.list,
    required this.eventId,
  });
  final StackRouter appRoute;
  final BuildContext ctx;
  final List<Cart> list;
  final String eventId;
  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    final newList = list.where((e) => e.programId == eventId).toList();
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(totalAmountStateProvider(newList)),
          data: (value) {
            return ElevatedButton(
              onPressed: () async {
                final result = await ref
                    .watch(stripeCheckoutViewModelProvider)
                    .getCheckoutPaymentLink(appRoute, ctx, eventId);
                // await ref
                //     .watch(stripeCheckoutViewModelProvider)
                //     .paymentWithBrowser(
                //       appRoute,
                //       ctx,
                //       result[0],
                //       result[1],
                //     );
              },
              child: Text('購入 : ${l10n.currency(value)}'),
            );
          },
        );
      },
    );
  }
}
