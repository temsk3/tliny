import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../data/repository/auth_repository.dart';

final logger = Logger();

final authViewModelProvider =
    StateNotifierProvider.autoDispose<AuthViewModel, User?>(
  AuthViewModel.new, //..state,
);

class AuthViewModel extends StateNotifier<User?> {
  AuthViewModel(this._ref) : super(null);
  final Ref _ref;
  StreamSubscription<User?>? _userStreamSubscription;
  // {
  //   _userStreamSubscription?.cancel();
  //   _userStreamSubscription = _ref
  //       .read(authRepositoryProvider)
  //       .authStateChanges
  //       .listen((user) => state = user);
  // }
  @override
  User? get state {
    final user = _ref.read(authRepositoryProvider).getCurrentUser();
    logger.i(user);
    return user;
  }

  @override
  void dispose() {
    _userStreamSubscription?.cancel();
    super.dispose();
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _ref.read(authRepositoryProvider).signInWithEmail(email, password);
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<void> signUp(String email, String password) async {
    await _ref.read(authRepositoryProvider).signUp(email, password);
    // Firestoreにユーザデータを追加したり
  }

  Future<void> signOut() async {
    await _ref.read(authRepositoryProvider).signOut();
  }
}
