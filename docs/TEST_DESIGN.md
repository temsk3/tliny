# SNS 統合 EC アプリケーション テスト設計書

ドキュメントバージョン: 1.0  
作成日: 2025 年 1 月 21 日  
更新日: 2025 年 1 月 21 日

## 目次

1. [テスト戦略](#1-テスト戦略)
2. [テストピラミッド](#2-テストピラミッド)
3. [単体テスト](#3-単体テスト)
4. [統合テスト](#4-統合テスト)
5. [E2Eテスト](#5-e2eテスト)
6. [パフォーマンステスト](#6-パフォーマンステスト)
7. [セキュリティテスト](#7-セキュリティテスト)
8. [テスト自動化](#8-テスト自動化)
9. [テスト環境](#9-テスト環境)

---

## 1. テスト戦略

### 1.1 テスト方針

- **品質保証**: バグの早期発見と修正
- **回帰防止**: 既存機能の動作保証
- **開発効率**: 自動化による手動テスト削減
- **ユーザー体験**: エンドユーザー視点での品質確保

### 1.2 テスト対象

| 対象 | 説明 | 優先度 |
|------|------|--------|
| **認証機能** | ログイン・登録・権限管理 | 高 |
| **SNS機能** | 投稿・フォロー・コメント | 高 |
| **EC機能** | 商品管理・決済・注文 | 高 |
| **QRチケット** | チケット発行・検証 | 中 |
| **検索機能** | 全文検索・フィルタリング | 中 |
| **通知機能** | プッシュ通知・メール | 低 |

### 1.3 テスト指標

- **コードカバレッジ**: 80%以上
- **テスト実行時間**: 全体で10分以内
- **バグ検出率**: 本番環境での重大バグ0件
- **テスト成功率**: 95%以上

---

## 2. テストピラミッド

```
        E2E Tests (10%)
           /|\
          / | \
         /  |  \
    Integration Tests (20%)
       /|\
      / | \
     /  |  \
Unit Tests (70%)
```

### 2.1 各層の役割

1. **単体テスト (70%)**
   - 個別の関数・クラス・メソッド
   - 高速実行・高カバレッジ
   - 開発時の即座なフィードバック

2. **統合テスト (20%)**
   - コンポーネント間の連携
   - 外部サービスとの連携
   - データフローの検証

3. **E2Eテスト (10%)**
   - ユーザーシナリオの検証
   - 実際のブラウザ・デバイス
   - 重要なビジネスフロー

---

## 3. 単体テスト

### 3.1 テスト対象

#### 3.1.1 Domain Layer
- **UseCase**: ビジネスロジックの検証
- **Entity**: データ構造の検証
- **Value Objects**: 値オブジェクトの検証

#### 3.1.2 Data Layer
- **Repository**: データアクセスロジック
- **DataSource**: 外部API呼び出し
- **DTO**: データ変換ロジック

#### 3.1.3 Presentation Layer
- **ViewModel**: 状態管理ロジック
- **Widget**: UIロジック
- **Utils**: ユーティリティ関数

### 3.2 テスト実装例

```dart
// test/domain/usecases/auth/login_usecase_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:app/domain/usecases/auth/login_usecase.dart';
import 'package:app/domain/entities/auth/login_credentials.dart';
import 'package:app/domain/entities/auth/user.dart';

@GenerateMocks([AuthRepository])
import 'login_usecase_test.mocks.dart';

void main() {
  group('LoginUseCase', () {
    late LoginUseCase useCase;
    late MockAuthRepository mockRepository;

    setUp(() {
      mockRepository = MockAuthRepository();
      useCase = LoginUseCase(mockRepository);
    });

    group('execute', () {
      test('should return User when login is successful', () async {
        // Arrange
        final credentials = LoginCredentials(
          email: 'test@example.com',
          password: 'password123',
        );
        final expectedUser = User(
          id: 'user123',
          email: 'test@example.com',
          displayName: 'Test User',
        );

        when(mockRepository.login(credentials))
            .thenAnswer((_) async => expectedUser);

        // Act
        final result = await useCase.execute(credentials);

        // Assert
        expect(result, equals(expectedUser));
        verify(mockRepository.login(credentials)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('should throw AuthException when login fails', () async {
        // Arrange
        final credentials = LoginCredentials(
          email: 'test@example.com',
          password: 'wrongpassword',
        );

        when(mockRepository.login(credentials))
            .thenThrow(AuthException('Invalid credentials'));

        // Act & Assert
        expect(
          () => useCase.execute(credentials),
          throwsA(isA<AuthException>()),
        );
        verify(mockRepository.login(credentials)).called(1);
      });
    });
  });
}
```

---

## 4. 統合テスト

### 4.1 テスト対象

#### 4.1.1 Repository Integration
- **Firebase連携**: Firestore・Auth・Storage
- **Stripe連携**: 決済・Connect API
- **Algolia連携**: 検索API

#### 4.1.2 UseCase Integration
- **認証フロー**: ログイン→権限確認→画面遷移
- **投稿フロー**: 投稿作成→画像アップロード→通知
- **決済フロー**: 商品選択→決済→在庫更新

### 4.2 テスト実装例

```dart
// integration_test/auth_flow_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Authentication Flow', () {
    testWidgets('Complete login flow', (tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle();

      // Act - Navigate to login
      await tester.tap(find.byKey(Key('login_button')));
      await tester.pumpAndSettle();

      // Act - Enter credentials
      await tester.enterText(
        find.byKey(Key('email_field')),
        'test@example.com',
      );
      await tester.enterText(
        find.byKey(Key('password_field')),
        'password123',
      );

      // Act - Submit login
      await tester.tap(find.byKey(Key('submit_button')));
      await tester.pumpAndSettle();

      // Assert - Verify navigation to home
      expect(find.byKey(Key('home_screen')), findsOneWidget);
      expect(find.text('Welcome, Test User'), findsOneWidget);
    });
  });
}
```

---

## 5. E2Eテスト

### 5.1 テストシナリオ

#### 5.1.1 ユーザー登録・認証
1. **新規登録フロー**
   - アプリ起動
   - 新規登録画面遷移
   - 情報入力・送信
   - メール認証
   - ホーム画面表示

2. **ログインフロー**
   - ログイン画面表示
   - 認証情報入力
   - 認証成功
   - ホーム画面遷移

#### 5.1.2 SNS機能
1. **投稿作成フロー**
   - 投稿画面遷移
   - テキスト入力
   - 画像選択・アップロード
   - 投稿公開
   - フィード表示確認

#### 5.1.3 EC機能
1. **商品購入フロー**
   - 商品一覧表示
   - 商品詳細確認
   - カート追加
   - 決済処理
   - 注文完了

---

## 6. パフォーマンステスト

### 6.1 テスト項目

#### 6.1.1 アプリ起動時間
- **コールドスタート**: 5秒以内
- **ウォームスタート**: 2秒以内
- **ホットスタート**: 1秒以内

#### 6.1.2 画面遷移時間
- **画面表示**: 1秒以内
- **データ読み込み**: 3秒以内
- **画像表示**: 2秒以内

#### 6.1.3 メモリ使用量
- **通常使用時**: 100MB以下
- **画像表示時**: 200MB以下
- **長時間使用**: メモリリークなし

---

## 7. セキュリティテスト

### 7.1 テスト項目

#### 7.1.1 認証・認可
- **パスワード強度**: 適切な複雑性要求
- **セッション管理**: トークン有効期限・更新
- **権限チェック**: 適切なアクセス制御

#### 7.1.2 データ保護
- **暗号化**: 機密データの暗号化
- **データ漏洩**: 個人情報の適切な処理
- **入力検証**: XSS・SQLインジェクション対策

---

## 8. テスト自動化

### 8.1 CI/CD パイプライン

```yaml
# .github/workflows/test.yml
name: Test Pipeline

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  unit-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
          channel: 'stable'
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Run unit tests
        run: flutter test --coverage
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          file: coverage/lcov.info
```

---

## 9. テスト環境

### 9.1 環境構成

| 環境 | 用途 | データベース | 外部サービス |
|------|------|-------------|-------------|
| **開発** | 開発・デバッグ | Firebase Emulator | Stripe Test |
| **テスト** | 自動テスト実行 | Firebase Test | Stripe Test |
| **ステージング** | 結合テスト | Firebase Staging | Stripe Test |
| **本番** | 実際の運用 | Firebase Production | Stripe Live |

### 9.2 テスト実行コマンド

```bash
# 単体テスト実行
flutter test

# 統合テスト実行
flutter test integration_test/

# E2Eテスト実行
flutter test test/e2e/

# カバレッジ付きテスト実行
flutter test --coverage
```

---

## まとめ

このテスト設計書は、SNS統合ECアプリケーションの品質保証を包括的に定義しています。各テストレベルでの適切なテスト戦略を実装し、継続的な品質向上を図ってください。

テストは開発プロセスの一部として継続的に実行し、品質指標を定期的にレビューして改善を行ってください。