import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

/// Firebase test setup utility
/// This should be called in setUpAll() of test files that use Firebase services
Future<void> setupFirebaseForTesting() async {
  // Ensure bindings are initialized
  TestWidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase for testing
  setupFirebaseCoreMocks();
  
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'fake-api-key',
      appId: 'fake-app-id',
      messagingSenderId: 'fake-sender-id',
      projectId: 'fake-project-id',
    ),
  );
}
