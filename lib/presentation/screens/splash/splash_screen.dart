import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/base_widgets.dart';
import '../auth/login_screen.dart';

/// スプラッシュ画面
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  /// アニメーションの初期化
  void _initializeAnimations() {
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    _textAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    ));
  }

  /// アニメーションの開始
  void _startAnimations() async {
    // ロゴアニメーション開始
    await _logoController.forward();
    
    // テキストアニメーション開始
    await _textController.forward();
    
    // 少し待機してから画面遷移
    await Future.delayed(const Duration(milliseconds: 500));
    
    // 認証状態に基づいて画面遷移
    _navigateToNextScreen();
  }

  /// 次の画面への遷移
  void _navigateToNextScreen() {
    // 認証状態を監視して適切な画面に遷移
    ref.read(authStateChangesProvider).when(
      data: (user) {
        if (user != null) {
          // ユーザーが認証済みの場合
          context.go(AppConstants.homeRoute);
        } else {
          // ユーザーが未認証の場合
          context.go(AppConstants.loginRoute);
        }
      },
      loading: () {
        // 認証状態の読み込み中はログイン画面に遷移
        context.go(AppConstants.loginRoute);
      },
      error: (error, stack) {
        // エラーが発生した場合はログイン画面に遷移
        context.go(AppConstants.loginRoute);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ロゴアニメーション
              ScaleTransition(
                scale: _logoAnimation,
                child: FadeTransition(
                  opacity: _logoAnimation,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.shopping_bag,
                      size: 60,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: AppConstants.largePadding),
              
              // アプリ名アニメーション
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.5),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _textAnimation,
                  curve: Curves.easeOutCubic,
                )),
                child: FadeTransition(
                  opacity: _textAnimation,
                  child: Text(
                    AppConstants.appName,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: AppConstants.smallPadding),
              
              // サブタイトルアニメーション
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.5),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _textAnimation,
                  curve: Curves.easeOutCubic,
                )),
                child: FadeTransition(
                  opacity: _textAnimation,
                  child: Text(
                    'SNS × EC プラットフォーム',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: AppConstants.extraLargePadding),
              
              // ローディングインジケーター
              const LoadingWidget(
                message: '読み込み中...',
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}