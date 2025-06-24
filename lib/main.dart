import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';
import 'foundation/constants.dart';
import 'src/app.dart';
import 'src/utils/logger.dart';

void main() {
  // エラーハンドリングを行うためのゾーンを作成
  runZonedGuarded(
    () async {
      // Flutterフレームワークが初期化される前に必要な処理を行う。
      WidgetsFlutterBinding.ensureInitialized();

      // スプラッシュスクリーンを保持しておく
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      // Firebaseの初期化
      await _initializeFirebase();

      // .envファイルから環境変数を読み込む
      await dotenv.load();

      // ログ出力
      logger
        ..i('環境変数を読み込みました')
        ..i(Constants.flavor);

      // アプリケーションの実行
      runApp(
        // Riverpodの状態管理Providerを設定
        ProviderScope(
          // DevicePreviewを有効化（リリースモード以外かつプレビューが有効な場合）
          child: DevicePreview(
            enabled: !kReleaseMode && Constants.enablePreview,
            builder: (context) => const MyApp(),
          ),
        ),
      );
    },
    // エラー発生時の処理
    (error, stackTrace) {
      // Crashlyticsにエラーを報告
      FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
      // エラーログを出力
      logger.e(
        '致命的なエラーが発生しました',
        time: DateTime.now(),
        error: error,
        stackTrace: stackTrace,
      );
    },
  );
}

/// Firebaseの初期化処理
Future<void> _initializeFirebase() async {
  // Firebaseの初期化
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Flutterエラー発生時の処理
  FlutterError.onError = (errorDetails) {
    logger.e(errorDetails, time: DateTime.now());
    // Web以外でCrashlyticsにFlutterエラーを報告
    if (!kIsWeb) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    }
  };

  // プラットフォームエラー発生時の処理
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    logger.e('プラットフォームエラー', error: error, stackTrace: stack);
    return true;
  };

  // 開発環境の場合、エミュレータに接続
  if (Constants.flavor == Flavor.dev && kDebugMode) {
    await _connectToEmulators();
  }
}

/// Firebaseエミュレータへの接続処理
Future<void> _connectToEmulators() async {
  final db = FirebaseFirestore.instance;
  const localhost = 'localhost';
  try {
    // Cloud Functionsエミュレータへの接続
    FirebaseFunctions.instanceFor(
      region: 'asia-northeast1',
    ).useFunctionsEmulator(localhost, 5001);
    logger.i('Cloud Functions Emulator started');

    // Firestoreエミュレータへの接続
    db.useFirestoreEmulator(localhost, 8081);
    logger.i('Firestore Emulator started');

    // FirebaseAuthエミュレータへの接続
    await FirebaseAuth.instance.useAuthEmulator(localhost, 9099);
    logger.i('FirebaseAuth Emulator started');

    // FirebaseStorageエミュレータへの接続
    await FirebaseStorage.instance.useStorageEmulator(localhost, 9199);
    logger.i('FirebaseStorage Emulator started');

    // Webの場合、Firestoreの永続化を有効にする
    if (kIsWeb) {
      db.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );
      logger.i('Firestore Persistence enabled');
    }
    // エミュレータ起動時のエラー処理
  } on Exception catch (e) {
    logger.e('Error starting emulators', error: e);
  }
}
