<!-- Inclusion Mode: Always -->

# プロジェクト構造と設計原則

## ルート構成（要約）
- `lib/` Flutter アプリ本体（MVVM+Repository）
- `functions/` Cloud Functions（TypeScript, Node 20）
- `assets/` 画像・フォント・静的ファイル
- `docs/` 設計/テスト/実装計画
- `test/` unit/widget/integration/e2e（Playwright 併用）

## Flutter 構造（例）
- `lib/src/data/` model（Freezed）/repository
- `lib/src/presentation/` UI（Widget）, ViewModel（Notifier/AsyncNotifier）
- `lib/src/settings/` routes/theme/hooks
- `lib/src/utils/` 汎用

## Functions 構造（例）
- `functions/src/v1/stripe|firestore|method` 各機能
- `functions/src/utils/` 共通ユーティリティ
- `functions/tsconfig.json` は `src/v1|v2|utils` を include

## パターン
- 依存方向: Presentation → Domain/UseCase → Repository → DataSource
- Stream を継続更新に優先、単発は Future
- ルーティングは GoRouter の名前付きルートと `redirect`

## 命名・ファイル規約
- 型: PascalCase、関数/変数: camelCase、ファイル: snake_case
- Provider は `@riverpod` で自動生成（Family は引数で）

## テスト配置
- `test/unit|widget|integration|playwright` に分類
- 重要フロー（登録/決済/QR 受け渡し）は e2e を優先

## 運用
- 生成物は Git 管理外（`.g.dart` 等）
- CI/CD（将来）で `analyze/test/build/deploy` を自動化
