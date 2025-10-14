# Implementation Plan

- [ ] 1. 既存認証フローの要件整合と現状確認

  - メール登録/ログイン/ログアウト/ルーティング保護の挙動を要件と突合
  - UI 表示（成功/失敗メッセージ、遷移）の一貫性を確認
  - _Requirements: 1, 2, 4, 5_

- [ ] 2. ドメイン例外の正規化と表示メッセージ統一

  - Firebase 例外を AppException にマッピング（入力/ビジネス/システム）
  - UI メッセージのパターンを統一し、翻訳キーを割当
  - _Requirements: 5_
  - 2.1 ネットワーク断メッセージ指針の固定化（翻訳キー含む）
    - オフライン表示/リトライ案内の文言・表示位置・抑止条件を定義
    - _Requirements: 5_

- [ ] 3. ViewModel のフロー整理（Riverpod）

  - SignUp/SignIn/SignOut の AsyncValue 状態と遷移意図を明確化
  - 認証状態 Stream を購読し UI へ反映
  - _Requirements: 1, 2_
  - 3.3 セッション期限切れ時の再認証 UX 実装/検証
    - 期限切れ検知 → 再ログイン誘導 → 状態クリアの一連動線を実装
    - _Requirements: 2_

- [ ] 4. Repository の責務境界の明確化

  - createUser/signIn/signOut/sendEmailVerification/currentUserStream を提供
  - 例外変換とロギングポイントを定義
  - _Requirements: 1, 2, 5_

- [ ] 5. GoRouter の認可制御の見直し

  - redirect ロジックを認証状態に準拠させ、ループ防止を確認
  - 未認証 → ログイン、認証済み → 保護ルート/ホームの動線を保証
  - _Requirements: 4_

- [ ] 6. セキュリティ確認

  - 秘密情報がクライアントに存在しないことを確認
  - 連続失敗時の制御（レートリミット/追加確認）方針を整理
  - _Requirements: 6_
  - 6.1 連続失敗時の制御テスト観点を列挙し疑似負荷で確認
    - 一定時間内の失敗連続時の挙動・メッセージ・ログを検証
    - _Requirements: 6_

- [ ] 7. テスト強化

  - Unit: 例外マッピング、ViewModel 成功/失敗
  - Integration: サインアップ → ログイン、redirect、ネットワーク障害
  - E2E: 登録、無効メール、弱パス、重複メール、ログアウト
  - _Requirements: 1, 2, 4, 5_
  - 7.1 メール未確認時のガードと再送導線の E2E
    - verify 未完了時の制限動作、再送、完了後再試行の通し確認
    - _Requirements: 1_

- [ ] 8. ドキュメント更新

  - README/内部ガイドにフロー図とメッセージポリシーを反映
  - _Requirements: 概要/非機能整合_

- [ ] 9. ソーシャルサインイン整合性確認と UI フロー明文化
  - IdP 成功/キャンセル/失敗の分岐を確認し UI メッセージを明記
  - 対応外の場合は「非対象」を明示し設計/要件へ反映
  - _Requirements: 3_
