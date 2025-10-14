<!-- Inclusion Mode: Always -->

# 技術スタックと運用方針

## アーキテクチャ
- フロント: Flutter Web（MVVM + Repository、Riverpod Generator、Freezed、GoRouter）
- バックエンド: Firebase（Firestore/Auth/Storage/Functions/Analytics/Hosting）
- サーバー処理: Cloud Functions for Firebase（TypeScript、Node 20）
- 決済: Stripe（Functions 経由で秘密鍵使用、Webhook 検証必須）

## ディレクトリ指針（抜粋）
- `lib/src/` に Presentation/Data/Domain 構成を整理
- `functions/src/v1|v2/` に機能別（stripe/firestore/method 等）を配置
- 生成物（`.g.dart` 等）は Git 管理外

## コーディング規約（要点）
- DRY/KISS/可読性優先、命名: PascalCase（型）/camelCase（変数・関数）/snake_case（ファイル）
- Riverpod: `@riverpod` を優先、`build_runner watch` 常時起動
- 例外: 層ごとに AppException へ変換し UI へ一貫提示
- Freezed で不変データ、GoRouter は名前付きルート/redirect

## セキュリティ
- Stripe 秘密鍵は Functions のみ使用（環境変数/Secret Manager）
- Firestore/Storage ルールの厳格化、必要最小権限
- Webhook 署名検証必須、入力値はクライアント/サーバ両面で検証

## パフォーマンス
- クエリ最適化（select/limit/orderBy/indexes）
- 画像最適化（WebP/圧縮）、Lazy Load
- Flutter Web レンダラーとビルド設定の最適化

## 共通コマンド
- Flutter: `flutter pub get` / `flutter run -d chrome` / `flutter build web --release`
- 生成: `flutter pub run build_runner watch`
- Functions: `npm i` / `npm run serve` / `npm run deploy`

## 環境変数（例）
- Flutter: `STRIPE_PUBLISHABLE_KEY`, Firebase 設定, `FLAVOR`
- Functions: `STRIPE_SECRET_KEY`, `STRIPE_WEBHOOK_SECRET`, `FIREBASE_PROJECT_ID`

## ログ/観測
- Crashlytics/Performance/Functions logs を活用、重大エラーの通知連携検討
