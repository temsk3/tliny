import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

/// Firebase test setup utility
/// This should be called in setUpAll() of test files that use Firebase services
Future<void> setupFirebaseForTesting() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Check if Firebase is already initialized
  try {
    Firebase.app();
    // Firebase is already initialized, no need to initialize again
    return;
  } catch (e) {
    // Firebase is not initialized, proceed with initialization
  }

  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'fake-api-key',
        appId: 'fake-app-id',
        messagingSenderId: 'fake-sender-id',
        projectId: 'fake-project-id',
        storageBucket: 'fake-storage-bucket',
        authDomain: 'fake-auth-domain',
      ),
    );
  } catch (e) {
    // Firebase is already initialized, ignore the error
    if (!e.toString().contains('already been initialized') && 
        !e.toString().contains('PlatformException')) {
      rethrow;
    }
  }
}
