# メール送信機能のセットアップ

## 概要

購入処理完了時に自動でメールを送信する機能を実装しました。

## 必要な設定

### 1. Gmailアカウントの準備

1. Gmailアカウントを作成または使用
2. 2段階認証を有効にする
3. アプリパスワードを生成する
   - Googleアカウント設定 → セキュリティ → 2段階認証 → アプリパスワード

### 2. Firebase Functions環境変数の設定

```bash
# メール送信用の環境変数を設定
firebase functions:config:set email.user="your-email@gmail.com"
firebase functions:config:set email.password="your-app-password"
firebase functions:config:set email.from="noreply@tliny.com"
```

### 3. ローカル開発時の環境変数設定

`.env`ファイルを作成し、以下の内容を追加：

```env
EMAIL_USER=your-email@gmail.com
EMAIL_PASSWORD=your-app-password
EMAIL_FROM=noreply@tliny.com
```

## 機能詳細

### 送信されるメール

- **タイミング**: Stripeの決済完了時（`checkout.session.completed`、`checkout.session.async_payment_succeeded`）
- **内容**: 購入完了通知、注文詳細、合計金額
- **形式**: HTML形式の美しいテンプレート

### メールログ

- 送信試行は`email_logs`コレクションに記録されます
- 成功/失敗の履歴を確認できます

## トラブルシューティング

### よくある問題

1. **認証エラー**: Gmailのアプリパスワードが正しく設定されているか確認
2. **送信失敗**: ファイアウォールやネットワーク設定を確認
3. **環境変数未設定**: Firebase Functionsの環境変数が正しく設定されているか確認

### ログの確認

```bash
firebase functions:log
```

## セキュリティ注意事項

- Gmailのアプリパスワードは機密情報です
- 環境変数として安全に管理してください
- 本番環境では専用のメールサービス（SendGrid、Mailgun等）の使用を推奨
