# SNS 統合 EC アプリケーション 実装計画書

ドキュメントバージョン: 1.0  
作成日: 2025 年 1 月 21 日  
更新日: 2025 年 1 月 21 日

## 目次

1. [実装概要](#1-実装概要)
2. [フェーズ1: 基盤構築](#2-フェーズ1-基盤構築)
3. [フェーズ2: SNS機能](#3-フェーズ2-sns機能)
4. [フェーズ3: EC機能](#4-フェーズ3-ec機能)
5. [フェーズ4: QRチケット](#5-フェーズ4-qrチケット)
6. [実装ガイドライン](#6-実装ガイドライン)
7. [品質保証](#7-品質保証)

---

## 1. 実装概要

### 1.1 実装方針

- **段階的実装**: 機能ごとに段階的に実装・テスト
- **品質重視**: 各フェーズで品質ゲートを設定
- **継続的統合**: CI/CDによる自動化
- **ドキュメント整備**: 実装と並行してドキュメント更新

### 1.2 実装順序

```
フェーズ1: 基盤構築 (2ヶ月)
├── プロジェクト環境構築
├── アーキテクチャ実装
├── 認証機能
└── ユーザー管理機能

フェーズ2: SNS機能 (2ヶ月)
├── 投稿機能
├── メディアアップロード
├── フォロー・フォロワー
├── コメント・いいね
├── 検索機能
└── 通知機能

フェーズ3: EC機能 (2ヶ月)
├── 商品管理
├── Stripe決済統合
├── 注文管理
├── 在庫管理
├── 売上管理
└── 返金・キャンセル

フェーズ4: QRチケット (1ヶ月)
├── QRチケット生成
├── チケット検証
├── イベント管理
└── PDF出力
```

---

## 2. フェーズ1: 基盤構築

### 2.1 週1-2: プロジェクト環境構築

#### 2.1.1 開発環境セットアップ

```bash
# 1. Flutter環境構築
flutter doctor
flutter create tliny_v2
cd tliny_v2

# 2. 依存関係追加
flutter pub add riverpod
flutter pub add riverpod_annotation
flutter pub add freezed_annotation
flutter pub add go_router
flutter pub add firebase_core
flutter pub add firebase_auth
flutter pub add cloud_firestore
flutter pub add firebase_storage
flutter pub add firebase_functions

# 3. 開発用依存関係
flutter pub add --dev build_runner
flutter pub add --dev riverpod_generator
flutter pub add --dev freezed
flutter pub add --dev json_annotation
flutter pub add --dev json_serializable
```

#### 2.1.2 ディレクトリ構造作成

```
lib/
├── main.dart
├── core/
│   ├── config/
│   ├── constants/
│   ├── di/
│   ├── exceptions/
│   ├── utils/
│   ├── router/
│   └── services/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   └── usecases/
├── presentation/
│   ├── viewmodels/
│   ├── screens/
│   └── widgets/
└── features/
    ├── auth/
    ├── user/
    ├── post/
    ├── product/
    └── order/
```

### 2.2 週3-4: アーキテクチャ実装

#### 2.2.1 Riverpod設定

```dart
// lib/core/di/app_providers.dart
import 'package:riverpod/riverpod.dart';

final appProviders = ProviderContainer();

// アプリケーション全体のプロバイダー設定
final appConfigProvider = Provider<AppConfig>((ref) {
  return AppConfig(
    apiBaseUrl: 'https://api.example.com',
    environment: Environment.development,
  );
});
```

#### 2.2.2 ルーティング設定

```dart
// lib/core/router/app_router.dart
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => ProfileScreen(),
        ),
      ],
    ),
  ],
);
```

### 2.3 週5-7: 認証機能実装

#### 2.3.1 認証エンティティ

```dart
// lib/domain/entities/auth/user.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String displayName,
    required String accountType,
    required bool isEmailVerified,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

#### 2.3.2 認証リポジトリ

```dart
// lib/data/repositories/auth_repository_impl.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_impl.g.dart';

@riverpod
class AuthRepository extends _$AuthRepository {
  @override
  Future<User?> build() async {
    return _getCurrentUser();
  }

  Future<User?> _getCurrentUser() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return null;

    return User(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName ?? '',
      accountType: 'personal', // デフォルト
      isEmailVerified: firebaseUser.emailVerified,
    );
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String displayName,
    required String accountType,
  }) async {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await credential.user?.updateDisplayName(displayName);
    return credential;
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
```

### 2.4 週8-10: ユーザー管理機能

#### 2.4.1 ユーザープロフィール機能

```dart
// lib/features/user/data/models/user_profile_model.dart
@freezed
class UserProfileModel with _$UserProfileModel {
  const factory UserProfileModel({
    required String id,
    required String displayName,
    required String accountType,
    String? bio,
    String? profileImageUrl,
    String? coverImageUrl,
    Map<String, dynamic>? socialLinks,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);
}
```

---

## 3. フェーズ2: SNS機能

### 3.1 週11-13: 投稿機能実装

#### 3.1.1 投稿エンティティ

```dart
// lib/domain/entities/post/post.dart
@freezed
class Post with _$Post {
  const factory Post({
    required String id,
    required String userId,
    required String content,
    @Default([]) List<String> imageUrls,
    @Default([]) List<String> videoUrls,
    @Default(0) int likeCount,
    @Default(0) int commentCount,
    @Default(0) int shareCount,
    @Default([]) List<String> tags,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
```

#### 3.1.2 投稿作成画面

```dart
// lib/features/post/presentation/screens/create_post_screen.dart
class CreatePostScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final _contentController = TextEditingController();
  final List<File> _selectedImages = [];
  final List<File> _selectedVideos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('投稿作成'),
        actions: [
          TextButton(
            onPressed: _createPost,
            child: Text('投稿'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildContentField(),
                  SizedBox(height: 16),
                  _buildMediaSection(),
                ],
              ),
            ),
          ),
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildContentField() {
    return TextField(
      controller: _contentController,
      decoration: InputDecoration(
        hintText: '何を考えていますか？',
        border: InputBorder.none,
      ),
      maxLines: null,
      maxLength: 1000,
    );
  }

  Future<void> _createPost() async {
    if (_contentController.text.trim().isEmpty) return;

    final postViewModel = ref.read(createPostViewModelProvider.notifier);
    await postViewModel.createPost(
      content: _contentController.text.trim(),
      images: _selectedImages,
      videos: _selectedVideos,
    );

    Navigator.pop(context);
  }
}
```

### 3.2 週14-16: メディアアップロード機能

#### 3.2.1 画像・動画アップロードサービス

```dart
// lib/core/services/media_upload_service.dart
@riverpod
class MediaUploadService extends _$MediaUploadService {
  @override
  void build() {}

  Future<List<String>> uploadImages(List<File> images) async {
    final urls = <String>[];
    
    for (final image in images) {
      final url = await _uploadImage(image);
      urls.add(url);
    }
    
    return urls;
  }

  Future<String> _uploadImage(File image) async {
    // 画像圧縮
    final compressedImage = await ImageOptimizer.compressImage(image);
    
    final fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final ref = FirebaseStorage.instance.ref().child(fileName);
    
    final uploadTask = ref.putFile(compressedImage);
    final snapshot = await uploadTask;
    
    return await snapshot.ref.getDownloadURL();
  }
}
```

### 3.3 週17-18: フォロー・フォロワー機能

#### 3.3.1 フォロー関係エンティティ

```dart
// lib/domain/entities/user/follow_relationship.dart
@freezed
class FollowRelationship with _$FollowRelationship {
  const factory FollowRelationship({
    required String id,
    required String followerId,
    required String followingId,
    required DateTime createdAt,
  }) = _FollowRelationship;

  factory FollowRelationship.fromJson(Map<String, dynamic> json) =>
      _$FollowRelationshipFromJson(json);
}
```

---

## 4. フェーズ3: EC機能

### 4.1 週19-21: 商品管理機能

#### 4.1.1 商品エンティティ

```dart
// lib/domain/entities/product/product.dart
@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String sellerId,
    required String name,
    required String description,
    required int price,
    required int stock,
    @Default([]) List<String> images,
    @Default([]) List<String> categories,
    @Default(true) bool isActive,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
```

#### 4.1.2 商品登録画面

```dart
// lib/features/product/presentation/screens/product_form_screen.dart
class ProductFormScreen extends ConsumerStatefulWidget {
  final Product? product; // 編集時のみ

  const ProductFormScreen({this.product});

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final List<File> _selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? '商品登録' : '商品編集'),
        actions: [
          TextButton(
            onPressed: _saveProduct,
            child: Text('保存'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            _buildImageSection(),
            SizedBox(height: 24),
            _buildNameField(),
            SizedBox(height: 16),
            _buildDescriptionField(),
            SizedBox(height: 16),
            _buildPriceField(),
            SizedBox(height: 16),
            _buildStockField(),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: '商品名',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '商品名を入力してください';
        }
        return null;
      },
    );
  }

  Future<void> _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      final productViewModel = ref.read(productFormViewModelProvider.notifier);
      
      if (widget.product == null) {
        await productViewModel.createProduct(
          name: _nameController.text,
          description: _descriptionController.text,
          price: int.parse(_priceController.text),
          stock: int.parse(_stockController.text),
          images: _selectedImages,
        );
      } else {
        await productViewModel.updateProduct(
          widget.product!.id,
          name: _nameController.text,
          description: _descriptionController.text,
          price: int.parse(_priceController.text),
          stock: int.parse(_stockController.text),
          images: _selectedImages,
        );
      }

      Navigator.pop(context);
    }
  }
}
```

### 4.2 週22-25: Stripe決済統合

#### 4.2.1 Stripe設定

```dart
// lib/core/config/stripe_config.dart
class StripeConfig {
  static const String publishableKey = 'pk_test_...';
  static const String secretKey = 'sk_test_...';
  
  static void initialize() {
    Stripe.publishableKey = publishableKey;
  }
}
```

#### 4.2.2 決済処理

```dart
// lib/core/services/payment_service.dart
@riverpod
class PaymentService extends _$PaymentService {
  @override
  void build() {}

  Future<PaymentIntent> createPaymentIntent({
    required int amount,
    required String currency,
    required String customerId,
  }) async {
    final functions = FirebaseFunctions.instance;
    final result = await functions.httpsCallable('createPaymentIntent').call({
      'amount': amount,
      'currency': currency,
      'customerId': customerId,
    });

    return PaymentIntent.fromJson(result.data);
  }

  Future<void> processPayment({
    required String paymentIntentId,
    required String paymentMethodId,
  }) async {
    final functions = FirebaseFunctions.instance;
    await functions.httpsCallable('confirmPayment').call({
      'paymentIntentId': paymentIntentId,
      'paymentMethodId': paymentMethodId,
    });
  }
}
```

---

## 5. フェーズ4: QRチケット

### 5.1 週26-27: QRチケット生成機能

#### 5.1.1 チケットエンティティ

```dart
// lib/domain/entities/ticket/ticket.dart
@freezed
class Ticket with _$Ticket {
  const factory Ticket({
    required String id,
    required String eventId,
    required String userId,
    required String ticketType,
    required int price,
    required DateTime eventDate,
    required TicketStatus status,
    String? qrCode,
    DateTime? usedAt,
    required DateTime createdAt,
  }) = _Ticket;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
}

enum TicketStatus {
  active,
  used,
  cancelled,
  expired,
}
```

#### 5.1.2 QRコード生成

```dart
// lib/core/services/qr_code_service.dart
@riverpod
class QRCodeService extends _$QRCodeService {
  @override
  void build() {}

  Future<String> generateQRCode(String ticketId) async {
    // QRコード生成処理
    final qrPainter = QrPainter(
      data: ticketId,
      version: QrVersions.auto,
      color: Colors.black,
      emptyColor: Colors.white,
    );

    final qrImage = await qrPainter.toImageData(2048);
    final bytes = qrImage!.buffer.asUint8List();
    
    // Base64エンコード
    return base64Encode(bytes);
  }
}
```

### 5.2 週28-29: チケット検証機能

#### 5.2.1 チケット検証画面

```dart
// lib/features/ticket/presentation/screens/ticket_verification_screen.dart
class TicketVerificationScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<TicketVerificationScreen> createState() => _TicketVerificationScreenState();
}

class _TicketVerificationScreenState extends ConsumerState<TicketVerificationScreen> {
  final _qrController = QrViewController();
  bool _isScanning = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('チケット検証')),
      body: Column(
        children: [
          Expanded(
            child: _isScanning ? _buildQRScanner() : _buildVerificationResult(),
          ),
        ],
      ),
    );
  }

  Widget _buildQRScanner() {
    return QrView(
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).primaryColor,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: 300,
      ),
    );
  }

  void _onQRViewCreated(QrViewController controller) {
    _qrController = controller;
    _qrController.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        _verifyTicket(scanData.code!);
      }
    });
  }

  Future<void> _verifyTicket(String ticketId) async {
    setState(() => _isScanning = false);
    
    try {
      final ticketService = ref.read(ticketServiceProvider.notifier);
      await ticketService.verifyTicket(ticketId);
    } catch (e) {
      // エラーハンドリング
    }
  }
}
```

---

## 6. 実装ガイドライン

### 6.1 コーディング規約

#### 6.1.1 命名規則
- **クラス名**: PascalCase (例: `UserProfile`)
- **変数名**: camelCase (例: `userName`)
- **定数名**: SCREAMING_SNAKE_CASE (例: `API_BASE_URL`)
- **ファイル名**: snake_case (例: `user_profile_screen.dart`)

#### 6.1.2 ディレクトリ構造
```
features/
├── auth/
│   ├── data/
│   │   ├── models/
│   │   └── repositories/
│   ├── domain/
│   │   ├── entities/
│   │   └── usecases/
│   └── presentation/
│       ├── screens/
│       ├── widgets/
│       └── viewmodels/
```

### 6.2 テスト実装

#### 6.2.1 単体テスト
```dart
// test/domain/usecases/auth/authenticate_user_usecase_test.dart
void main() {
  group('AuthenticateUserUseCase', () {
    late AuthenticateUserUseCase useCase;
    late MockAuthRepository mockRepository;

    setUp(() {
      mockRepository = MockAuthRepository();
      useCase = AuthenticateUserUseCase(mockRepository);
    });

    test('should return User when authentication is successful', () async {
      // Arrange
      final email = 'test@example.com';
      final password = 'password123';
      final expectedUser = User(id: '1', email: email);

      when(mockRepository.authenticate(email, password))
          .thenAnswer((_) async => expectedUser);

      // Act
      final result = await useCase.execute(email, password);

      // Assert
      expect(result, equals(expectedUser));
      verify(mockRepository.authenticate(email, password)).called(1);
    });
  });
}
```

### 6.3 エラーハンドリング

#### 6.3.1 統一的なエラーハンドリング
```dart
// lib/core/utils/error_handler.dart
class ErrorHandler {
  static void handleError(BuildContext context, Object error) {
    String message;
    
    if (error is NetworkException) {
      message = 'ネットワークエラーが発生しました';
    } else if (error is AuthException) {
      message = '認証エラーが発生しました';
    } else if (error is ValidationException) {
      message = error.message;
    } else {
      message = '予期しないエラーが発生しました';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
```

---

## 7. 品質保証

### 7.1 品質ゲート

#### 7.1.1 コードレビュー
- **必須レビュー**: 全コード
- **レビュー担当**: シニア開発者
- **レビュー項目**: 機能・性能・セキュリティ・可読性

#### 7.1.2 テスト要件
- **単体テスト**: 全機能の80%以上カバレッジ
- **統合テスト**: 主要機能の動作確認
- **E2Eテスト**: 重要フローの動作確認

#### 7.1.3 パフォーマンス要件
- **起動時間**: 5秒以内
- **画面遷移**: 1秒以内
- **API応答**: 3秒以内

### 7.2 CI/CDパイプライン

```yaml
# .github/workflows/ci.yml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
      - run: flutter pub get
      - run: flutter test --coverage
      - uses: codecov/codecov-action@v3
        with:
          file: coverage/lcov.info

  build:
    runs-on: ubuntu-latest
    needs: test
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
      - run: flutter build apk
      - run: flutter build ios --release --no-codesign
```

---

## まとめ

この実装計画書は、SNS統合ECアプリケーションの段階的な実装を詳細に定義しています。各フェーズでの具体的なタスク、実装例、品質保証の仕組みを提供しています。

計画に従って実装を進め、定期的なレビューと調整を行い、高品質なアプリケーションを構築してください。