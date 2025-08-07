# Algolia検索機能のセットアップ

## 概要

Firestoreの`products`コレクションとデータを同期し、高速な全文検索機能を提供するためにAlgoliaを導入しました。

## 必要な設定

### 1. Algoliaアカウントの準備

1.  [Algolia](https://www.algolia.com/)でアカウントを作成します。
2.  新しいアプリケーションを作成します。
3.  "products"という名前の新しいインデックスを作成します。
4.  APIキーを取得します。
    -   `Application ID`
    -   `Search-Only API Key` (Flutterアプリ用)
    -   `Admin API Key` (Cloud Function用)

### 2. Firebase Functions環境変数の設定

Cloud FunctionがAlgoliaと通信するために、Admin APIキーを環境変数として設定する必要があります。

```bash
# Algolia連携用の環境変数を設定
firebase functions:config:set algolia.app_id="YOUR_ALGOLIA_APP_ID"
firebase functions:config:set algolia.api_key="YOUR_ALGOLIA_ADMIN_API_KEY"
firebase functions:config:set algolia.index_name="products"
```

### 3. ローカル開発時の環境変数設定

ローカルエミュレータでテストする場合、プロジェクトルートの`.env`ファイルに以下の内容を追加してください。

```env
ALGOLIA_APP_ID=YOUR_ALGOLIA_APP_ID
ALGOLIA_API_KEY=YOUR_ALGOLIA_ADMIN_API_KEY
ALGOLIA_INDEX_NAME=products
```

### 4. Flutterアプリの環境変数設定

FlutterアプリがAlgoliaに検索クエリを送信するために、`Application ID`と`Search-Only API Key`が必要です。これらは通常、アプリ内のセキュアな場所に埋め込むか、Firebase Remote Configなどから取得します。

今回の実装では、`lib/src/data/repository/product_repository.dart` に直接記述するプレースホルダーを設けます。本番環境ではより安全な方法で管理してください。

## 機能詳細

-   **Cloud Function**: `onProductWritten`
    -   **トリガー**: `v/1/products`コレクションのドキュメントが作成、更新、削除されたとき。
    -   **動作**:
        -   **作成/更新時**: Algoliaインデックスに新しいレコードを作成または更新します。
        -   **削除時** (`isActive: false`への更新時): Algoliaインデックスから対応するレコードを削除します。
-   **Flutterアプリ**: `ProductRepository`
    -   `searchProducts`メソッドが、FirestoreへのクエリではなくAlgoliaのAPIを呼び出すように変更されました。

## 注意事項

-   Algoliaの`Admin API Key`は非常に機密性の高い情報です。絶対にクライアントサイドのコードに含めないでください。
-   同期されるデータは`Product`モデルに基づきます。インデックス設定で検索可能な属性（`name`, `desc`など）を調整することで、検索精度を向上させることができます。
