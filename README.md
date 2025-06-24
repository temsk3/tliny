# TLINY - 学校バザー Web アプリ

<div align="center">
  <img src="assets/img/icon.png" alt="TLINY Logo" width="120" height="120">
  <h3>学校バザーをデジタル化する次世代プラットフォーム</h3>
</div>

## 📖 概要

TLINY は、学校バザーをデジタル化し、生徒・保護者・教職員が安全で便利に商品の売買を行える Web アプリケーションです。従来の現金取引に代わり、デジタル決済を導入することで、感染症対策と効率的な運営を実現します。

### 🎯 主な特徴

- **デジタル決済**: Stripe を活用した安全なオンライン決済
- **リアルタイム管理**: 在庫状況や売上をリアルタイムで確認
- **QR コード機能**: 商品の受け渡しを QR コードで管理
- **多言語対応**: 日本語・英語に対応
- **レスポンシブデザイン**: PC・タブレット・スマートフォンに対応
- **管理者機能**: 売上管理、在庫管理、スタッフ管理

## 🚀 主要機能

### 👥 ユーザー機能

- **商品閲覧**: カテゴリ別・検索機能付き商品一覧
- **カート機能**: 複数商品の一括購入
- **決済**: Stripe による安全なオンライン決済
- **注文履歴**: 購入履歴の確認
- **QR チケット**: 購入商品の受け渡し用 QR コード

### 🏫 管理者機能

- **イベント管理**: バザーイベントの作成・編集
- **商品管理**: 商品の登録・編集・在庫管理
- **売上管理**: リアルタイム売上・利益の確認
- **スタッフ管理**: スタッフの登録・権限管理
- **QR スキャン**: 商品受け渡し時の QR コード読み取り

### 📊 分析機能

- **売上分析**: 日別・商品別売上レポート
- **在庫管理**: リアルタイム在庫状況
- **顧客分析**: 購入パターンの分析

## 🛠 技術スタック

### フロントエンド

- **Flutter Web**: クロスプラットフォーム対応
- **Riverpod**: 状態管理（Generator 含む）
- **GoRouter**: ルーティング
- **Freezed**: データモデル
- **ResponsiveSizer**: レスポンシブデザイン

### バックエンド

- **Firebase**:
  - Firestore (データベース)
  - Authentication (認証)
  - Storage (ファイル保存)
  - Functions (サーバーレス)
  - Analytics (分析)
- **Cloud Functions (TypeScript)**: サーバーサイドロジック

### 決済・外部サービス

- **Stripe**: オンライン決済
- **Firebase Extensions**: 機能拡張

### 開発ツール

- **build_runner**: コード生成
- **riverpod_generator**: プロバイダー生成
- **freezed**: データクラス生成
- **go_router_builder**: ルーティング生成

## 📁 プロジェクト構造

```
tliny/
├── lib/
│   ├── src/
│   │   ├── app.dart                 # アプリケーションのエントリーポイント
│   │   ├── data/                    # データ層
│   │   │   ├── model/               # データモデル（Freezed）
│   │   │   ├── repository/          # リポジトリ層
│   │   │   └── general_provider.dart # 共通プロバイダー
│   │   ├── ui/                      # プレゼンテーション層
│   │   │   ├── auth/                # 認証関連UI
│   │   │   ├── product/             # 商品関連UI
│   │   │   ├── program/             # イベント関連UI
│   │   │   ├── cart/                # カート関連UI
│   │   │   ├── checkout/            # 決済関連UI
│   │   │   ├── management/          # 管理画面UI
│   │   │   └── common/              # 共通UIコンポーネント
│   │   ├── settings/                # 設定
│   │   │   ├── routes/              # ルーティング設定
│   │   │   ├── theme/               # テーマ設定
│   │   │   └── hooks/               # カスタムフック
│   │   └── utils/                   # ユーティリティ
│   ├── main.dart                    # アプリケーション起動
│   └── firebase_options.dart        # Firebase設定
├── functions/                       # Cloud Functions
│   └── src/
│       ├── v1/
│       │   ├── stripe/              # Stripe関連関数
│       │   ├── firestore/           # Firestore関連関数
│       │   └── method/              # その他の関数
│       └── utils/                   # 共通ユーティリティ
└── assets/                          # 静的ファイル
    ├── img/                         # 画像ファイル
    ├── fonts/                       # フォントファイル
    └── files/                       # その他ファイル
```

## 🏗 アーキテクチャ

### MVVM + Repository パターン

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│       View      │    │    ViewModel    │    │   Repository    │
│   (Widget)      │◄──►│   (Notifier)    │◄──►│   (Interface)   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                                       │
                                              ┌─────────────────┐
                                              │   DataSource    │
                                              │ (Firebase/API)  │
                                              └─────────────────┘
