import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/data/repository/auth_repository.dart';
import 'package:tliny/src/data/repository/user_repository.dart';

import '../../../data/model/product_model.dart';
import '../../../data/model/program_model.dart';
import '../../../settings/hooks/use_l10n.dart';
import '../../../settings/routes/routes.dart';
import '../../../utils/logger.dart';
import '../../../utils/router_utils.dart';
import '../../cart/cart_view_model.dart';
import '../../common/asyncvalue_widget.dart';
import '../../common/base_button_widget.dart';
import '../../common/custom_alert_dialog.dart';
import '../../common/error_handler.dart';
import '../product_state.dart';
import '../product_view_model.dart';

class AddProductFloatingActionButton extends HookWidget {
  const AddProductFloatingActionButton({
    super.key,
    required this.program,
    required this.onPressed,
    this.child,
  });
  final Program program;
  final VoidCallback onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    return Consumer(
      builder: (context, ref, _) {
        return AsyncValueButtonWidget(
          value: ref.watch(addProductButtonStateProvider(program)),
          data:
              (visible) =>
                  visible
                      ? BaseFloatingActionButton(
                        heroTag: 'add_product_fab_${program.id}',
                        onPressed: onPressed,
                        l10n: l10n,
                        child: child ?? const Icon(Icons.add),
                      )
                      : Container(),
        );
      },
    );
  }
}

class DeleteProductIconButton extends HookWidget {
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
    final l10n = useL10n();
    return Consumer(
      builder: (context, ref, _) {
        return AsyncValueButtonWidget(
          value: ref.watch(editProductButtonStateProvider(product)),
          data: (visible) {
            return Visibility(
              visible: visible,
              child: BaseIconButton(
                icon: icon,
                tooltip: tooltip,
                onPressed: onPressed,
                l10n: l10n,
              ),
            );
          },
        );
      },
    );
  }
}

class EditProductIconButton extends HookWidget {
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
    final l10n = useL10n();
    return Consumer(
      builder: (context, ref, _) {
        return AsyncValueButtonWidget(
          value: ref.watch(editProductButtonStateProvider(product)),
          data: (visible) {
            return Visibility(
              visible: visible,
              child: BaseIconButton(
                icon: icon,
                tooltip: tooltip,
                onPressed: onPressed,
                l10n: l10n,
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
    final errorHandler = useErrorHandler();
    // final appRoute = useRouter();
    final now = DateTime.now();
    final salesStart = program.salesStart!;
    final salesEnd = program.salesEnd!;
    final isOpened = salesStart.isBefore(now) && salesEnd.isAfter(now);
    final stateIndicate = isOpened && product.stock != 0;
    return Consumer(
      builder: (innerContext, ref, child) {
        final authState = ref.watch(authStateChangesProvider);
        final auth = authState.value;
        logger.d(
          'InCartElevatedButton: authState=$authState, authState.hasValue=${authState.hasValue}, authState.isLoading=${authState.isLoading}, authState.hasError=${authState.hasError}, auth=$auth, product.stock=${product.stock}',
          time: DateTime.now(),
        );
        logger.d(
          'InCartElevatedButton: stateIndicate=$stateIndicate, auth=$auth, product.id=${product.id}',
          time: DateTime.now(),
        );
        // AsyncValueの状態を考慮して認証状態を判定
        final isAuthenticated = authState.hasValue && auth == true;
        final isZeroOrFree = product.price == 0;
        return FutureBuilder<bool>(
          future: ref
              .read(userRepositoryProvider)
              .checkExistenceAccount(program.organizerId!),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return BaseElevatedButton(
                l10n: l10n,
                onPressed: null,
                child: const CircularProgressIndicator(strokeWidth: 2),
              );
            }
            final isOrganizerStripeRegistered = snapshot.data == true;
            // ボタン有効条件
            final isButtonEnabled =
                stateIndicate &&
                isAuthenticated &&
                product.id != null &&
                ((isOrganizerStripeRegistered &&
                        (product.price == 0 || product.price >= 50)) ||
                    (!isOrganizerStripeRegistered && product.price == 0));
            // Stripe未登録かつ0円以外は無効
            if (!isOrganizerStripeRegistered && product.price != 0) {
              return Column(
                children: [
                  BaseElevatedButton(
                    l10n: l10n,
                    onPressed: null,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        product.stock > 0
                            ? (isAuthenticated
                                ? l10n.addToCart
                                : l10n.pleaseLogin)
                            : l10n.outOfStock,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '主催者が販売者登録未登録のため0円商品しか購入できません',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              );
            }
            return BaseElevatedButton(
              l10n: l10n,
              onPressed:
                  isButtonEnabled
                      ? () async {
                        try {
                          const result = true;
                          if (result) {
                            logger.d('inCart');
                            await ref
                                .watch(cartViewModelProvider.notifier)
                                .cart(quantity, product.id!, program.id!);
                            logger.d('showFluttertoast: start');
                            errorHandler.showSuccessSnackBar(
                              '${product.name!} ${l10n.addedToCart}',
                            );
                            logger.d('showFluttertoast: end');
                            logger.d('pop');
                            RouterUtils.safePop(context);
                          }
                        } on Exception catch (e, st) {
                          logger.e(
                            'Error',
                            time: DateTime.now(),
                            error: e,
                            stackTrace: st,
                          );
                          errorHandler.showError(e, errorContext: 'カート追加');
                        }
                      }
                      : null,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  product.stock > 0
                      ? (isAuthenticated ? l10n.addToCart : l10n.pleaseLogin)
                      : l10n.outOfStock,
                ),
              ),
            );
          },
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
                l10n: l10n,
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
    final errorHandler = useErrorHandler();
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
                l10n: l10n,
                onPressed: () async {
                  try {
                    final result = await showConfirmDialog(
                      context,
                      // appRoute,
                      title: l10n.delete,
                      contentWidget: Text(l10n.doYouWantToDeleteIt),
                      cancelText: l10n.no,
                      decisionText: l10n.yes,
                    );
                    if (result!) {
                      errorHandler.showInfoSnackBar(l10n.processingData);
                      await ref
                          .watch(productViewModelProvider.notifier)
                          .deleteProduct(product.id.toString());
                      context.pop();
                    }
                  } catch (e) {
                    errorHandler.showError(e, errorContext: '商品削除');
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
    final errorHandler = useErrorHandler();
    return Consumer(
      child: Text(l10n.register),
      builder: (context, ref, child) {
        return BaseElevatedButton(
          l10n: l10n,
          onPressed: () async {
            try {
              onPressed();
            } catch (e) {
              errorHandler.showError(e, errorContext: '商品登録');
            }
          },
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
    final errorHandler = useErrorHandler();
    return Consumer(
      child: Text(l10n.cancel),
      builder: (context, ref, child) {
        return BaseElevatedButton(
          l10n: l10n,
          onPressed: () async {
            try {
              RouterUtils.safePop(context);
            } catch (e) {
              errorHandler.showError(e, errorContext: '画面遷移');
            }
          },
          child: child!,
        );
      },
    );
  }
}
