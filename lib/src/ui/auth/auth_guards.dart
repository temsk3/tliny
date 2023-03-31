import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../settings/routes/app_route.gr.dart';
import '../../ui/auth/auth_view_model.dart';

final authGuardProvider = Provider(AuthGuard.new);

class AuthGuard extends AutoRouteGuard {
  AuthGuard(this._ref);
  final Ref _ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // final authState = _ref.watch(userStateProvider);
    // authState.whenData((user) {
    //   // ログイン済みの場合
    //   if (user != null) {
    //     resolver.next(true);
    //   }
    //   // 未ログインの場合
    //   router.push(const SignInRoute(onResult: (success) {
    //     resolver.next(success);
    //   }));
    // });
    final isAuthenticated = _ref.read(authViewModelProvider) != null;
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    if (isAuthenticated) {
      // if user is authenticated we continue
      resolver.next();
    } else {
      // we redirect the user to our login page
      router.popAndPush(
        SignInRoute(
          onSigninCallback: (success) {
            // if success == true the navigation will be resumed
            // else it will be aborted
            resolver.next(success);
          },
        ),
      );
    }
  }
}
