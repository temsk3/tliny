// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../ui/auth/auth_state.dart';
// import '../ui/auth/sign_in.dart';
// import '../ui/home.dart';

// class AuthVerification extends HookConsumerWidget {
//   const AuthVerification({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authState = ref.watch(userStateProvider);
//     return authState.when(data: (data) {
//       // ログイン済みの場合
//       if (data != null) {
//         return const HomePage();
//       }
//       // 未ログインの場合
//       return const SignInPage(onSigninCallback: (bool signIn) {  },);
//     }, loading: () {
//       return const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }, error: (_, __) {
//       return const Scaffold(
//         body: Center(
//           child: Text('エラー'),
//         ),
//       );
//     });
//   }
// }
