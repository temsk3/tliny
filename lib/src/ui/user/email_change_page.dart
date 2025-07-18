import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../ui/common/main_body.dart';
import '../../utils/logger.dart';
import '../../utils/router_utils.dart';
import '../../utils/validation_utils.dart';
import 'email_change_view_model.dart';

class EmailChangePage extends HookConsumerWidget {
  const EmailChangePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final state = ref.watch(emailChangeViewModelProvider);
    final viewModel = ref.watch(emailChangeViewModelProvider.notifier);

    final form = GlobalKey<FormState>();
    final newEmailController = useTextEditingController();
    final passwordController = useTextEditingController();

    // 現在のメールアドレスを取得
    final currentEmail = viewModel.getCurrentEmail();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(l10n.changeEmail),
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
                      l10n.changeEmailDescription,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // 現在のメールアドレス表示
                    if (currentEmail != null) ...[
                      Text(
                        l10n.currentEmail,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          currentEmail,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // 新しいメールアドレス入力
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: newEmailController,
                      decoration: InputDecoration(
                        labelText: l10n.newEmail,
                        hintText: 'example@email.com',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.pleaseEnterEmail;
                        }
                        final emailError = ValidationUtils.validateEmail(
                          value,
                          l10n,
                        );
                        if (emailError.isNotEmpty) {
                          return emailError;
                        }
                        if (value == currentEmail) {
                          return '現在のメールアドレスと同じです';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // パスワード確認入力
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: l10n.confirmPassword,
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.passwordRequired;
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
                                Text(l10n.emailChangeInProgress),
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
                                        await viewModel.changeEmail(
                                          newEmailController.text.trim(),
                                          passwordController.text,
                                        );

                                        // 成功時の処理
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                l10n.emailChangeSuccess,
                                              ),
                                              backgroundColor:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                            ),
                                          );
                                          RouterUtils.safePop(context);
                                        }
                                      } catch (e) {
                                        // エラーはAsyncValueWidgetで表示される
                                        logger.e('changeEmail: error=$e');
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
