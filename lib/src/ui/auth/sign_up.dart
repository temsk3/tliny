import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../settings/hooks/use_dialog.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/routes/routes.dart';
import '../../utils/logger.dart';
import '../common/form_validator.dart';
import '../common/main_body.dart';
import 'auth_view_model.dart';

/// サインアップ画面
class SignUpPage extends HookConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // スプラッシュスクリーン表示終了
    FlutterNativeSplash.remove();

    final l10n = useL10n();
    final dialogController = useDialog(); // snackbar controller を初期化
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new);

    // バリデーション関数を変数として定義
    String? validateEmail(String? value) => FormValidator.validateEmail(value);
    String? validatePassword(String? value) =>
        FormValidator.validatePassword(value);

    final viewModel = ref.read(authViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.signUp)),
      body: MainBodyWidget(
        width: 400,
        body: Form(
          // Formウィジェットを追加
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.mail),
                    label: Text(l10n.mailAddress),
                    hintText: 'test@gmail.com',
                  ),
                  validator: validateEmail, // バリデーターを設定
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    label: Text(l10n.password),
                    hintText: 'password',
                  ),
                  validator: validatePassword, // バリデーターを設定
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    try {
                      await viewModel.signUp(
                        emailController.text,
                        passwordController.text,
                      );
                      context.go(AppRoutes.topPage);
                    } catch (e) {
                      logger.e('signUpButton: error=$e');
                      dialogController.showErrorDialog(
                        'サインアップエラー',
                        e.toString(),
                      ); // snackbar を使ってエラーを表示
                    }
                  },
                  child: Text(l10n.signUp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
