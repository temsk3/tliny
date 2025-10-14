# Multi-Agent Coordination System for TLINY

## 概要
複数のサブエージェントが自動的に協調して開発タスクを完了するシステム

## エージェント間協調の仕組み

### 1. オーケストレーターエージェント (conductor-agent)
**役割**: 全体統制・タスク分散・進捗管理

```yaml
name: Conductor Agent
responsibilities:
  - Issue分析とタスク分解
  - エージェント選択と割り当て
  - 進捗監視と調整
  - 最終統合とレビュー
tools:
  - Task decomposition
  - Agent selection
  - Progress tracking
  - Quality assurance
```

### 2. 専門エージェント群

#### Firebase Functions Developer
```yaml
triggers:
  - "Firebase", "Cloud Functions", "webhook", "trigger"
dependencies:
  - stripe-payment-integrator (決済webhook)
  - test-automation-engineer (関数テスト)
outputs:
  - TypeScript関数コード
  - デプロイ設定
  - API仕様書
```

#### Flutter UI Builder
```yaml
triggers:
  - "UI", "Widget", "画面", "コンポーネント"
dependencies:
  - riverpod-state-manager (状態連携)
  - test-automation-engineer (UIテスト)
outputs:
  - Dartウィジェットコード
  - 画面仕様書
  - デザインガイド
```

#### Riverpod State Manager
```yaml
triggers:
  - "状態", "Provider", "Riverpod", "AsyncNotifier"
dependencies:
  - firestore-optimizer (データ層)
  - flutter-ui-builder (UI層)
outputs:
  - Provider実装
  - 状態管理ロジック
  - 依存関係図
```

## 協調ワークフローの例

### シナリオ: 「新しい決済機能の実装」

1. **Conductor Agent (統制)**
   ```
   Issue分析 → タスク分解:
   - Stripe新機能対応 → stripe-payment-integrator
   - UI更新 → flutter-ui-builder
   - 状態管理更新 → riverpod-state-manager
   - 関数実装 → firebase-functions-developer
   - テスト作成 → test-automation-engineer
   ```

2. **並行実行フェーズ**
   ```
   [Phase 1] 基盤実装
   stripe-payment-integrator → API仕様作成
   firebase-functions-developer → webhook実装

   [Phase 2] フロントエンド実装
   riverpod-state-manager → 決済状態Provider作成
   flutter-ui-builder → 決済UIコンポーネント作成

   [Phase 3] 統合・テスト
   test-automation-engineer → 統合テスト実行
   conductor-agent → 最終レビューと統合
   ```

3. **エージェント間通信**
   ```yaml
   communication_protocol:
     format: "structured_json"
     channels:
       - agent_coordination_issue
       - shared_workspace
       - status_updates

   message_types:
     - task_request
     - progress_update
     - dependency_ready
     - review_request
     - completion_notification
   ```

## 実装方法

### GitHub Issues ベースの協調
```yaml
# Issue Template: Multi-Agent Task
title: "[MULTI-AGENT] 新決済機能実装"
body: |
  ## 要件
  - Stripe新API対応
  - UI更新必要
  - テスト自動化

  ## エージェント割り当て
  @conductor-agent: 全体統制
  @stripe-payment-integrator: 決済ロジック
  @flutter-ui-builder: UI実装
  @test-automation-engineer: テスト作成

  ## 依存関係
  stripe → firebase-functions → riverpod → flutter-ui → test
```

### Workflow Orchestration
```yaml
name: Multi-Agent Collaboration

on:
  issues:
    types: [opened]
    # Multi-agent triggerを検出

jobs:
  conductor:
    if: contains(github.event.issue.body, '[MULTI-AGENT]')
    runs-on: ubuntu-latest
    steps:
      - name: Analyze and Decompose
        uses: anthropics/claude-code-action@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          model: "claude-4-opus-20250805"
          subagent_type: "conductor-agent"

  specialized-agents:
    needs: conductor
    strategy:
      matrix:
        agent: [
          "firebase-functions-developer",
          "stripe-payment-integrator",
          "flutter-ui-builder",
          "riverpod-state-manager",
          "test-automation-engineer"
        ]
    runs-on: ubuntu-latest
    steps:
      - name: Execute Specialized Task
        uses: anthropics/claude-code-action@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          model: "claude-4-opus-20250805"
          subagent_type: ${{ matrix.agent }}
```

## 協調メカニズム

### 1. 依存関係管理
```json
{
  "task_dependencies": {
    "payment_ui": {
      "depends_on": ["payment_api", "state_management"],
      "blocks": ["integration_test"]
    }
  }
}
```

### 2. 進捗同期
```json
{
  "agent_status": {
    "stripe-payment-integrator": "completed",
    "firebase-functions-developer": "in_progress",
    "flutter-ui-builder": "waiting_for_dependency"
  }
}
```

### 3. 品質ゲート
```yaml
quality_gates:
  - name: "API契約チェック"
    agents: [stripe-payment-integrator, firebase-functions-developer]
    condition: "API仕様が一致"

  - name: "状態管理整合性"
    agents: [riverpod-state-manager, flutter-ui-builder]
    condition: "Provider使用が正しい"
```

## 利点

1. **効率性**: 並行作業で開発速度向上
2. **品質**: 専門性による高品質実装
3. **整合性**: エージェント間の自動調整
4. **拡張性**: 新エージェント追加が容易
5. **透明性**: 全工程が可視化

## 次の実装ステップ

1. Conductor Agentの作成
2. 基本的な協調プロトコルの実装
3. 2-3個の専門エージェント作成
4. 小規模タスクでのテスト実行
5. フィードバックを元に改善