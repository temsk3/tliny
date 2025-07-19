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
        final auth = ref.watch(authStateChangesProvider).value;
        final isAuthenticated = auth ?? false;
        final isButtonEnabled =
            stateIndicate && isAuthenticated && product.id != null;

        return BaseElevatedButton(
          l10n: l10n,
          onPressed:
              isButtonEnabled
                  ? () async {
                    try {
                      logger.d(
                        'AddToCartElevatedButton: 認証チェック開始',
                        time: DateTime.now(),
                      );

                      // 認証状態を再確認
                      final currentAuth =
                          ref.read(authStateChangesProvider).value;
                      final currentUid = ref.read(userIdProvider).value;

                      logger.d(
                        'AddToCartElevatedButton: currentAuth=$currentAuth',
                        time: DateTime.now(),
                      );
                      logger.d(
                        'AddToCartElevatedButton: currentUid=$currentUid',
                        time: DateTime.now(),
                      );

                      if (currentAuth != true || currentUid == null) {
                        logger.w(
                          'AddToCartElevatedButton: 認証されていないため、カートに追加できません',
                          time: DateTime.now(),
                        );
                        // エラーハンドラーではなく、直接SnackBarを表示
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Row(
                                children: [
                                  Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(child: Text('ログインが必要です')),
                                ],
                              ),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              action: SnackBarAction(
                                label: '閉じる',
                                textColor: Colors.white,
                                onPressed: () {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).hideCurrentSnackBar();
                                },
                              ),
                            ),
                          );
                        }
                        return;
                      }

                      // 追加の認証確認：Firebase Authの現在のユーザーを直接確認
                      final firebaseUser =
                          ref.read(authRepositoryProvider).getCurrentUser();
                      if (firebaseUser == null) {
                        logger.w(
                          'AddToCartElevatedButton: Firebase Authでユーザーが見つかりません',
                          time: DateTime.now(),
                        );
                        // エラーハンドラーではなく、直接SnackBarを表示
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Row(
                                children: [
                                  Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(child: Text('ログインが必要です')),
                                ],
                              ),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              action: SnackBarAction(
                                label: '閉じる',
                                textColor: Colors.white,
                                onPressed: () {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).hideCurrentSnackBar();
                                },
                              ),
                            ),
                          );
                        }
                        return;
                      }

                      logger.d(
                        'AddToCartElevatedButton: 認証OK - uid: $currentUid, firebaseUid: ${firebaseUser.uid}',
                        time: DateTime.now(),
                      );

                      await ref
                          .watch(cartViewModelProvider.notifier)
                          .cart(quantity, product.id!, program.id!);
                      logger.d('showFluttertoast: start');

                      // 成功メッセージを直接SnackBarで表示
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '${product.name!} ${l10n.addedToCart}',
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 3),
                            action: SnackBarAction(
                              label: '閉じる',
                              textColor: Colors.white,
                              onPressed: () {
                                ScaffoldMessenger.of(
                                  context,
                                ).hideCurrentSnackBar();
                              },
                            ),
                          ),
                        );
                      }

                      logger.d('showFluttertoast: end');
                      logger.d('pop');
                      // await appRoute.pop();
                      RouterUtils.safePop(context);
                    } on Exception catch (e, st) {
                      logger.e(
                        'AddToCartElevatedButton: カート追加エラー',
                        time: DateTime.now(),
                        error: e,
                        stackTrace: st,
                      );

                      // エラーの種類に応じて適切なメッセージを表示
                      String errorMessage;
                      Color backgroundColor;
                      IconData icon;

                      if (e.toString().contains('AuthenticationException') ||
                          e.toString().contains('ログインが必要です')) {
                        errorMessage = 'ログインが必要です';
                        backgroundColor = Colors.red;
                        icon = Icons.lock;
                      } else if (e.toString().contains('insufficient stock') ||
                          e.toString().contains('在庫不足')) {
                        errorMessage = '在庫が不足しています';
                        backgroundColor = Colors.orange;
                        icon = Icons.warning;
                      } else if (e.toString().contains('network') ||
                          e.toString().contains('connection')) {
                        errorMessage = 'ネットワークエラーが発生しました';
                        backgroundColor = Colors.orange;
                        icon = Icons.wifi_off;
                      } else {
                        errorMessage = 'カートへの追加に失敗しました';
                        backgroundColor = Colors.red;
                        icon = Icons.error;
                      }

                      // 直接SnackBarを表示
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(icon, color: Colors.white, size: 20),
                                const SizedBox(width: 8),
                                Expanded(child: Text(errorMessage)),
                              ],
                            ),
                            backgroundColor: backgroundColor,
                            behavior: SnackBarBehavior.floating,
                            action: SnackBarAction(
                              label: '閉じる',
                              textColor: Colors.white,
                              onPressed: () {
                                ScaffoldMessenger.of(
                                  context,
                                ).hideCurrentSnackBar();
                              },
                            ),
                          ),
                        );
                      }
                    }
                  }
                  : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isButtonEnabled ? null : Colors.grey,
            foregroundColor: isButtonEnabled ? null : Colors.white,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(isAuthenticated ? l10n.addToCart : 'ログインしてください'),
          ),
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
