import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_router.dart';
import '../../settings/routes/app_route.gr.dart';
import 'auth_view_model.dart';

final logger = Logger();

@RoutePage()
class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key, required this.onSigninCallback});
  final Function(bool signIn) onSigninCallback;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    // final appMQ = useMediaQuery();

    // final emailController = useTextEditingController(text: '');
    // final passwordController = useTextEditingController(text: '');
    final emailController = useTextEditingController(text: 'temsk3@gmail.com');
    final passwordController = useTextEditingController(text: '521104');

    return Scaffold(
      appBar: AppBar(title: const Text('ログイン')),
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
                  await ref.read(authViewModelProvider.notifier).signIn(
                        emailController.text,
                        passwordController.text,
                      );
                  // Navigator.of(context).pushAndRemoveUntil(
                  //   MaterialPageRoute(builder: (context) => const MyHomePage()),
                  //   (_) => false,
                  // );
                  // appRoute.pop(const StripeRoute());
                  onSigninCallback(true);
                } catch (e) {
                  logger.e('サインインでエラー', e);
                }
              },
              child: Text(l10n.login),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
            ),
            ElevatedButton(
              style: ButtonStyle(
                // backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(128, 32)),
              ),
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => const SignUpPage(),
                //     fullscreenDialog: true,
                //   ),
                // );
                appRoute.push(const SignUpRoute());
              },
              child: Text(l10n.register),
            ),
          ],
        ),
      ),
    );
  }
}
