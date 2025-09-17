# Claude AI Assistant Setup

## 概要

このリポジトリには、GitHubのIssueで`@claude`とメンションすると自動的にClaudeが応答するワークフローが設定されています。

## セットアップ手順

### 1. 必要なSecretsの設定

GitHubリポジトリの Settings → Secrets and variables → Actions で以下を設定：

**必須Secrets:**

- `FIREBASE_TOKEN` - Firebase CLI用
- `ANTHROPIC_API_KEY` - マルチエージェント用

**Firebase Tokenの取得:**

```bash
firebase login:ci
```

### 2. ワークフローの有効化

以下のワークフローファイルが設定されています：

- `.github/workflows/ci.yml` - プルリクエスト用CI
- `.github/workflows/deploy.yml` - デプロイ用
- `.github/workflows/security.yml` - セキュリティチェック
- `.github/workflows/release.yml` - リリース管理
- `.github/workflows/multi-agent-collaboration.yml` - マルチエージェント協働
- `.github/workflows/firebase-hosting-merge.yml` - Firebase Hosting用

## 使用方法

### 基本的な質問・相談

Issueまたはコメントで `@claude` とメンションしてください：

```
@claude この機能の実装方法を教えて
```

### 自動実装の依頼

Issueに `auto-implement` ラベルを付けて `@claude` をメンションすると、自動的にPRを作成します：

```
@claude この機能を実装してください
```

## 機能

### 1. 質問応答モード

- `@claude`メンションで質問すると回答をコメントで返す
- 技術的な質問、実装方法、デバッグ支援など

### 2. 自動実装モード

- `auto-implement`ラベルがついたIssueで実行
- コードの分析、実装、PRの自動作成
- ドラフトPRとして作成されるため、レビュー必須

## 制限事項

- Claude APIのレート制限に従います
- 生成されたコードは必ずレビューしてください
- 複雑な実装は複数回に分けて依頼することを推奨

## トラブルシューティング

### API Keyエラー

- `ANTHROPIC_API_KEY`シークレットが正しく設定されているか確認
- API Keyが有効で残高があるか確認

### ワークフローが実行されない

- `@claude`メンションが正しく含まれているか確認
- GitHubのワークフロー権限設定を確認

### 生成されたコードが期待と異なる

- より具体的な指示を含めて再依頼
- 既存のコードパターンを参照するよう明示

## セキュリティ

- API Keyは必ずGitHub Secretsで管理
- 生成されたコードは必ずレビューしてからマージ
- 機密情報を含むIssueでの使用は避ける

## サポート

問題がある場合は、以下の情報を含めてIssueを作成してください：

- 実行したコマンド/メンション
- 期待した動作
- 実際の動作
- ワークフローのログ
