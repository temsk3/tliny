# v2 Cloud Functions API仕様書

## 共通事項

- **認証**: 基本的に全エンドポイントでFirebase Authentication（request.auth.uid）が必要
- **エラー**: すべての関数で `HttpsError` を返す可能性あり（認証失敗・バリデーションエラー・Stripeエラー等）
- **リクエスト形式**: JSON
- **レスポンス形式**: JSON

---

## エンドポイント一覧

### account.ts

| 関数名              | 概要                               | 認証 | 主なリクエストパラメータ | 主なレスポンス例       |
| ------------------- | ---------------------------------- | ---- | ------------------------ | ---------------------- |
| onCreate            | Stripe Connectアカウント作成/更新  | 必須 | email, その他Stripe情報  | accountLink, accountId |
| onRetrieve          | アカウント情報取得                 | 必須 | accountId                | Stripeアカウント情報   |
| onUpdate            | アカウント情報更新                 | 必須 | accountId, 更新内容      | 更新後アカウント情報   |
| onDelete            | アカウント削除                     | 必須 | accountId                | 削除結果               |
| onList              | アカウント一覧取得                 | 必須 | なし                     | アカウントリスト       |
| onCreateAccountLink | アカウントリンク作成               | 必須 | accountId, returnUrl等   | accountLink            |
| onUpdateAccountLink | アカウントリンク更新               | 必須 | accountId, returnUrl等   | accountLink            |
| onCreateLoginLink   | Stripeダッシュボードログインリンク | 必須 | accountId                | loginLink              |

---

### checkout.ts

| 関数名               | 概要                     | 認証 | 主なリクエストパラメータ | 主なレスポンス例     |
| -------------------- | ------------------------ | ---- | ------------------------ | -------------------- |
| createPaymentSession | Checkoutセッション作成   | 必須 | eventId                  | sessionId, url       |
| retrieveSession      | セッション情報取得       | 必須 | checkoutSessionId        | Stripeセッション情報 |
| listLineItems        | セッションのLineItem取得 | 必須 | sessionId                | lineItems            |

---

### customer.ts

| 関数名          | 概要                 | 認証 | 主なリクエストパラメータ | 主なレスポンス例 |
| --------------- | -------------------- | ---- | ------------------------ | ---------------- |
| getEphemeralKey | EphemeralKey取得     | 必須 | apiVersion               | key              |
| onCreate        | Stripeカスタマー作成 | 必須 | なし                     | customer         |
| onRetrieve      | カスタマー情報取得   | 必須 | customerId               | customer         |
| onUpdate        | カスタマー情報更新   | 必須 | params                   | customer         |
| onDelete        | カスタマー削除       | 必須 | なし                     | 削除結果         |
| onSearch        | カスタマー検索       | 必須 | query                    | 検索結果         |

---

### payment_intent.ts

| 関数名            | 概要                    | 認証 | 主なリクエストパラメータ | 主なレスポンス例 |
| ----------------- | ----------------------- | ---- | ------------------------ | ---------------- |
| onCreate          | PaymentIntent作成       | 必須 | amount, currency         | clientSecret     |
| onCapture         | PaymentIntentキャプチャ | 必須 | paymentIntentId          | PaymentIntent    |
| onConfirm         | PaymentIntent確認       | 必須 | paymentId, paymentMethod | PaymentIntent    |
| onUpdate          | PaymentIntent更新       | 必須 | clientSecret, params     | PaymentIntent    |
| onCreateAutomatic | 自動PaymentIntent作成   | 必須 | amount, returnUrl等      | PaymentIntent    |
| onCreateManual    | 手動PaymentIntent作成   | 必須 | paymentMethod, amount等  | PaymentIntent    |

---

### payment_method.ts

