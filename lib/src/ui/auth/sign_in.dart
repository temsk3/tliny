import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../gen/assets.gen.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_snackbar.dart';
import '../../settings/routes/routes.dart';
import '../../utils/logger.dart';
import '../common/form_validator.dart';
import 'auth_view_model.dart';

/// サインイン画面
class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // スプラッシュスクリーン表示終了
    FlutterNativeSplash.remove();

    final l10n = useL10n();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isVisible = useState(false);
    final snackBarController = useSnackBar();
    final formKey = GlobalKey<FormState>();
    // バリデーション関数を変数として定義
    String? validateEmail(String? value) =>
        FormValidator.validateEmail(value, l10n);
    String? validatePassword(String? value) =>
        FormValidator.validatePassword(value, l10n);

    final viewModel = ref.read(authViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.signIn)),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 400, // 幅を制限
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 32,
                ),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      Assets.img.icon.image(height: 200, width: 200),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail),
                          label: Text(l10n.mail),
                          hintText: 'test@gmail.com',
                        ),
                        validator: validateEmail,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !isVisible.value,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () => isVisible.value = !isVisible.value,
                          ),
                          label: Text(l10n.password),
                          hintText: 'password',
                        ),
                        validator: validatePassword,
                      ),
                      const SizedBox(height: 48),
                      ElevatedButton(
                        onPressed: () async {
                          // Formのバリデーションを実行
                          final state = formKey.currentState;
                          if (state == null || !state.validate()) {
                            return;
                          }
                          try {
                            await viewModel.signIn(
                              emailController.text,
                              passwordController.text,
                            );
                            context.go(AppRoutes.topPage);
                          } catch (e) {
                            snackBarController.showAlertSnackBar(e.toString());
                            logger.e('signInButton: error=$e');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(128, 32),
                        ),
                        child: Text(l10n.signIn),
                      ),
                      const SizedBox(height: 8), // 余白調整
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // 中央寄せ
                        children: [
                          Text(l10n.signUpNow),
                          TextButton(
                            onPressed: () => context.push(AppRoutes.signUpPage),
                            child: Text(l10n.signUp),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8), // 余白調整
                      TextButton(
                        onPressed: () async {
                          try {
                            await viewModel.sendPasswordResetEmail(
                              emailController.text,
                            );
                            snackBarController.showSuccessSnackBar(
                              'パスワードリセット用のメールを送信しました',
                            );
                          } catch (e) {
                            snackBarController.showAlertSnackBar(e.toString());
                            logger.e('resetPasswordButton: error=$e');
                          }
                        },
                        child: const Text('パスワードをお忘れの場合'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
