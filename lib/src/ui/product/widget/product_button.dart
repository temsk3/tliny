import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../data/model/product_model.dart';
import '../../../data/model/program_model.dart';
import '../../../settings/hooks/use_l10n.dart';
import '../../../settings/hooks/use_router.dart';
import '../../../settings/routes/app_route.gr.dart';
import '../../cart/cart_view_model.dart';
import '../../common/asyncvalue_widget.dart';
import '../../common/base_button_widget.dart';
import '../../common/custom_alert_dialog.dart';
import '../product_state.dart';
import '../product_view_model.dart';

final logger = Logger();

class AddProductFloatingActionButton extends StatelessWidget {
  const AddProductFloatingActionButton({
    super.key,
    required this.program,
    required this.onPressed,
  });
  final Program program;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      child: const Icon(Icons.add_sharp),
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(addProductButtonStateProvider(program)),
          data: (visible) => visible
              ? BaseFloatingActionButton(
                  onPressed: onPressed,
                  child: child!,
                )
              : Container(),
        );
      },
    );
  }
}

class DeleteProductIconButton extends StatelessWidget {
  const DeleteProductIconButton({
    super.key,
    required this.product,
    required this.onPressed,
    required this.icon,
    this.tooltip,
  });
  final Product product;
  final VoidCallback onPressed;
  final Icon icon;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(editProductButtonStateProvider(product)),
          data: (visible) {
            return Visibility(
              visible: visible,
              child: BaseIconButton(
                icon: icon,
                tooltip: tooltip,
                onPressed: onPressed,
              ),
            );
          },
        );
      },
    );
  }
}

class EditProductIconButton extends StatelessWidget {
  const EditProductIconButton({
    super.key,
    required this.product,
    required this.onPressed,
    required this.icon,
    this.tooltip,
  });
  final Product product;
  final VoidCallback onPressed;
  final Icon icon;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(editProductButtonStateProvider(product)),
          data: (visible) {
            return Visibility(
              visible: visible,
              child: BaseIconButton(
                icon: icon,
                tooltip: tooltip,
                onPressed: onPressed,
              ),
            );
          },
        );
      },
    );
  }
}

class GenreDropdownButton extends StatelessWidget {
  const GenreDropdownButton({
    super.key,
    required this.product,
    required this.value,
    required this.onChanged,
    required this.onSaved,
  });
  final Product product;
  final GenreType? value;
  final void Function(GenreType?) onSaved;
  final void Function(GenreType?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: DropdownButtonFormField<GenreType>(
        items: GenreType.values
            .map(
              (GenreType genre) => DropdownMenuItem<GenreType>(
                value: genre,
                child: Text(genre.name),
              ),
            )
            .toList(),
        value: value,
        validator: (value) {
          if (value == null) {
            return 'Please select';
          }
          return null;
        },
        decoration: const InputDecoration(labelText: 'genre'),
        onSaved: onSaved,
        onChanged: onChanged,
      ),
    );
  }
}

class AmountDropdownButton extends StatelessWidget {
  const AmountDropdownButton({
    super.key,
    required this.product,
    required this.value,
    required this.onChanged,
  });
  final Product product;
  final String value;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: List.generate(
        int.parse(product.stock.toString()),
        (index) => 1 + index,
      )
          .map(
            (quantity) => DropdownMenuItem<String>(
              value: quantity.toString(),
              child: Text(quantity.toString()),
            ),
          )
          .toList(),
      value: value,
      onChanged: onChanged,
    );
  }
}

class InCartElevatedButton extends HookWidget {
  const InCartElevatedButton({
    super.key,
    required this.product,
    required this.quantity,
    required this.programId,
  });
  final Product product;
  final int quantity;
  final String programId;
  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    final appRoute = useRouter();
    return Consumer(
      child: const Text('買物カゴに追加'),
      builder: (context, ref, child) {
        return BaseElevatedButton(
          onPressed: (product.stock != 0)
              ? () async {
                  final result = await showConfirmDialog(
                    context,
                    appRoute,
                    cancelText: l10n.no,
                    decisionText: l10n.yes,
                    contentWidget:
                        Text('${product.name!}\n ${l10n.quantity} : $quantity'),
                    title: 'Add to cart?',
                  );
                  if (result!) {
                    await Fluttertoast.showToast(
                      msg: 'Added to cart',
                      fontSize: 14,
                    );
                    logger.d('inCart');
                    await ref.watch(cartViewModelProvider.notifier).cart(
                          quantity,
                          product.id.toString(),
                          programId,
                        );
                    await appRoute.pop();
                  }
                }
              : null,
          child: child!,
        );
      },
    );
  }
}

class EditProductElevatedButton extends HookWidget {
  const EditProductElevatedButton({
    super.key,
    required this.program,
    required this.product,
  });
  final Program program;
  final Product product;
  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    final appRoute = useRouter();
    return Consumer(
      child: Text(l10n.edit),
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(editProductButtonStateProvider(product)),
          data: (visible) {
            return Visibility(
              visible: visible,
              child: BaseElevatedButton(
                onPressed: () {
                  appRoute.push(
                    ProductEditRoute(program: program, product: product),
                  );
                },
                child: child!,
              ),
            );
          },
        );
      },
    );
  }
}

class DeleteProductElevatedButton extends HookWidget {
  const DeleteProductElevatedButton({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    final appRoute = useRouter();
    return Consumer(
      child: Text(l10n.delete),
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(editProductButtonStateProvider(product)),
          data: (visible) {
            return Visibility(
              visible: visible,
              child: BaseElevatedButton(
                onPressed: () {
                  ref.watch(productViewModelProvider.notifier).deleteProduct(
                        product.id.toString(),
                      );
                  appRoute.pop();
                },
                child: child!,
              ),
            );
          },
        );
      },
    );
  }
}

class RegisterProductElevatedButton extends HookWidget {
  const RegisterProductElevatedButton({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    return Consumer(
      child: Text(l10n.register),
      builder: (context, ref, child) {
        return BaseElevatedButton(
          onPressed: onPressed,
          child: child!,
        );
      },
    );
  }
}

class CancelElevatedButton extends HookWidget {
  const CancelElevatedButton({super.key});
  @override
  Widget build(BuildContext context) {
    final appRoute = useRouter();
    final l10n = useL10n();
    return Consumer(
      child: Text(l10n.cancel),
      builder: (context, ref, child) {
        return BaseElevatedButton(
          onPressed: appRoute.pop,
          child: child!,
        );
      },
    );
  }
}