| 関数名     | 概要                        | 認証 | 主なリクエストパラメータ | 主なレスポンス例 |
| ---------- | --------------------------- | ---- | ------------------------ | ---------------- |
| onCreate   | PaymentMethod作成           | 必須 | type, card情報           | paymentMethodId  |
| onAttach   | PaymentMethodを顧客に紐付け | 必須 | paymentMethodId          | paymentMethodId  |
| onRetrieve | PaymentMethod取得           | 必須 | paymentMethodId          | PaymentMethod    |
| onUpdate   | PaymentMethod更新           | 必須 | paymentMethodId, params  | PaymentMethod    |
| onDelete   | PaymentMethod削除           | 必須 | paymentMethodId          | 削除結果         |

---

### setup_intent.ts

| 関数名     | 概要                  | 認証 | 主なリクエストパラメータ | 主なレスポンス例     |
| ---------- | --------------------- | ---- | ------------------------ | -------------------- |
| onCreate   | SetupIntent作成       | 必須 | usage, paymentMethod等   | status, clientSecret |
| onRetrieve | SetupIntent取得       | 必須 | setupIntentId            | SetupIntent          |
| onUpdate   | SetupIntent更新       | 必須 | setupIntentId, params    | SetupIntent          |
| onConfirm  | SetupIntent確認       | 必須 | setupIntentId            | SetupIntent          |
| onCancel   | SetupIntentキャンセル | 必須 | setupIntentId            | SetupIntent          |

---

### external_accounts.ts

| 関数名     | 概要               | 認証 | 主なリクエストパラメータ             | 主なレスポンス例 |
| ---------- | ------------------ | ---- | ------------------------------------ | ---------------- |
| onCreate   | 外部アカウント作成 | 必須 | accountId, params                    | ExternalAccount  |
| onRetrieve | 外部アカウント取得 | 必須 | accountId, externalAccountId         | ExternalAccount  |
| onUpdate   | 外部アカウント更新 | 必須 | accountId, externalAccountId, params | ExternalAccount  |
| onDelete   | 外部アカウント削除 | 必須 | accountId, externalAccountId         | 削除結果         |

---

### invoice_settings.ts

| 関数名     | 概要                    | 認証 | 主なリクエストパラメータ | 主なレスポンス例 |
| ---------- | ----------------------- | ---- | ------------------------ | ---------------- |
| onCreate   | インボイス設定作成/更新 | 必須 | customerId, params       | Customer         |
| onRetrieve | インボイス設定取得      | 必須 | customerId               | Customer         |
| onUpdate   | インボイス設定更新      | 必須 | customerId, params       | Customer         |
| onDelete   | インボイス設定削除      | 必須 | customerId               | Customer         |

---

### persons.ts

| 関数名     | 概要               | 認証 | 主なリクエストパラメータ        | 主なレスポンス例 |
| ---------- | ------------------ | ---- | ------------------------------- | ---------------- |
| onCreate   | Stripe人物情報作成 | 必須 | accountId, personData           | Person           |
| onRetrieve | Stripe人物情報取得 | 必須 | accountId, personId             | Person           |
| onUpdate   | Stripe人物情報更新 | 必須 | accountId, personId, updateData | Person           |
| onDelete   | Stripe人物情報削除 | 必須 | accountId, personId             | 削除結果         |

---

### webhook.ts

| 関数名              | 概要                       | 認証 | 主なリクエストパラメータ | 主なレスポンス例   |
| ------------------- | -------------------------- | ---- | ------------------------ | ------------------ |
| handleWebhookEvents | Stripe Webhookイベント受信 | 不要 | Stripeイベント           | { received: true } |

---

## エラー例

- `unauthenticated`: 認証情報がない場合
- `failed-precondition`: Stripe ID等が未登録の場合
- `internal`: Stripe APIエラー等
- その他、各関数で `HttpsError` をthrow

---

## 備考

- すべての関数は `exports.v2.payment.[ファイル名].[関数名]` でデプロイされます
- Cloud Functions for Firebase v2形式
- 詳細なリクエスト/レスポンス例は各.tsファイルのJSDocや実装を参照