```

### 責務分離

- **View**: UI 表示とユーザーイベントの処理のみ
- **ViewModel**: ビジネスロジックと状態管理
- **Repository**: データアクセスの抽象化
- **DataSource**: 具体的なデータソース（Firebase、Stripe 等）

## 🚀 セットアップ

### 前提条件

- Flutter SDK 3.7.0 以上
- Node.js 18 以上
- Firebase CLI
- Stripe アカウント

### 1. リポジトリのクローン

```bash
git clone https://github.com/your-username/tliny.git
cd tliny
```

### 2. 依存関係のインストール

```bash
# Flutter依存関係
flutter pub get

# Cloud Functions依存関係
cd functions
npm install
cd ..
```

### 3. 環境変数の設定

#### Flutter 側（.env ファイル）

```env
# Firebase設定
FIREBASE_API_KEY=your_firebase_api_key
FIREBASE_PROJECT_ID=your_project_id

# Stripe設定
STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key

# 環境設定
FLAVOR=dev
PREVIEW=true
```

#### Cloud Functions 側（functions/.env ファイル）

```env
# Stripe設定
STRIPE_SECRET_KEY=your_stripe_secret_key
STRIPE_WEBHOOK_SECRET=your_webhook_secret

# Firebase設定
FIREBASE_PROJECT_ID=your_project_id
```

### 4. Firebase 設定

```bash
# Firebase CLIのインストール
npm install -g firebase-tools

# Firebaseにログイン
firebase login

# プロジェクトの初期化
firebase init

# Firestoreルールの設定
firebase deploy --only firestore:rules
```

### 5. Stripe 設定

1. Stripe ダッシュボードでアカウントを作成
2. 公開キーと秘密キーを取得
3. Webhook エンドポイントを設定

### 6. アプリケーションの起動

```bash
# 開発サーバーの起動
flutter run -d chrome

# Cloud Functionsの起動（開発環境）
cd functions
npm run serve
```

## 🔧 開発ガイド

### コード生成

```bash
# プロバイダーとモデルの生成
flutter pub run build_runner build

# 継続的な生成（開発中）
flutter pub run build_runner watch
```

### テスト実行

```bash
# 単体テスト
flutter test

# 統合テスト
flutter test integration_test/
```

### コード品質チェック

```bash
# 静的解析
flutter analyze

# コードフォーマット
dart format lib/
```

## 📱 主要画面

### ユーザー向け画面

- **トップページ**: イベント一覧・検索機能
- **商品詳細**: 商品情報・購入ボタン
- **カート**: 購入商品の確認・数量変更
- **決済**: Stripe 決済フォーム
- **注文完了**: QR チケット表示

### 管理者向け画面

- **ダッシュボード**: 売上・在庫サマリー
- **商品管理**: 商品の登録・編集・削除
- **売上管理**: 詳細な売上レポート
- **QR スキャン**: 商品受け渡し管理

## 🔒 セキュリティ

### 認証・認可

- Firebase Authentication による安全な認証
- ロールベースのアクセス制御
- JWT トークンによる API 保護

### データ保護

- Firestore セキュリティルール
- 機密情報の環境変数管理
- HTTPS 通信の強制

### 決済セキュリティ

- Stripe の PCI DSS 準拠
- クレジットカード情報の非保持
- Webhook 署名検証

## 🚀 デプロイ

### 本番環境へのデプロイ

```bash
# Flutter Webビルド
flutter build web --release

# Firebase Hostingへのデプロイ
firebase deploy --only hosting

# Cloud Functionsのデプロイ
firebase deploy --only functions
```

### 環境別設定

- **開発環境**: エミュレータ使用、デバッグモード
- **ステージング環境**: テストデータ、本番類似環境
- **本番環境**: 本番データ、最適化設定

## 📊 パフォーマンス

### 最適化施策

- 画像の遅延読み込み
- コード分割（Code Splitting）
- キャッシュ戦略
- CDN 活用

### 監視・分析

- Firebase Analytics
- Firebase Performance Monitoring
- エラー監視（Crashlytics）

## 🤝 コントリビューション

1. このリポジトリをフォーク
2. 機能ブランチを作成 (`git checkout -b feature/amazing-feature`)
3. 変更をコミット (`git commit -m 'Add amazing feature'`)
4. ブランチにプッシュ (`git push origin feature/amazing-feature`)
5. プルリクエストを作成

## 📄 ライセンス

このプロジェクトは [MIT License](LICENSE) の下で公開されています。

## 📞 サポート

- **Issues**: [GitHub Issues](https://github.com/your-username/tliny/issues)
- **ドキュメント**: [Wiki](https://github.com/your-username/tliny/wiki)
- **メール**: support@tliny.com

## 🙏 謝辞

- [Flutter](https://flutter.dev/) - クロスプラットフォーム開発フレームワーク
- [Firebase](https://firebase.google.com/) - バックエンドサービス
- [Stripe](https://stripe.com/) - 決済プラットフォーム
- [Riverpod](https://riverpod.dev/) - 状態管理ライブラリ

---

<div align="center">
  <p>Made with ❤️ for better school bazaars</p>
  <p>© 2024 TLINY Team. All rights reserved.</p>
</div>
