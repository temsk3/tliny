import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/data/repository/auth_repository.dart';

import '../../../data/model/product_model.dart';
import '../../../data/model/program_model.dart';
import '../../../settings/hooks/use_l10n.dart';
import '../../../settings/routes/routes.dart';
import '../../../utils/logger.dart';
import '../../cart/cart_view_model.dart';
import '../../common/asyncvalue_widget.dart';
import '../../common/base_button_widget.dart';
import '../../common/custom_alert_dialog.dart';
import '../product_state.dart';
import '../product_view_model.dart';

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
          data:
              (visible) =>
                  visible
                      ? BaseFloatingActionButton(
                        heroTag: 'add_product_fab_${program.id}',
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

class GenreDropdownButton extends HookWidget {
  const GenreDropdownButton({
    super.key,
    required this.product,
    required this.value,
    this.focusNode,
    required this.onChanged,
    required this.onSaved,
  });
  final Product product;
  final GenreType? value;
  final FocusNode? focusNode;
  final void Function(GenreType?) onSaved;
  final void Function(GenreType?) onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    return Flexible(
      child: DropdownButtonFormField<GenreType>(
        alignment: Alignment.center,
        focusNode: focusNode,
        items:
            GenreType.values
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
        decoration: InputDecoration(labelText: l10n.genre),
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
      alignment: AlignmentDirectional.centerEnd,
      items:
          List.generate(
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
    required this.program,
  });
  final Product product;
  final int quantity;
  final Program program;
  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    // final appRoute = useRouter();
    final now = DateTime.now();
    final salesStart = program.salesStart!;
    final salesEnd = program.salesEnd!;
    final isOpened = salesStart.isBefore(now) && salesEnd.isAfter(now);
    final stateIndicate = isOpened && product.stock != 0;
    return Consumer(
      builder: (innerContext, ref, child) {
        final auth = ref.watch(authStateChangesProvider).value;
        return BaseElevatedButton(
          onPressed:
              stateIndicate && auth != null && product.id != null
                  ? () async {
                    try {
                      const result = true;
                      if (result) {
                        logger.d('inCart');
                        await ref
                            .watch(cartViewModelProvider.notifier)
                            .cart(quantity, product.id!, program.id!);
                        logger.d('showFluttertoast: start');
                        await showFluttertoast(
                          '${product.name!} ${l10n.addedToCart}',
                          webBgColor: 'amber',
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          textColor: Theme.of(context).colorScheme.onPrimary,
                        );
                        logger.d('showFluttertoast: end');
                        logger.d('pop');
                        // await appRoute.pop();
                        context.pop();
                      }
                    } on Exception catch (e, st) {
                      logger.e(
                        'Error',
                        time: DateTime.now(),
                        error: e,
                        stackTrace: st,
                      );
                      rethrow;
                    }
                  }
                  : null,
          child: FittedBox(fit: BoxFit.scaleDown, child: Text(l10n.addToCart)),
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
    // final appRoute = useRouter();
    return Consumer(
      child: Text(l10n.edit),
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(editProductButtonStateProvider(product)),
          data: (visible) {
            return Visibility(
              visible: visible,
              child: BaseElevatedButton(
                onPressed: () async {
                  // appRoute.push(
                  if (program.id != null && product.id != null) {
                    ProductEditRoute($extra: (program, product)).push(context);
                  }
                  // );
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
  const DeleteProductElevatedButton({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    // final appRoute = useRouter();
    return Consumer(
      child: Text(l10n.delete),
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(editProductButtonStateProvider(product)),
          data: (visible) {
            return Visibility(
              visible: visible,
              child: BaseElevatedButton(
                onPressed: () async {
                  final result = await showConfirmDialog(
                    context,
                    // appRoute,
                    title: l10n.delete,
                    contentWidget: Text(l10n.doYouWantToDeleteIt),
                    cancelText: l10n.no,
                    decisionText: l10n.yes,
                  );
                  if (result!) {
                    await showFluttertoast(l10n.processingData);
                    await ref
                        .watch(productViewModelProvider.notifier)
                        .deleteProduct(product.id.toString());
                    context.pop();
                  }
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
  const RegisterProductElevatedButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    return Consumer(
      child: Text(l10n.register),
      builder: (context, ref, child) {
        return BaseElevatedButton(
          onPressed: () async => onPressed(),
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
    // final appRoute = useRouter();
    final l10n = useL10n();
    return Consumer(
      child: Text(l10n.cancel),
      builder: (context, ref, child) {
        return BaseElevatedButton(
          onPressed: () async => context.pop(),
          child: child!,
        );
      },
    );
  }
}
