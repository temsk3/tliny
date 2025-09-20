import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

/// Firebase test setup utility
/// This should be called in setUpAll() of test files that use Firebase services
Future<void> setupFirebaseForTesting() async {
  // Ensure bindings are initialized
  TestWidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase for tests
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'test-api-key',
      appId: 'test-app-id',
      messagingSenderId: 'test-sender-id',
      projectId: 'test-project-id',
    ),
  );
}
