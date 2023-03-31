import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:device_preview/device_preview.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:stripe_sdk/stripe_sdk.dart';

import 'firebase_options.dart';
import 'foundation/constants.dart';
import 'src/app.dart';

final logger = Logger();

Future<void> main() async {
  /// クラッシュハンドラ
  await runZonedGuarded<Future<void>>(
    () async {
      /// クラッシュハンドラ(Flutterフレームワーク内でスローされたすべてのエラー)
      if (!kIsWeb) {
        FlutterError.onError =
            FirebaseCrashlytics.instance.recordFlutterFatalError;
      }

      /// Stripe
      await dotenv.load();
      final publishableKey = dotenv.get('STRIPE_PUBLIC');
      final apiVersion = dotenv.get('STRIPE_API_VERSION');
      Stripe.init(publishableKey);
      StripeApi.init(publishableKey, apiVersion: apiVersion);
      // Stripe.publishableKey = publishableKey;
      // await Stripe.instance.applySettings();

      /// Firebaseの初期化
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      logger.i(Constants.flavor);

      if (Constants.flavor == Flavor.dev) {
        // Display Toast (Only Dev)
        await Fluttertoast.showToast(
          msg: 'flavor: ${EnumToString.convertToString(Constants.flavor)}',
        );
        // firebase emulator (Only Dev)
        const localhost = 'localhost';
        FirebaseFunctions.instanceFor(region: 'asia-northeast1')
            .useFunctionsEmulator(localhost, 5001);
        FirebaseFirestore.instance.useFirestoreEmulator(localhost, 8081);
        await Future.wait(
          [
            FirebaseAuth.instance.useAuthEmulator(localhost, 9099),
            FirebaseStorage.instance.useStorageEmulator(localhost, 9199),
          ],
        );
      } else if (kIsWeb) {
        await FirebaseFirestore.instance.enablePersistence(
          const PersistenceSettings(synchronizeTabs: true),
        );
      }

      runApp(
        ProviderScope(
          child: DevicePreview(
            enabled: !kReleaseMode && Constants.enablePreview,
            builder: (context) => MyApp(),
          ),
        ),
      );
    },

    /// クラッシュハンドラ(Flutterフレームワーク内でキャッチされないエラー)
    (error, stackTrace) {
      if (!kIsWeb) {
        FirebaseCrashlytics.instance
            .recordError(error, stackTrace, fatal: true);
      }
      logger.e(error, [error, stackTrace]);
    },
  );
}
