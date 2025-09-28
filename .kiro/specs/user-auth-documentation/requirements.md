# Requirements Document

## Introduction

TLINY の既存ユーザー認証機能（Firebase Authentication を中心としたメール/パスワード、ソーシャルログイン、セッション管理、認証状態の UI 反映）の仕様を体系化して文書化する。

## Requirements

### Requirement 1: アカウント登録（メール/パスワード）

**Objective:** As a visitor, I want to create an account with email and password so that I can purchase and manage orders.

#### Acceptance Criteria

1. WHEN ユーザーが有効なメールと十分に強いパスワードを入力して登録を送信 THEN システム SHALL アカウントを作成し確認メールを送信する
2. IF 入力メールが既に使用済み THEN システム SHALL エラーを返し登録を拒否する
3. WHILE 確認メールの認証が未完了 THE システム SHALL 制限付き状態でログイン可能にするか、またはメール確認を促すフローを表示する
4. WHERE パスワード強度が基準未満 THE システム SHALL 登録を拒否しユーザーに強度要件を提示する

### Requirement 2: ログイン/ログアウトとセッション管理

**Objective:** As a user, I want to sign in and stay signed in securely so that I can continue shopping seamlessly.

#### Acceptance Criteria

1. WHEN ユーザーが正しい資格情報でログイン THEN システム SHALL セッションを確立しホームまたは直前ページへ遷移する
2. IF ユーザーがログアウトを実行 THEN システム SHALL セッションを無効化し公開ページへ遷移する
3. WHILE セッションが有効 THE システム SHALL 認証状態を保持し保護ページへアクセス可能にする
4. WHERE セッション有効期限が切れた場合 THE システム SHALL 再認証を要求し安全に状態をクリアする

### Requirement 3: ソーシャルサインイン（該当する場合）

**Objective:** As a user, I want to sign in via supported identity providers so that onboarding is faster.

#### Acceptance Criteria

1. WHEN 対応 IdP ボタンを選択 THEN システム SHALL OAuth フローを開始し成功時にアカウント連携/作成する
2. IF IdP 側でキャンセルまたは失敗 THEN システム SHALL 失敗理由を表示しセッションを確立しない

### Requirement 4: 認可とルーティング制御

**Objective:** As a system, I want to restrict access to protected routes so that only authenticated users can view sensitive pages.

#### Acceptance Criteria

1. WHEN 未認証ユーザーが保護ルートにアクセス THEN システム SHALL ログイン画面へリダイレクトする
2. IF 認証済みユーザーがログイン画面にアクセス THEN システム SHALL ホーム等へリダイレクトする
3. WHILE 認証状態が変化 THE ルーター SHALL UI を即時に再評価して遷移可否を反映する

### Requirement 5: エラー処理とユーザーフィードバック

**Objective:** As a user, I want clear messages for auth errors so that I can resolve issues quickly.

#### Acceptance Criteria

1. WHEN 認証 API がエラーを返却 THEN システム SHALL 種別に応じたメッセージ（メール重複/弱パス/ネットワーク等）を表示する
2. WHERE ネットワーク断が発生 THE システム SHALL リトライ案内またはオフライン表示を行う
3. IF 多要素やメール未確認が必要 THEN システム SHALL 対応手順を明示し完了後に再試行を促す

### Requirement 6: セキュリティ要件

**Objective:** As a system, I want to enforce security controls so that user data and sessions remain protected.

#### Acceptance Criteria

1. WHILE 認証情報を送受信 THE システム SHALL HTTPS を強制し機密データを保護する
2. WHERE クライアントでは秘密鍵が不要 THE システム SHALL 秘密情報をクライアントに配置しない
3. IF 異常なログイン試行が連続 THEN システム SHALL レートリミットまたは追加確認を適用する




