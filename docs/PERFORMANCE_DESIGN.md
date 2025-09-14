# SNS 統合 EC アプリケーション パフォーマンス設計書

ドキュメントバージョン: 1.0  
作成日: 2025 年 1 月 21 日  
更新日: 2025 年 1 月 21 日

## 目次

1. [パフォーマンス要件](#1-パフォーマンス要件)
2. [アプリケーション性能](#2-アプリケーション性能)
3. [ネットワーク性能](#3-ネットワーク性能)
4. [データベース性能](#4-データベース性能)
5. [画像・メディア最適化](#5-画像メディア最適化)
6. [キャッシュ戦略](#6-キャッシュ戦略)
7. [メモリ管理](#7-メモリ管理)
8. [バッテリー最適化](#8-バッテリー最適化)
9. [監視・分析](#9-監視分析)

---

## 1. パフォーマンス要件

### 1.1 応答時間要件

| 操作 | 目標時間 | 許容時間 | 測定方法 |
|------|----------|----------|----------|
| **アプリ起動** | 3秒 | 5秒 | コールドスタート |
| **画面遷移** | 0.5秒 | 1秒 | タップから表示まで |
| **データ読み込み** | 2秒 | 3秒 | API呼び出し完了 |
| **画像表示** | 1秒 | 2秒 | 画像ダウンロード完了 |
| **検索実行** | 1秒 | 2秒 | 検索結果表示 |
| **決済処理** | 5秒 | 10秒 | 決済完了 |

### 1.2 スループット要件

| 機能 | 同時ユーザー数 | リクエスト/秒 | データ量 |
|------|----------------|---------------|----------|
| **投稿表示** | 10,000 | 100 | 1MB/page |
| **商品検索** | 5,000 | 50 | 500KB/page |
| **決済処理** | 1,000 | 10 | 100KB/transaction |
| **画像アップロード** | 2,000 | 20 | 5MB/file |

### 1.3 リソース使用量要件

| リソース | 通常使用時 | ピーク時 | 測定方法 |
|----------|------------|----------|----------|
| **メモリ** | 100MB | 200MB | プロセスメモリ |
| **CPU** | 20% | 50% | 平均使用率 |
| **ネットワーク** | 1MB/min | 10MB/min | データ転送量 |
| **ストレージ** | 50MB | 500MB | アプリサイズ |

---

## 2. アプリケーション性能

### 2.1 起動時間最適化

#### 2.1.1 コールドスタート最適化

```dart
// lib/main.dart - 最適化されたエントリーポイント
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Flutter Engine初期化の最適化
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase初期化（非同期）
  await Firebase.initializeApp();
  
  // アプリ起動
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SNS EC App',
      // 初期化時間短縮のための設定
      debugShowCheckedModeBanner: false,
      // プリロード設定
      builder: (context, child) {
        return FutureBuilder(
          future: _preloadResources(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return child!;
            }
            return SplashScreen();
          },
        );
      },
    );
  }

  Future<void> _preloadResources() async {
    // 重要なリソースのプリロード
    await precacheImage(AssetImage('assets/images/logo.png'), null);
    await precacheImage(AssetImage('assets/images/placeholder.png'), null);
  }
}
```

#### 2.1.2 ウォームスタート最適化

```dart
// lib/core/cache/app_cache.dart
@riverpod
class AppCache extends _$AppCache {
  @override
  Future<void> build() async {
    // アプリ状態の永続化
    await _restoreAppState();
    
    // 重要なデータのプリロード
    await _preloadCriticalData();
  }

  Future<void> _restoreAppState() async {
    final prefs = await SharedPreferences.getInstance();
    final lastScreen = prefs.getString('last_screen');
    
    if (lastScreen != null) {
      // 前回の画面状態を復元
      ref.read(routerProvider).go(lastScreen);
    }
  }

  Future<void> _preloadCriticalData() async {
    // ユーザー情報のプリロード
    final user = ref.read(authServiceProvider).currentUser;
    if (user != null) {
      await ref.read(userRepositoryProvider).getUserProfile(user.id);
    }
  }
}
```

### 2.2 画面遷移最適化

#### 2.2.1 ルーティング最適化

```dart
// lib/core/router/app_router.dart
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // 遅延読み込みによる画面遷移最適化
    GoRoute(
      path: '/profile/:userId',
      builder: (context, state) => LazyWidget(
        builder: () => UserProfileScreen(
          userId: state.pathParameters['userId']!,
        ),
      ),
    ),
    
    // プリロード設定
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(),
      redirect: (context, state) {
        // 認証チェックの最適化
        final authState = ref.read(authStateProvider);
        if (authState.isLoading) return null;
        if (!authState.hasValue) return '/login';
        return null;
      },
    ),
  ],
);

// 遅延読み込みウィジェット
class LazyWidget extends StatelessWidget {
  final WidgetBuilder builder;
  
  const LazyWidget({required this.builder});
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 100)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return builder(context);
        }
        return LoadingWidget();
      },
    );
  }
}
```

#### 2.2.2 アニメーション最適化

```dart
// lib/core/animations/optimized_animations.dart
class OptimizedPageRoute extends PageRouteBuilder {
  OptimizedPageRoute({required Widget child})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // ハードウェアアクセラレーションを使用
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: Offset(1.0, 0.0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.easeInOut)),
              ),
              child: child,
            );
          },
          // アニメーション時間の最適化
          transitionDuration: Duration(milliseconds: 300),
          reverseTransitionDuration: Duration(milliseconds: 250),
        );
}
```

---

## 3. ネットワーク性能

### 3.1 API最適化

#### 3.1.1 リクエスト最適化

```dart
// lib/core/network/api_client.dart
@riverpod
class ApiClient extends _$ApiClient {
  @override
  Dio build() {
    final dio = Dio();
    
    // タイムアウト設定
    dio.options.connectTimeout = Duration(seconds: 10);
    dio.options.receiveTimeout = Duration(seconds: 30);
    
    // リクエスト圧縮
    dio.options.headers['Accept-Encoding'] = 'gzip, deflate';
    
    // リトライ設定
    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        logPrint: print,
        retries: 3,
        retryDelays: [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 4),
        ],
      ),
    );
    
    return dio;
  }
}

// バッチリクエスト実装
class BatchRequestService {
  final ApiClient _apiClient;
  final List<Future Function()> _pendingRequests = [];
  
  BatchRequestService(this._apiClient);
  
  void addRequest(Future Function() request) {
    _pendingRequests.add(request);
  }
  
  Future<List<dynamic>> executeBatch() async {
    if (_pendingRequests.isEmpty) return [];
    
    // 並列実行による性能向上
    final results = await Future.wait(_pendingRequests);
    _pendingRequests.clear();
    
    return results;
  }
}
```

#### 3.1.2 レスポンス最適化

```dart
// lib/core/network/response_optimizer.dart
class ResponseOptimizer {
  // レスポンスサイズの最適化
  static Map<String, dynamic> optimizeResponse(Map<String, dynamic> data) {
    final optimized = <String, dynamic>{};
    
    data.forEach((key, value) {
      if (value != null) {
        // 不要なフィールドの削除
        if (!_isUnnecessaryField(key)) {
          optimized[key] = value;
        }
      }
    });
    
    return optimized;
  }
  
  static bool _isUnnecessaryField(String field) {
    const unnecessaryFields = [
      'created_at',
      'updated_at',
      'deleted_at',
      'internal_metadata',
    ];
    
    return unnecessaryFields.contains(field);
  }
  
  // 画像URLの最適化
  static String optimizeImageUrl(String url, {int? width, int? height}) {
    if (url.contains('firebasestorage.googleapis.com')) {
      // Firebase Storage URL最適化
      final uri = Uri.parse(url);
      final queryParams = <String, String>{};
      
      if (width != null) queryParams['width'] = width.toString();
      if (height != null) queryParams['height'] = height.toString();
      queryParams['quality'] = '80';
      
      return uri.replace(queryParameters: queryParams).toString();
    }
    
    return url;
  }
}
```

### 3.2 接続品質管理

```dart
// lib/core/network/connection_manager.dart
@riverpod
class ConnectionManager extends _$ConnectionManager {
  @override
  ConnectionState build() {
    return ConnectionState.unknown;
  }
  
  Future<void> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        state = ConnectionState.connected;
      } else {
        state = ConnectionState.disconnected;
      }
    } on SocketException catch (_) {
      state = ConnectionState.disconnected;
    }
  }
  
  // 接続品質に応じた設定調整
  void adjustSettingsForConnection() {
    switch (state) {
      case ConnectionState.connected:
        _setHighQualitySettings();
        break;
      case ConnectionState.disconnected:
        _setLowQualitySettings();
        break;
      default:
        _setDefaultSettings();
    }
  }
  
  void _setHighQualitySettings() {
    // 高品質設定
    ref.read(imageQualityProvider.notifier).state = ImageQuality.high;
    ref.read(videoQualityProvider.notifier).state = VideoQuality.high;
  }
  
  void _setLowQualitySettings() {
    // 低品質設定
    ref.read(imageQualityProvider.notifier).state = ImageQuality.low;
    ref.read(videoQualityProvider.notifier).state = VideoQuality.low;
  }
}
```

---

## 4. データベース性能

### 4.1 Firestore最適化

#### 4.1.1 クエリ最適化

```dart
// lib/data/repositories/optimized_post_repository.dart
class OptimizedPostRepository {
  final FirebaseFirestore _firestore;
  
  OptimizedPostRepository(this._firestore);
  
  // インデックスを活用した効率的なクエリ
  Stream<List<Post>> getPostsStream({
    required String userId,
    int limit = 20,
    DocumentSnapshot? lastDocument,
  }) {
    Query query = _firestore
        .collection('posts')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(limit);
    
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }
    
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Post.fromFirestore(doc)).toList();
    });
  }
  
  // 複合クエリの最適化
  Future<List<Post>> searchPosts({
    required String keyword,
    required List<String> categories,
    int limit = 50,
  }) async {
    // 全文検索はAlgoliaを使用
    final algolia = ref.read(algoliaServiceProvider);
    final results = await algolia.searchPosts(keyword, categories, limit);
    
    // Firestoreから詳細データを取得
    final postIds = results.map((r) => r['objectID'] as String).toList();
    
    if (postIds.isEmpty) return [];
    
    // バッチ取得による効率化
    final batchSize = 10;
    final posts = <Post>[];
    
    for (int i = 0; i < postIds.length; i += batchSize) {
      final batch = postIds.skip(i).take(batchSize);
      final query = _firestore
          .collection('posts')
          .where(FieldPath.documentId, whereIn: batch.toList());
      
      final snapshot = await query.get();
      posts.addAll(
        snapshot.docs.map((doc) => Post.fromFirestore(doc)),
      );
    }
    
    return posts;
  }
}
```

#### 4.1.2 データ構造最適化

```dart
// lib/data/models/optimized_post_model.dart
@freezed
class OptimizedPost with _$OptimizedPost {
  const factory OptimizedPost({
    required String id,
    required String userId,
    required String content,
    // 正規化されたデータ（参照のみ）
    @Default([]) List<String> imageUrls,
    @Default([]) List<String> videoUrls,
    // 集計データ（事前計算）
    @Default(0) int likeCount,
    @Default(0) int commentCount,
    @Default(0) int shareCount,
    // インデックス用フィールド
    required DateTime createdAt,
    required DateTime updatedAt,
    // 検索用フィールド
    @Default([]) List<String> tags,
    @Default('') String searchText,
  }) = _OptimizedPost;
  
  factory OptimizedPost.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return OptimizedPost(
      id: doc.id,
      userId: data['userId'] ?? '',
      content: data['content'] ?? '',
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      videoUrls: List<String>.from(data['videoUrls'] ?? []),
      likeCount: data['likeCount'] ?? 0,
      commentCount: data['commentCount'] ?? 0,
      shareCount: data['shareCount'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      tags: List<String>.from(data['tags'] ?? []),
      searchText: data['searchText'] ?? '',
    );
  }
}
```

### 4.2 オフライン対応

```dart
// lib/core/offline/offline_manager.dart
@riverpod
class OfflineManager extends _$OfflineManager {
  @override
  OfflineState build() {
    return OfflineState.enabled;
  }
  
  // オフライン時のデータ同期
  Future<void> syncOfflineData() async {
    final pendingOperations = await _getPendingOperations();
    
    for (final operation in pendingOperations) {
      try {
        await _executeOperation(operation);
        await _markOperationComplete(operation.id);
      } catch (e) {
        await _markOperationFailed(operation.id, e.toString());
      }
    }
  }
  
  // オフライン用データの事前ダウンロード
  Future<void> preloadOfflineData() async {
    final user = ref.read(authServiceProvider).currentUser;
    if (user == null) return;
    
    // 重要なデータの事前ダウンロード
    await _preloadUserProfile(user.id);
    await _preloadRecentPosts(user.id);
    await _preloadUserProducts(user.id);
  }
  
  Future<void> _preloadUserProfile(String userId) async {
    final profile = await ref.read(userRepositoryProvider).getUserProfile(userId);
    
    // ローカルストレージに保存
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_profile_$userId', jsonEncode(profile.toJson()));
  }
}
```

---

## 5. 画像・メディア最適化

### 5.1 画像最適化

#### 5.1.1 画像圧縮・リサイズ

```dart
// lib/core/media/image_optimizer.dart
class ImageOptimizer {
  // 画像圧縮
  static Future<File> compressImage(File file, {
    int maxWidth = 1920,
    int maxHeight = 1080,
    int quality = 80,
  }) async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    
    if (image == null) throw Exception('Invalid image');
    
    // リサイズ
    final resized = img.copyResize(
      image,
      width: image.width > maxWidth ? maxWidth : image.width,
      height: image.height > maxHeight ? maxHeight : image.height,
    );
    
    // 圧縮
    final compressed = img.encodeJpg(resized, quality: quality);
    
    // 一時ファイルに保存
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg');
    await tempFile.writeAsBytes(compressed);
    
    return tempFile;
  }
  
  // プログレッシブJPEG生成
  static Future<File> createProgressiveJpeg(File file) async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    
    if (image == null) throw Exception('Invalid image');
    
    // プログレッシブJPEGとして保存
    final progressive = img.encodeJpg(image, progressive: true);
    
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/progressive_${DateTime.now().millisecondsSinceEpoch}.jpg');
    await tempFile.writeAsBytes(progressive);
    
    return tempFile;
  }
}
```

#### 5.1.2 画像キャッシュ

```dart
// lib/core/media/image_cache_manager.dart
@riverpod
class ImageCacheManager extends _$ImageCacheManager {
  @override
  Future<void> build() async {
    // キャッシュディレクトリの初期化
    await _initializeCache();
  }
  
  Future<void> _initializeCache() async {
    final cacheDir = await getTemporaryDirectory();
    final imageCacheDir = Directory('${cacheDir.path}/images');
    
    if (!await imageCacheDir.exists()) {
      await imageCacheDir.create(recursive: true);
    }
  }
  
  // 画像の事前読み込み
  Future<void> preloadImages(List<String> urls) async {
    for (final url in urls) {
      try {
        await precacheImage(NetworkImage(url), null);
      } catch (e) {
        print('Failed to preload image: $url');
      }
    }
  }
  
  // キャッシュサイズ管理
  Future<void> manageCacheSize() async {
    final cacheDir = await getTemporaryDirectory();
    final imageCacheDir = Directory('${cacheDir.path}/images');
    
    if (!await imageCacheDir.exists()) return;
    
    final files = await imageCacheDir.list().toList();
    final totalSize = files.fold<int>(0, (sum, file) => sum + (file.statSync().size));
    
    // キャッシュサイズが100MBを超えた場合、古いファイルを削除
    if (totalSize > 100 * 1024 * 1024) {
      final sortedFiles = files
          .whereType<File>()
          .toList()
          ..sort((a, b) => a.statSync().modified.compareTo(b.statSync().modified));
      
      // 古いファイルから削除
      for (final file in sortedFiles.take(sortedFiles.length ~/ 2)) {
        await file.delete();
      }
    }
  }
}
```

### 5.2 動画最適化

```dart
// lib/core/media/video_optimizer.dart
class VideoOptimizer {
  // 動画圧縮
  static Future<File> compressVideo(File file, {
    int maxWidth = 1280,
    int maxHeight = 720,
    int bitrate = 1000000, // 1Mbps
  }) async {
    final tempDir = await getTemporaryDirectory();
    final outputPath = '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.mp4';
    
    // FFmpegを使用した動画圧縮
    final result = await Process.run('ffmpeg', [
      '-i', file.path,
      '-vf', 'scale=$maxWidth:$maxHeight',
      '-b:v', '${bitrate}',
      '-c:a', 'aac',
      '-b:a', '128k',
      outputPath,
    ]);
    
    if (result.exitCode != 0) {
      throw Exception('Video compression failed: ${result.stderr}');
    }
    
    return File(outputPath);
  }
  
  // 動画サムネイル生成
  static Future<File> generateThumbnail(File videoFile) async {
    final tempDir = await getTemporaryDirectory();
    final thumbnailPath = '${tempDir.path}/thumbnail_${DateTime.now().millisecondsSinceEpoch}.jpg';
    
    // FFmpegを使用したサムネイル生成
    final result = await Process.run('ffmpeg', [
      '-i', videoFile.path,
      '-ss', '00:00:01',
      '-vframes', '1',
      '-vf', 'scale=320:240',
      thumbnailPath,
    ]);
    
    if (result.exitCode != 0) {
      throw Exception('Thumbnail generation failed: ${result.stderr}');
    }
    
    return File(thumbnailPath);
  }
}
```

---

## 6. キャッシュ戦略

### 6.1 多層キャッシュ

```dart
// lib/core/cache/multi_layer_cache.dart
@riverpod
class MultiLayerCache extends _$MultiLayerCache {
  @override
  Future<void> build() async {
    // 各キャッシュレイヤーの初期化
    await _initializeCaches();
  }
  
  Future<void> _initializeCaches() async {
    // L1: メモリキャッシュ
    await ref.read(memoryCacheProvider.future);
    
    // L2: ディスクキャッシュ
    await ref.read(diskCacheProvider.future);
    
    // L3: ネットワークキャッシュ
    await ref.read(networkCacheProvider.future);
  }
  
  // 多層キャッシュからのデータ取得
  Future<T?> get<T>(String key, Future<T> Function() fetcher) async {
    // L1: メモリキャッシュから検索
    final memoryCache = ref.read(memoryCacheProvider);
    var data = memoryCache.get<T>(key);
    
    if (data != null) {
      return data;
    }
    
    // L2: ディスクキャッシュから検索
    final diskCache = ref.read(diskCacheProvider);
    data = await diskCache.get<T>(key);
    
    if (data != null) {
      // メモリキャッシュに保存
      memoryCache.set(key, data);
      return data;
    }
    
    // L3: ネットワークから取得
    try {
      data = await fetcher();
      
      // 各キャッシュに保存
      memoryCache.set(key, data);
      await diskCache.set(key, data);
      
      return data;
    } catch (e) {
      return null;
    }
  }
}

// メモリキャッシュ
@riverpod
class MemoryCache extends _$MemoryCache {
  final Map<String, dynamic> _cache = {};
  final Map<String, DateTime> _timestamps = {};
  
  @override
  Map<String, dynamic> build() {
    return _cache;
  }
  
  T? get<T>(String key) {
    final timestamp = _timestamps[key];
    if (timestamp == null) return null;
    
    // 5分で期限切れ
    if (DateTime.now().difference(timestamp).inMinutes > 5) {
      _cache.remove(key);
      _timestamps.remove(key);
      return null;
    }
    
    return _cache[key] as T?;
  }
  
  void set<T>(String key, T value) {
    _cache[key] = value;
    _timestamps[key] = DateTime.now();
  }
}

// ディスクキャッシュ
@riverpod
class DiskCache extends _$DiskCache {
  @override
  Future<void> build() async {
    final cacheDir = await getTemporaryDirectory();
    final diskCacheDir = Directory('${cacheDir.path}/disk_cache');
    
    if (!await diskCacheDir.exists()) {
      await diskCacheDir.create(recursive: true);
    }
  }
  
  Future<T?> get<T>(String key) async {
    final cacheDir = await getTemporaryDirectory();
    final file = File('${cacheDir.path}/disk_cache/$key.json');
    
    if (!await file.exists()) return null;
    
    try {
      final json = await file.readAsString();
      final data = jsonDecode(json);
      
      // 1時間で期限切れ
      final timestamp = DateTime.parse(data['timestamp']);
      if (DateTime.now().difference(timestamp).inHours > 1) {
        await file.delete();
        return null;
      }
      
      return data['value'] as T?;
    } catch (e) {
      return null;
    }
  }
  
  Future<void> set<T>(String key, T value) async {
    final cacheDir = await getTemporaryDirectory();
    final file = File('${cacheDir.path}/disk_cache/$key.json');
    
    final data = {
      'value': value,
      'timestamp': DateTime.now().toIso8601String(),
    };
    
    await file.writeAsString(jsonEncode(data));
  }
}
```

### 6.2 キャッシュ無効化戦略

```dart
// lib/core/cache/cache_invalidation.dart
@riverpod
class CacheInvalidation extends _$CacheInvalidation {
  @override
  void build() {}
  
  // ユーザー関連データのキャッシュ無効化
  void invalidateUserData(String userId) {
    final memoryCache = ref.read(memoryCacheProvider);
    final diskCache = ref.read(diskCacheProvider);
    
    // 関連するキャッシュキーの無効化
    final keys = [
      'user_profile_$userId',
      'user_posts_$userId',
      'user_products_$userId',
      'user_orders_$userId',
    ];
    
    for (final key in keys) {
      memoryCache.remove(key);
      diskCache.remove(key);
    }
  }
  
  // 投稿関連データのキャッシュ無効化
  void invalidatePostData(String postId) {
    final memoryCache = ref.read(memoryCacheProvider);
    final diskCache = ref.read(diskCacheProvider);
    
    final keys = [
      'post_$postId',
      'post_comments_$postId',
      'post_likes_$postId',
    ];
    
    for (final key in keys) {
      memoryCache.remove(key);
      diskCache.remove(key);
    }
  }
  
  // 全キャッシュのクリア
  Future<void> clearAllCaches() async {
    final memoryCache = ref.read(memoryCacheProvider);
    final diskCache = ref.read(diskCacheProvider);
    
    memoryCache.clear();
    await diskCache.clear();
  }
}
```

---

## 7. メモリ管理

### 7.1 メモリ監視

```dart
// lib/core/memory/memory_monitor.dart
@riverpod
class MemoryMonitor extends _$MemoryMonitor {
  Timer? _timer;
  
  @override
  MemoryInfo build() {
    return MemoryInfo(
      usedMemory: 0,
      totalMemory: 0,
      availableMemory: 0,
    );
  }
  
  void startMonitoring() {
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      _checkMemoryUsage();
    });
  }
  
  void stopMonitoring() {
    _timer?.cancel();
  }
  
  Future<void> _checkMemoryUsage() async {
    final memoryInfo = await _getMemoryInfo();
    state = memoryInfo;
    
    // メモリ使用量が80%を超えた場合の対策
    if (memoryInfo.usedMemory / memoryInfo.totalMemory > 0.8) {
      await _handleHighMemoryUsage();
    }
  }
  
  Future<MemoryInfo> _getMemoryInfo() async {
    // プラットフォーム固有のメモリ情報取得
    if (Platform.isAndroid) {
      return await _getAndroidMemoryInfo();
    } else if (Platform.isIOS) {
      return await _getIOSMemoryInfo();
    }
    
    return MemoryInfo(
      usedMemory: 0,
      totalMemory: 0,
      availableMemory: 0,
    );
  }
  
  Future<void> _handleHighMemoryUsage() async {
    // メモリ使用量削減対策
    await _clearImageCache();
    await _clearUnusedData();
    await _forceGarbageCollection();
  }
  
  Future<void> _clearImageCache() async {
    // 画像キャッシュのクリア
    final imageCache = ref.read(imageCacheManagerProvider);
    await imageCache.manageCacheSize();
  }
  
  Future<void> _clearUnusedData() async {
    // 未使用データのクリア
    final memoryCache = ref.read(memoryCacheProvider);
    memoryCache.clearOldEntries();
  }
  
  Future<void> _forceGarbageCollection() async {
    // ガベージコレクションの強制実行
    // Flutterでは自動的に管理されるため、主にメモリ使用量の監視のみ
  }
}

@freezed
class MemoryInfo with _$MemoryInfo {
  const factory MemoryInfo({
    required int usedMemory,
    required int totalMemory,
    required int availableMemory,
  }) = _MemoryInfo;
}
```

### 7.2 メモリリーク防止

```dart
// lib/core/memory/memory_leak_prevention.dart
class MemoryLeakPrevention {
  // ウィジェットの適切な破棄
  static void disposeWidgets(List<ChangeNotifier> notifiers) {
    for (final notifier in notifiers) {
      notifier.dispose();
    }
  }
  
  // ストリームの適切な購読解除
  static void cancelSubscriptions(List<StreamSubscription> subscriptions) {
    for (final subscription in subscriptions) {
      subscription.cancel();
    }
  }
  
  // タイマーの適切なキャンセル
  static void cancelTimers(List<Timer> timers) {
    for (final timer in timers) {
      timer.cancel();
    }
  }
}

// メモリリーク検出
class MemoryLeakDetector {
  static final Map<String, int> _instanceCounts = {};
  
  static void trackInstance(String className) {
    _instanceCounts[className] = (_instanceCounts[className] ?? 0) + 1;
  }
  
  static void untrackInstance(String className) {
    _instanceCounts[className] = (_instanceCounts[className] ?? 1) - 1;
  }
  
  static void reportLeaks() {
    _instanceCounts.forEach((className, count) {
      if (count > 0) {
        print('Potential memory leak detected: $className has $count instances');
      }
    });
  }
}
```

---

## 8. バッテリー最適化

### 8.1 バッテリー監視

```dart
// lib/core/battery/battery_monitor.dart
@riverpod
class BatteryMonitor extends _$BatteryMonitor {
  @override
  BatteryInfo build() {
    return BatteryInfo(
      level: 100,
      isCharging: false,
      isLowPowerMode: false,
    );
  }
  
  Future<void> startMonitoring() async {
    // バッテリー状態の監視
    Battery.batteryStateStream.listen((BatteryState state) {
      _updateBatteryState(state);
    });
    
    // バッテリーレベルの監視
    Battery.batteryLevelStream.listen((int level) {
      _updateBatteryLevel(level);
    });
  }
  
  void _updateBatteryState(BatteryState state) {
    state = state.copyWith(
      isCharging: state == BatteryState.charging,
    );
  }
  
  void _updateBatteryLevel(int level) {
    state = state.copyWith(level: level);
    
    // バッテリーレベルに応じた設定調整
    _adjustSettingsForBatteryLevel(level);
  }
  
  void _adjustSettingsForBatteryLevel(int level) {
    if (level < 20) {
      // 低バッテリー時の設定
      _setLowBatterySettings();
    } else if (level < 50) {
      // 中バッテリー時の設定
      _setMediumBatterySettings();
    } else {
      // 高バッテリー時の設定
      _setHighBatterySettings();
    }
  }
  
  void _setLowBatterySettings() {
    // 低バッテリー時の最適化
    ref.read(imageQualityProvider.notifier).state = ImageQuality.low;
    ref.read(videoQualityProvider.notifier).state = VideoQuality.low;
    ref.read(backgroundSyncProvider.notifier).state = false;
    ref.read(pushNotificationProvider.notifier).state = false;
  }
  
  void _setMediumBatterySettings() {
    // 中バッテリー時の設定
    ref.read(imageQualityProvider.notifier).state = ImageQuality.medium;
    ref.read(videoQualityProvider.notifier).state = VideoQuality.medium;
    ref.read(backgroundSyncProvider.notifier).state = true;
    ref.read(pushNotificationProvider.notifier).state = true;
  }
  
  void _setHighBatterySettings() {
    // 高バッテリー時の設定
    ref.read(imageQualityProvider.notifier).state = ImageQuality.high;
    ref.read(videoQualityProvider.notifier).state = VideoQuality.high;
    ref.read(backgroundSyncProvider.notifier).state = true;
    ref.read(pushNotificationProvider.notifier).state = true;
  }
}

@freezed
class BatteryInfo with _$BatteryInfo {
  const factory BatteryInfo({
    required int level,
    required bool isCharging,
    required bool isLowPowerMode,
  }) = _BatteryInfo;
}
```

### 8.2 省電力設定

```dart
// lib/core/battery/power_optimization.dart
class PowerOptimization {
  // バックグラウンド処理の最適化
  static void optimizeBackgroundTasks() {
    // バックグラウンド処理の間隔調整
    final batteryLevel = ref.read(batteryMonitorProvider).level;
    
    if (batteryLevel < 20) {
      // 低バッテリー時は処理を最小限に
      ref.read(backgroundSyncProvider.notifier).state = false;
      ref.read(pushNotificationProvider.notifier).state = false;
    } else if (batteryLevel < 50) {
      // 中バッテリー時は処理を減らす
      ref.read(backgroundSyncProvider.notifier).state = true;
      ref.read(pushNotificationProvider.notifier).state = true;
    }
  }
  
  // ネットワーク使用量の最適化
  static void optimizeNetworkUsage() {
    final batteryLevel = ref.read(batteryMonitorProvider).level;
    
    if (batteryLevel < 30) {
      // 低バッテリー時はネットワーク使用を最小限に
      ref.read(imageQualityProvider.notifier).state = ImageQuality.low;
      ref.read(videoQualityProvider.notifier).state = VideoQuality.low;
      ref.read(autoPlayVideosProvider.notifier).state = false;
    }
  }
  
  // 画面表示の最適化
  static void optimizeDisplay() {
    final batteryLevel = ref.read(batteryMonitorProvider).level;
    
    if (batteryLevel < 15) {
      // 非常に低いバッテリー時は画面表示を最適化
      ref.read(animationQualityProvider.notifier).state = AnimationQuality.low;
      ref.read(backgroundBlurProvider.notifier).state = false;
    }
  }
}
```

---

## 9. 監視・分析

### 9.1 パフォーマンス監視

```dart
// lib/core/monitoring/performance_monitor.dart
@riverpod
class PerformanceMonitor extends _$PerformanceMonitor {
  @override
  void build() {}
  
  // パフォーマンス指標の記録
  void recordMetric(String name, dynamic value, {Map<String, dynamic>? tags}) {
    // Firebase Analytics への送信
    ref.read(analyticsServiceProvider).logEvent(
      'performance_metric',
      parameters: {
        'metric_name': name,
        'metric_value': value.toString(),
        'timestamp': DateTime.now().toIso8601String(),
        ...?tags,
      },
    );
    
    // ローカルログ
    print('Performance Metric: $name = $value');
  }
  
  // 画面遷移時間の測定
  void recordScreenTransition(String fromScreen, String toScreen, Duration duration) {
    recordMetric(
      'screen_transition_time',
      duration.inMilliseconds,
      tags: {
        'from_screen': fromScreen,
        'to_screen': toScreen,
      },
    );
  }
  
  // API呼び出し時間の測定
  void recordApiCall(String endpoint, Duration duration, {bool isSuccess = true}) {
    recordMetric(
      'api_call_time',
      duration.inMilliseconds,
      tags: {
        'endpoint': endpoint,
        'success': isSuccess.toString(),
      },
    );
  }
  
  // メモリ使用量の記録
  void recordMemoryUsage(int usedMemory, int totalMemory) {
    recordMetric(
      'memory_usage',
      (usedMemory / totalMemory * 100).round(),
      tags: {
        'used_memory_mb': (usedMemory / 1024 / 1024).round(),
        'total_memory_mb': (totalMemory / 1024 / 1024).round(),
      },
    );
  }
}
```

### 9.2 パフォーマンス分析

```dart
// lib/core/analysis/performance_analyzer.dart
class PerformanceAnalyzer {
  // パフォーマンス問題の検出
  static void analyzePerformanceIssues(List<PerformanceMetric> metrics) {
    // 応答時間の異常値検出
    final responseTimeMetrics = metrics
        .where((m) => m.name == 'api_call_time')
        .toList();
    
    final avgResponseTime = responseTimeMetrics
        .map((m) => m.value as int)
        .reduce((a, b) => a + b) / responseTimeMetrics.length;
    
    if (avgResponseTime > 5000) { // 5秒以上
      print('Warning: High average API response time: ${avgResponseTime}ms');
    }
    
    // メモリ使用量の異常値検出
    final memoryMetrics = metrics
        .where((m) => m.name == 'memory_usage')
        .toList();
    
    final recentMemoryUsage = memoryMetrics
        .where((m) => DateTime.now().difference(m.timestamp).inMinutes < 10)
        .map((m) => m.value as int)
        .toList();
    
    if (recentMemoryUsage.isNotEmpty) {
      final avgMemoryUsage = recentMemoryUsage.reduce((a, b) => a + b) / recentMemoryUsage.length;
      
      if (avgMemoryUsage > 80) { // 80%以上
        print('Warning: High memory usage: ${avgMemoryUsage}%');
      }
    }
  }
  
  // パフォーマンス改善提案
  static List<String> generateImprovementSuggestions(List<PerformanceMetric> metrics) {
    final suggestions = <String>[];
    
    // API応答時間の改善提案
    final slowApiCalls = metrics
        .where((m) => m.name == 'api_call_time' && (m.value as int) > 3000)
        .toList();
    
    if (slowApiCalls.isNotEmpty) {
      suggestions.add('Consider implementing caching for slow API endpoints');
      suggestions.add('Optimize database queries for frequently called APIs');
    }
    
    // メモリ使用量の改善提案
    final highMemoryUsage = metrics
        .where((m) => m.name == 'memory_usage' && (m.value as int) > 70)
        .toList();
    
    if (highMemoryUsage.isNotEmpty) {
      suggestions.add('Implement image compression and caching strategies');
      suggestions.add('Review memory leaks in long-running operations');
    }
    
    return suggestions;
  }
}

@freezed
class PerformanceMetric with _$PerformanceMetric {
  const factory PerformanceMetric({
    required String name,
    required dynamic value,
    required DateTime timestamp,
    Map<String, dynamic>? tags,
  }) = _PerformanceMetric;
}
```

---

## まとめ

このパフォーマンス設計書は、SNS統合ECアプリケーションの性能最適化を包括的に定義しています。各性能要件を満たすための具体的な実装方針と監視方法を提供しています。

パフォーマンスは継続的に監視・改善し、ユーザー体験の向上を図ってください。