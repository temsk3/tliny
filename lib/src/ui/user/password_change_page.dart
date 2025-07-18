import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../ui/common/error_handler.dart';
import '../../ui/common/main_body.dart';
import '../../utils/logger.dart';
import '../../utils/router_utils.dart';
import 'password_change_view_model.dart';

class PasswordChangePage extends HookConsumerWidget {
  const PasswordChangePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final state = ref.watch(passwordChangeViewModelProvider);
    final viewModel = ref.watch(passwordChangeViewModelProvider.notifier);

    final form = GlobalKey<FormState>();
    final currentPasswordController = useTextEditingController();
    final newPasswordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(l10n.changePassword),
        automaticallyImplyLeading: false,
      ),
      body: MainBodyWidget(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 説明文
                    Text(
                      l10n.changePasswordDescription,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // 現在のパスワード入力
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: currentPasswordController,
                      decoration: InputDecoration(
                        labelText: l10n.currentPassword,
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.passwordRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // 新しいパスワード入力
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: newPasswordController,
                      decoration: InputDecoration(
                        labelText: l10n.newPassword,
                        hintText: '6文字以上の英数字',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.pleaseEnterPassword;
                        }
                        if (value.length < 6) {
                          return l10n.passwordTooWeak;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // 新しいパスワード確認入力
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: l10n.confirmNewPassword,
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.pleaseEnterPassword;
                        }
                        if (value != newPasswordController.text) {
                          return l10n.passwordMismatch;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // 状態表示
                    state.when(
                      data: (_) => const SizedBox.shrink(),
                      loading:
                          () => Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(),
                                const SizedBox(width: 16),
                                Text(l10n.passwordChangeInProgress),
                              ],
                            ),
                          ),
                      error:
                          (error, stackTrace) => Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.errorContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              error.toString(),
                              style: TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onErrorContainer,
                              ),
                            ),
                          ),
                    ),

                    // ボタン
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => RouterUtils.safePop(context),
                          child: Text(l10n.cancel),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed:
                              state.isLoading
                                  ? null
                                  : () async {
                                    if (form.currentState!.validate()) {
                                      try {
                                        await viewModel.changePassword(
                                          currentPasswordController.text,
                                          newPasswordController.text,
                                        );

                                        // 成功時の処理
                                        if (context.mounted) {
                                          ErrorHandler.showSuccessSnackBar(
                                            context,
                                            l10n.passwordChangeSuccess,
                                          );
                                          RouterUtils.safePop(context);
                                        }
                                      } catch (e) {
                                        // エラーはAsyncValueWidgetで表示される
                                        logger.e('changePassword: error=$e');
                                      }
                                    }
                                  },
                          child: Text(l10n.update),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
