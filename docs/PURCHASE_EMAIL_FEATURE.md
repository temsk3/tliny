# 購入完了時のメール送信機能

## 概要

Stripe の決済完了時に自動でメールを送信する機能を実装しました。

## 実装方法

### 1. カスタムメール送信機能（推奨）

Firebase Functions + Nodemailer を使用したカスタムメール送信機能を実装しました。

#### 実装ファイル

- `functions/src/utils/email_service.ts` - メール送信サービス
- `functions/src/v1/stripe/webhook.ts` - Webhook 処理にメール送信を統合

#### 機能

- 購入完了時に HTML 形式の美しいメールを送信
- 注文詳細（注文番号、日時、合計金額）を含む
- メール送信ログを Firestore に記録
- エラーハンドリング（メール送信失敗時も決済処理は続行）

#### 設定方法

1. Gmail アカウントの準備（2 段階認証 + アプリパスワード）
2. Firebase Functions 環境変数の設定
3. ローカル開発時の`.env`ファイル設定

詳細は `functions/EMAIL_SETUP.md` を参照してください。

### 2. Stripe の組み込みメール機能

Stripe ダッシュボードで設定可能な組み込みメール機能も利用できます。

#### 設定方法

1. Stripe ダッシュボードにログイン
2. Settings → Emails → Receipts
3. メールテンプレートをカスタマイズ
4. 自動送信を有効化

## 送信タイミング

以下の Stripe Webhook イベントでメールが送信されます：

- `checkout.session.completed` - 決済完了時
- `checkout.session.async_payment_succeeded` - 非同期決済成功時

## メール内容

- 購入完了のお知らせ
- 注文番号
- 注文日時
- 合計金額（日本円表示）
- ブランディングされた HTML テンプレート

## セキュリティ

- Gmail アプリパスワードは環境変数で安全に管理
- メール送信失敗時も決済処理は継続
- 送信ログは Firestore に記録され監査可能

## トラブルシューティング

- メール送信エラーは Firebase Functions ログで確認可能
- `email_logs`コレクションで送信履歴を確認
- 環境変数の設定状況を確認

## 今後の拡張

- 多言語対応
- メールテンプレートのカスタマイズ機能
- メール配信状況の追跡
- 専用メールサービス（SendGrid、Mailgun 等）への移行
