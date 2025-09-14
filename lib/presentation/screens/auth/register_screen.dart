import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/base_widgets.dart';

/// 新規登録画面
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _displayNameController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;
  AccountType _selectedAccountType = AccountType.personal;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  /// 新規登録処理
  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('利用規約に同意してください'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: 新規登録処理の実装
      await Future.delayed(const Duration(seconds: 2)); // 仮の遅延
      
      if (mounted) {
        context.go(AppConstants.homeRoute);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('新規登録に失敗しました: $e'),
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

  /// 確認パスワード表示切り替え
  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新規登録'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppConstants.loginRoute),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.largePadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // アカウントタイプ選択
                Text(
                  'アカウントタイプ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppConstants.smallPadding),
                
                // 個人アカウント
                RadioListTile<AccountType>(
                  title: const Text('個人アカウント'),
                  subtitle: const Text('個人で利用する場合'),
                  value: AccountType.personal,
                  groupValue: _selectedAccountType,
                  onChanged: (value) {
                    setState(() {
                      _selectedAccountType = value!;
                    });
                  },
                ),
                
                // 団体アカウント
                RadioListTile<AccountType>(
                  title: const Text('団体アカウント'),
                  subtitle: const Text('商品販売を行う場合'),
                  value: AccountType.organization,
                  groupValue: _selectedAccountType,
                  onChanged: (value) {
                    setState(() {
                      _selectedAccountType = value!;
                    });
                  },
                ),
                
                const SizedBox(height: AppConstants.largePadding),
                
                // 表示名入力
                CustomTextField(
                  controller: _displayNameController,
                  labelText: '表示名',
                  hintText: '表示名を入力',
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.person_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '表示名を入力してください';
                    }
                    if (value.length > AppConstants.maxDisplayNameLength) {
                      return '表示名は${AppConstants.maxDisplayNameLength}文字以下で入力してください';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: AppConstants.defaultPadding),
                
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
                  textInputAction: TextInputAction.next,
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
                    if (value.length > AppConstants.maxPasswordLength) {
                      return 'パスワードは${AppConstants.maxPasswordLength}文字以下で入力してください';
                    }
                    
                    final strength = AppUtils.checkPasswordStrength(value);
                    if (strength == PasswordStrength.weak) {
                      return 'パスワードが弱すぎます。大文字、小文字、数字、記号を含めてください';
                    }
                    
                    return null;
                  },
                ),
                
                const SizedBox(height: AppConstants.defaultPadding),
                
                // パスワード確認入力
                CustomTextField(
                  controller: _confirmPasswordController,
                  labelText: 'パスワード確認',
                  hintText: 'パスワードを再入力',
                  obscureText: _obscureConfirmPassword,
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: _toggleConfirmPasswordVisibility,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'パスワード確認を入力してください';
                    }
                    if (value != _passwordController.text) {
                      return 'パスワードが一致しません';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: AppConstants.largePadding),
                
                // 利用規約同意
                CheckboxListTile(
                  title: const Text('利用規約に同意する'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          // TODO: 利用規約画面への遷移
                        },
                        child: const Text('利用規約'),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: プライバシーポリシー画面への遷移
                        },
                        child: const Text('プライバシーポリシー'),
                      ),
                    ],
                  ),
                  value: _agreeToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreeToTerms = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                
                const SizedBox(height: AppConstants.largePadding),
                
                // 新規登録ボタン
                CustomButton(
                  onPressed: _isLoading ? null : _handleRegister,
                  text: '新規登録',
                  isLoading: _isLoading,
                  icon: Icons.person_add,
                ),
                
                const SizedBox(height: AppConstants.largePadding),
                
                // ログイン画面へのリンク
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '既にアカウントをお持ちですか？',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.go(AppConstants.loginRoute),
                      child: const Text('ログイン'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// アカウントタイプの列挙型
enum AccountType {
  personal,
  organization,
}