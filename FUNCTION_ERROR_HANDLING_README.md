# ファンクション側エラーハンドリングの使用方法

## 概要

ファンクション側で発生したエラーを適切にアラートダイアログで表示するための実装が完了しました。

## 実装内容

### 1. エラー型の拡張

- `CloudFunctionsException`クラスを追加
- FirebaseFunctionsException の詳細情報を適切に処理

### 2. エラーハンドラーの強化

- FirebaseFunctionsException の専用処理を追加
- エラーコードに基づいた適切なメッセージ表示
- 詳細情報のダイアログ表示

### 3. Repository 層の改善

- `BaseRepository`クラスで共通エラーハンドリング
- FirebaseFunctionsException を AppException に変換

### 4. ViewModel 層のユーティリティ

- `ViewModelErrorHandler`で統一されたエラーハンドリング
- `ViewModelErrorHandlingMixin`で簡単な実装

## 使用方法

### Repository 層での使用

```dart
class MyRepository extends BaseRepository {
  @override
  FirebaseFunctions getFunctions() => _func;

  Future<void> callMyFunction() async {
    // エラーハンドリングは自動的に処理されます
    await callFunction<void>(
      'my_function_name',
      {'param': 'value'},
      context: 'callMyFunction',
    );
  }
}
```

### ViewModel 層での使用

```dart
@riverpod
class MyViewModel extends AsyncNotifier<void> with ViewModelErrorHandlingMixin {
  @override
  Future<void> build() async {
    // 初期化処理
  }

  Future<void> executeWithErrorHandling(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    await executeWithErrorHandling(
      context,
      () async {
        // ファンクション呼び出し
        final repository = ref.read(myRepositoryProvider);
        await repository.callMyFunction();
      },
      errorContext: 'my_function_call',
      onRetry: () => executeWithErrorHandling(context),
      l10n: l10n,
    );
  }
}
```

### AsyncValue での使用

```dart
// エラーをダイアログで表示
asyncValue.handleErrorWithDialog(
  context,
  errorContext: 'my_operation',
  title: 'エラーが発生しました',
  onRetry: () => retryOperation(),
  l10n: l10n,
);
```

## エラー表示の種類

### 1. スナックバー表示（軽微なエラー）

- ネットワークエラー
- タイムアウトエラー
- バリデーションエラー
- 認証エラー

### 2. ダイアログ表示（重要なエラー）

- 権限エラー
- 在庫不足エラー
- データベースエラー
- 決済エラー
- サーバーエラー
- Cloud Functions エラー

## エラーコード対応

| エラーコード      | 表示メッセージ                             | 表示方法     |
| ----------------- | ------------------------------------------ | ------------ |
| unauthenticated   | 認証が必要です。再度ログインしてください。 | ダイアログ   |
| permission-denied | この操作を実行する権限がありません。       | ダイアログ   |
| not-found         | リクエストされたリソースが見つかりません。 | ダイアログ   |
| internal          | サーバー内部エラーが発生しました。         | ダイアログ   |
| unavailable       | サービスが一時的に利用できません。         | ダイアログ   |
| timeout           | リクエストがタイムアウトしました。         | スナックバー |

## 特徴

1. **統一されたエラーハンドリング**: アプリ全体で一貫したエラー処理
2. **適切な表示方法**: エラーの重要度に応じた表示方法の選択
3. **詳細なログ記録**: デバッグに必要な情報を詳細に記録
4. **リトライ機能**: ユーザーが簡単に操作を再試行可能
5. **多言語対応**: ローカライゼーションに対応
6. **型安全性**: 型安全なエラーハンドリング

## 実装されたファイル

1. `lib/src/data/model/exception/app_exception.dart` - CloudFunctionsException クラス追加
2. `lib/src/ui/common/error_handler.dart` - FirebaseFunctionsException 処理強化
3. `lib/src/data/repository/base_repository.dart` - 共通エラーハンドリング
4. `lib/src/ui/common/view_model_error_handler.dart` - ViewModel 層ユーティリティ
5. `lib/src/data/repository/stripe_repository.dart` - BaseRepository 継承

これで、ファンクション側で発生したエラーが適切にアラートダイアログで表示されるようになりました。
