# TLINY Multi-Agent System

TLINYデジタルバザープラットフォーム用の専門化されたAIエージェント群による協調開発システムです。

## システム概要

6つの専門エージェントが連携し、複雑な開発タスクを効率的に完遂します：

### 🎭 Conductor Agent (統制エージェント)
- **役割**: 全体統制・タスク分散・進捗管理
- **ファイル**: `conductor-agent.md`
- **担当**: 要件分析、タスク分解、エージェント調整、品質保証

### ⚡ Firebase Functions Developer
- **役割**: Firebase Cloud Functions v2とバックエンドサービス
- **ファイル**: `firebase-functions-developer.md`
- **担当**: TypeScript関数、API、webhook、ビジネスロジック

### 🎨 Flutter UI Builder
- **役割**: Flutter UIコンポーネントと画面開発
- **ファイル**: `flutter-ui-builder.md`
- **担当**: Material Design 3、レスポンシブデザイン、ナビゲーション

### 🔄 Riverpod State Manager
- **役割**: 状態管理とデータフローアーキテクチャ
- **ファイル**: `riverpod-state-manager.md`
- **担当**: Provider実装、async状態、Repository統合

### 💳 Stripe Payment Integrator
- **役割**: 決済処理とStripe統合
- **ファイル**: `stripe-payment-integrator.md`
- **担当**: 決済API、webhook、セキュリティ、PCI準拠

### 🧪 Test Automation Engineer
- **役割**: テスト戦略とQA自動化
- **ファイル**: `test-automation-engineer.md`
- **担当**: 全種テスト、品質メトリクス、CI/CD統合

## 使用方法

### 1. Multi-Agent Taskの作成

GitHub Issueを以下の形式で作成：

```markdown
# [MULTI-AGENT] 新機能の実装

## 要件
- 機能の詳細説明
- 技術要件
- 制約事項

## 期待する成果物
- [ ] API仕様書
- [ ] UI設計
- [ ] 実装コード
- [ ] テストコード

@conductor-agent による分析をお願いします。
```

### 2. 自動タスク分解

Conductor Agentが要件を分析し：
- 関連技術ドメインを特定
- 専門エージェントへのタスク割り当て
- 依存関係グラフの作成
- 実行フェーズの計画

### 3. 並行開発実行

各専門エージェントが同時に作業：
- 独立したタスクの並行実行
- エージェント間の自動協調
- 品質ゲートでの統合確認

## ファイル構成

```
agents/
├── README.md                          # このファイル
├── conductor-agent.md                 # 統制エージェント設定
├── firebase-functions-developer.md    # Firebase専門エージェント
├── flutter-ui-builder.md             # Flutter UI専門エージェント
├── riverpod-state-manager.md         # Riverpod状態管理専門
├── stripe-payment-integrator.md      # Stripe決済専門エージェント
├── test-automation-engineer.md       # テスト自動化専門エージェント
├── agent-coordination-system.md      # システム全体設計書
└── workflow-examples.md              # 実際のワークフロー例
```

## 協調パターンの例

### 決済機能の実装
```
[要件] 新しい決済方法の追加

↓ Conductor Agent による分析

[Phase 1 並行実行]
├── Stripe Payment Integrator → 決済API実装
└── Firebase Functions Developer → webhook実装

[Phase 2]
└── Riverpod State Manager → 決済状態管理 (Phase 1依存)

[Phase 3]
└── Flutter UI Builder → 決済UI実装 (Phase 2依存)

[Phase 4]
└── Test Automation Engineer → 統合テスト (全Phase依存)
```

### SNS機能の実装
```
[要件] SNS投稿・フォロー機能

↓ 詳細な実装例は workflow-examples.md を参照

[複数フェーズで協調開発]
- リアルタイム機能
- 状態同期
- UI/UXの最適化
- 包括的テスト
```

## 利点

### ⚡ 開発効率
- **並行開発**: 独立タスクの同時実行で開発時間短縮
- **専門化**: 各ドメインの専門知識で高品質実装
- **自動化**: 手動調整作業の大幅削減

### 🔒 品質保証
- **包括的テスト**: 全ドメインを網羅する自動テスト
- **整合性チェック**: エージェント間の自動整合性確認
- **品質ゲート**: 自動化された品質基準の強制

### 📈 スケーラビリティ
- **エージェント拡張**: 新しい専門エージェントの容易な追加
- **学習能力**: 協調パターンの継続的改善
- **適応性**: 複雑なタスクの動的分解と分散

## 技術的特徴

### 🏗️ アーキテクチャ統合
- Flutter Web + Firebase Cloud Functions
- Riverpod状態管理 + Material Design 3
- Stripe決済統合 + セキュリティ準拠

### 🔄 開発ワークフロー
- Test-Driven Development (TDD)
- コード生成（`@riverpod`, `build_runner`）
- Firebase エミュレータ使用
- 継続的統合・デプロイメント

### 📊 品質メトリクス
- コードカバレッジ > 80%
- パフォーマンス基準の自動チェック
- アクセシビリティ準拠
- セキュリティ監査

## 次のステップ

### 🚀 即座に開始
1. `[MULTI-AGENT]`ラベル付きIssueを作成
2. Conductor Agentによる自動分析を待機
3. 専門エージェントによる並行開発を監視

### 📚 詳細な学習
- `agent-coordination-system.md`: システム設計の詳細
- `workflow-examples.md`: 実際の開発フローの詳細
- 各エージェント設定ファイル: 専門知識と実装パターン

### 🔧 カスタマイズ
- プロジェクト固有のパターンを各エージェント設定に追加
- 新しい専門エージェントの追加
- 協調パターンの最適化

---

このマルチエージェントシステムにより、TLINYプロジェクトの開発効率と品質を大幅に向上させ、複雑な機能開発を組織化された協調的なアプローチで実現します。