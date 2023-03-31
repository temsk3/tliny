import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../general_provider.dart';

part 'auth_repository.g.dart';

final logger = Logger();

// AuthRepositoryProvider
@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(ref.watch(firebaseAuthProvider));
}

// 認証状態プロバイダー
@riverpod
Stream<bool> authStateChanges(AuthStateChangesRef ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}

// UserIdプロバイダー
@riverpod
Stream<String?> userId(UserIdRef ref) {
  return ref.watch(authRepositoryProvider).userId;
}

class AuthRepository {
  // AuthRepository(this._ref);
  AuthRepository(this._auth);
  // final Ref _ref;
  final FirebaseAuth _auth;
  // late final _auth = _ref.read(firebaseAuthProvider);

  Stream<bool> get authStateChanges =>
      _auth.authStateChanges().map((user) => user != null);

  Stream<String?> get userId {
    return _auth.authStateChanges().map((user) {
      if (user != null) {
        return user.uid;
      } else {
        return null;
      }
    });
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw convertAuthError(e.code);
    }
  }

  Future<UserCredential> signUp(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      throw convertAuthError(e.code);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw convertAuthError(e.code);
    }
  }

  // bool get authState {
  //   try {
  //     late bool authState = false;
  //     _auth.authStateChanges().listen((User? user) {
  //       if (user != null) {
  //         authState = true;
  //       }
  //       authState = false;
  //     });
  //     return authState;
  //   } on FirebaseAuthException catch (e) {
  //     throw convertAuthError(e.code);
  //   }
  // }

  User? getCurrentUser() {
    try {
      return _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw convertAuthError(e.code);
    }
  }

  void updateDisplayName(String? displayName) {
    try {
      if (_auth.currentUser!.displayName != displayName ||
          _auth.currentUser!.displayName != null) {
        _auth.currentUser!.updateDisplayName(displayName);
      }
    } on FirebaseAuthException catch (e) {
      throw convertAuthError(e.code);
    }
  }

  void updateEmail(String email) {
    try {
      if (_auth.currentUser!.email != email ||
          _auth.currentUser!.email != null) {
        _auth.currentUser!.updateEmail(email);
      }
    } on FirebaseAuthException catch (e) {
      throw convertAuthError(e.code);
    }
  }

  void updatePassword(String password) {
    try {
      _auth.currentUser!.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      throw convertAuthError(e.code);
    }
  }

  // void updatePhoneNumber(String? phoneNumber) {
  //   try {
  //     if (_auth.currentUser!.phoneNumber != phoneNumber ||
  //         _auth.currentUser!.phoneNumber != null) {

  //       _auth.currentUser!.updatePhoneNumber(phoneNumber);
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     throw convertAuthError(e.code);
  //   }
  // }

  void updatePhotoUrl(String? photoUrl) {
    try {
      if (_auth.currentUser!.photoURL != photoUrl ||
          _auth.currentUser!.photoURL != null) {
        _auth.currentUser!.updatePhotoURL(photoUrl);
      }
    } on FirebaseAuthException catch (e) {
      throw convertAuthError(e.code);
    }
  }
}

/// FirebaseAuth のエラーコードからエラー文言を返す（https://firebase.google.com/docs/auth/admin/errors?hl=ja）
String convertAuthError(String errorCode) {
  switch (errorCode) {
    case 'invalid-email':
      return 'メールアドレスを正しい形式で入力してください';
    case 'wrong-password':
      return 'パスワードが間違っています';
    case 'user-not-found':
      return 'ユーザーが見つかりません';
    case 'weak-password':
      return 'パスワードは6文字以上で入力してください';
    case 'user-disabled':
      return 'ユーザーが無効です';
    case 'email-already-in-use':
      return 'このメールアドレスは既に登録されています';
    default:
      return '不明なエラーです';
  }
}
