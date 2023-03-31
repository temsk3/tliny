import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../settings/hooks/use_router.dart';
import 'auth_view_model.dart';

final logger = Logger();

@RoutePage()
class SignUpPage extends HookConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    // final l10n = useL10n();
    final appRoute = useRouter();
    // final appMQ = useMediaQuery();

    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    return Scaffold(
      appBar: AppBar(title: const Text('新規登録')),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 32,
        ),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.mail),
                label: Text('メールアドレス'),
                hintText: 'test@gmail.com',
              ),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                label: Text('パスワード'),
                hintText: 'password',
              ),
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(
              height: 48,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(128, 32)),
              ),
              onPressed: () async {
                try {
                  if (emailController.text.isEmpty) {
                    throw 'メールアドレスを入力してください';
                  }
                  if (passwordController.text.isEmpty) {
                    throw 'パスワードを入力してください';
                  }
                  await ref.read(authViewModelProvider.notifier).signUp(
                        emailController.text,
                        passwordController.text,
                      );
                  // Navigator.of(context).pushAndRemoveUntil(
                  //   MaterialPageRoute(builder: (context) => const MyHomePage()),
                  //   (_) => false,
                  // );
                  appRoute.popUntilRoot();
                } catch (e) {
                  logger.e(e);
                }
              },
              child: const Text('新規登録'),
            ),
          ],
        ),
      ),
    );
  }
}
