import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_constants.dart';
import '../di/di.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';

part 'app_router.g.dart';

/// アプリケーションルーター
@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: AppConstants.rootRoute,
    debugLogDiagnostics: true,
    redirect: (context, state) => _handleRedirect(ref, state),
    routes: $appRoutes,
    errorBuilder: (context, state) => _buildErrorScreen(context, state),
  );
}

/// リダイレクト処理
String? _handleRedirect(WidgetRef ref, GoRouterState state) {
  // 認証状態の監視
  final authState = ref.watch(authStateChangesProvider);
  
  // スプラッシュ画面の場合はリダイレクトしない
  if (state.fullPath == AppConstants.rootRoute) {
    return null;
  }
  
  // 認証が必要なルートの定義
  final authRequiredRoutes = [
    AppConstants.homeRoute,
    AppConstants.profileRoute,
    AppConstants.settingsRoute,
    AppConstants.feedRoute,
    AppConstants.shopRoute,
    AppConstants.cartRoute,
    AppConstants.orderRoute,
  ];
  
  // 認証不要なルートの定義
  final publicRoutes = [
    AppConstants.loginRoute,
    AppConstants.registerRoute,
    AppConstants.onboardingRoute,
  ];
  
  // 認証状態に基づくリダイレクト
  return authState.when(
    data: (user) {
      // ユーザーが認証済みの場合
      if (user != null) {
        // 認証不要なページにアクセスしている場合はホームにリダイレクト
        if (publicRoutes.contains(state.fullPath)) {
          return AppConstants.homeRoute;
        }
        return null; // リダイレクト不要
      } else {
        // ユーザーが未認証の場合
        // 認証が必要なページにアクセスしている場合はログインにリダイレクト
        if (authRequiredRoutes.any((route) => state.fullPath!.startsWith(route))) {
          return AppConstants.loginRoute;
        }
        return null; // リダイレクト不要
      }
    },
    loading: () {
      // 認証状態の読み込み中はスプラッシュ画面にリダイレクト
      return AppConstants.rootRoute;
    },
    error: (error, stack) {
      // エラーが発生した場合はログイン画面にリダイレクト
      return AppConstants.loginRoute;
    },
  );
}

/// エラー画面の構築
Widget _buildErrorScreen(BuildContext context, GoRouterState state) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('エラー'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.go(AppConstants.homeRoute),
      ),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'ページが見つかりません',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'URL: ${state.fullPath}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go(AppConstants.homeRoute),
            child: const Text('ホームに戻る'),
          ),
        ],
      ),
    ),
  );
}

/// ルート定義
@TypedGoRoute<SplashRoute>(
  path: AppConstants.rootRoute,
)
class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashScreen();
  }
}

@TypedGoRoute<LoginRoute>(
  path: AppConstants.loginRoute,
)
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

@TypedGoRoute<RegisterRoute>(
  path: AppConstants.registerRoute,
)
class RegisterRoute extends GoRouteData {
  const RegisterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RegisterScreen();
  }
}

@TypedGoRoute<OnboardingRoute>(
  path: AppConstants.onboardingRoute,
)
class OnboardingRoute extends GoRouteData {
  const OnboardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OnboardingScreen();
  }
}

@TypedGoRoute<HomeRoute>(
  path: AppConstants.homeRoute,
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@TypedGoRoute<ProfileRoute>(
  path: AppConstants.profileRoute,
)
class ProfileRoute extends GoRouteData {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfileScreen();
  }
}

@TypedGoRoute<SettingsRoute>(
  path: AppConstants.settingsRoute,
)
class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsScreen();
  }
}

/// ネストされたルートの例（SNS機能）
@TypedShellRoute<SocialShellRoute>(
  routes: [
    TypedGoRoute<FeedRoute>(
      path: AppConstants.feedRoute,
    ),
    TypedGoRoute<PostRoute>(
      path: AppConstants.postRoute,
    ),
    TypedGoRoute<CreatePostRoute>(
      path: AppConstants.createPostRoute,
    ),
  ],
)
class SocialShellRoute extends ShellRouteData {
  const SocialShellRoute();

  @override
  Widget build(BuildContext context, GoRouterState state, Widget navigator) {
    return ScaffoldWithNavigationBar(
      body: navigator,
      currentIndex: _calculateCurrentIndex(state.fullPath!),
    );
  }

  int _calculateCurrentIndex(String path) {
    switch (path) {
      case AppConstants.feedRoute:
        return 0;
      case AppConstants.createPostRoute:
        return 1;
      default:
        return 0;
    }
  }
}

class FeedRoute extends GoRouteData {
  const FeedRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FeedScreen();
  }
}

class PostRoute extends GoRouteData {
  const PostRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final postId = state.pathParameters['postId'];
    return PostScreen(postId: postId!);
  }
}

class CreatePostRoute extends GoRouteData {
  const CreatePostRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CreatePostScreen();
  }
}

/// ネストされたルートの例（EC機能）
@TypedShellRoute<ShopShellRoute>(
  routes: [
    TypedGoRoute<ShopRoute>(
      path: AppConstants.shopRoute,
    ),
    TypedGoRoute<ProductRoute>(
      path: AppConstants.productRoute,
    ),
    TypedGoRoute<CartRoute>(
      path: AppConstants.cartRoute,
    ),
    TypedGoRoute<CheckoutRoute>(
      path: AppConstants.checkoutRoute,
    ),
  ],
)
class ShopShellRoute extends ShellRouteData {
  const ShopShellRoute();

  @override
  Widget build(BuildContext context, GoRouterState state, Widget navigator) {
    return ScaffoldWithNavigationBar(
      body: navigator,
      currentIndex: _calculateCurrentIndex(state.fullPath!),
    );
  }

  int _calculateCurrentIndex(String path) {
    switch (path) {
      case AppConstants.shopRoute:
        return 0;
      case AppConstants.cartRoute:
        return 1;
      case AppConstants.checkoutRoute:
        return 2;
      default:
        return 0;
    }
  }
}

class ShopRoute extends GoRouteData {
  const ShopRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ShopScreen();
  }
}

class ProductRoute extends GoRouteData {
  const ProductRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final productId = state.pathParameters['productId'];
    return ProductScreen(productId: productId!);
  }
}

class CartRoute extends GoRouteData {
  const CartRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CartScreen();
  }
}

class CheckoutRoute extends GoRouteData {
  const CheckoutRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CheckoutScreen();
  }
}

/// ナビゲーションバー付きスキャフォールド
class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.currentIndex,
  });

  final Widget body;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go(AppConstants.feedRoute);
              break;
            case 1:
              context.go(AppConstants.createPostRoute);
              break;
            case 2:
              context.go(AppConstants.shopRoute);
              break;
            case 3:
              context.go(AppConstants.profileRoute);
              break;
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          NavigationDestination(
            icon: Icon(Icons.add),
            label: '投稿',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag),
            label: 'ショップ',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'プロフィール',
          ),
        ],
      ),
    );
  }
}