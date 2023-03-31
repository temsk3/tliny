import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'general_provider.g.dart';

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) {
  return FirebaseAuth.instance;
}

// final firebaseAuthProvider =
//     Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
@Riverpod(keepAlive: true)
FirebaseFirestore firebaseFirestore(FirebaseFirestoreRef ref) {
  return FirebaseFirestore.instance;
}

// final firebaseFirestoreProvider = Provider((ref) => FirebaseFirestore.instance);
@Riverpod(keepAlive: true)
FirebaseStorage firebaseStorage(FirebaseStorageRef ref) {
  return FirebaseStorage.instance;
}

// final firebaseStorageProvider = Provider((ref) => FirebaseStorage.instance);
@Riverpod(keepAlive: true)
FirebaseFunctions firebaseFunctions(FirebaseFunctionsRef ref) {
  return FirebaseFunctions.instanceFor(
    app: Firebase.app(),
    region: 'asia-northeast1',
  );
}
// final firebaseFunctionsProvider = Provider(
//   (ref) => FirebaseFunctions.instanceFor(
//     app: Firebase.app(),
//     region: 'asia-northeast1',
//   ),
// );
// final userStateProvider =
//     StreamProvider((ref) => FirebaseAuth.instance.authStateChanges());
