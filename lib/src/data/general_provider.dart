import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'general_provider.g.dart';

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(Ref ref) {
  // テスト環境ではFirebaseを無効化
  if (const bool.fromEnvironment('FLUTTER_TEST') ||
      (const String.fromEnvironment('TEST') == 'true')) {
    throw UnimplementedError(
      'FirebaseAuth is not available in test environment',
    );
  }
  return FirebaseAuth.instance;
}

@Riverpod(keepAlive: true)
FirebaseFirestore firebaseFirestore(Ref ref) {
  // テスト環境ではFirebaseを無効化
  if (const bool.fromEnvironment('FLUTTER_TEST') ||
      (const String.fromEnvironment('TEST') == 'true')) {
    throw UnimplementedError(
      'FirebaseFirestore is not available in test environment',
    );
  }
  return FirebaseFirestore.instance;
}

@Riverpod(keepAlive: true)
FirebaseStorage firebaseStorage(Ref ref) {
  // テスト環境ではFirebaseを無効化
  if (const bool.fromEnvironment('FLUTTER_TEST') ||
      (const String.fromEnvironment('TEST') == 'true')) {
    throw UnimplementedError(
      'FirebaseStorage is not available in test environment',
    );
  }
  return FirebaseStorage.instance;
}

@Riverpod(keepAlive: true)
FirebaseFunctions firebaseFunctions(Ref ref) {
  // テスト環境ではFirebaseを無効化
  if (const bool.fromEnvironment('FLUTTER_TEST') ||
      (const String.fromEnvironment('TEST') == 'true')) {
    throw UnimplementedError(
      'FirebaseFunctions is not available in test environment',
    );
  }
  return FirebaseFunctions.instanceFor(
    app: Firebase.app(),
    region: 'asia-northeast1',
  );
}

final userStateProvider = StreamProvider(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);
