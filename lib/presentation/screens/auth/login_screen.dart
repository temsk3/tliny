import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/base_widgets.dart';

/// ログイン画面
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// ログイン処理
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: 認証処理の実装
      await Future.delayed(const Duration(seconds: 2)); // 仮の遅延
      
      if (mounted) {
        context.go(AppConstants.homeRoute);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ログインに失敗しました: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// パスワード表示切り替え
  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.largePadding),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ロゴ
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.shopping_bag,
                      size: 40,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.largePadding),
                  
                  // タイトル
                  Text(
                    'ログイン',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: AppConstants.smallPadding),
                  
                  // サブタイトル
                  Text(
                    'アカウントにログインしてください',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: AppConstants.extraLargePadding),
                  
                  // メールアドレス入力
                  CustomTextField(
                    controller: _emailController,
                    labelText: 'メールアドレス',
                    hintText: 'example@email.com',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    prefixIcon: const Icon(Icons.email_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'メールアドレスを入力してください';
                      }
                      if (!AppUtils.isValidEmail(value)) {
                        return '有効なメールアドレスを入力してください';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: AppConstants.defaultPadding),
                  
                  // パスワード入力
                  CustomTextField(
                    controller: _passwordController,
                    labelText: 'パスワード',
                    hintText: 'パスワードを入力',
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.done,
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'パスワードを入力してください';
                      }
                      if (value.length < AppConstants.minPasswordLength) {
                        return 'パスワードは${AppConstants.minPasswordLength}文字以上で入力してください';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: AppConstants.smallPadding),
                  
                  // パスワードを忘れた場合
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // TODO: パスワードリセット画面への遷移
                      },
                      child: const Text('パスワードを忘れた場合'),
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.largePadding),
                  
                  // ログインボタン
                  CustomButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    text: 'ログイン',
                    isLoading: _isLoading,
                    icon: Icons.login,
                  ),
                  
                  const SizedBox(height: AppConstants.largePadding),
                  
                  // 区切り線
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.defaultPadding,
                        ),
                        child: Text(
                          'または',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  
                  const SizedBox(height: AppConstants.largePadding),
                  
                  // 新規登録ボタン
                  CustomButton(
                    onPressed: () => context.go(AppConstants.registerRoute),
                    text: '新規登録',
                    isOutlined: true,
                    icon: Icons.person_add,
                  ),
                  
                  const SizedBox(height: AppConstants.largePadding),
                  
                  // 利用規約・プライバシーポリシー
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ログインすることで、',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: 利用規約画面への遷移
                        },
                        child: const Text('利用規約'),
                      ),
                      Text(
                        'と',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: プライバシーポリシー画面への遷移
                        },
                        child: const Text('プライバシーポリシー'),
                      ),
                      Text(
                        'に同意したことになります。',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}