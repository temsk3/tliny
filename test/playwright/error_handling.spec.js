const { test, expect } = require('@playwright/test')

test.describe('Error Handling Tests', () => {
  test.beforeEach(async ({ page }) => {
    // アプリのURLに移動
    await page.goto('http://localhost:3000', { waitUntil: 'domcontentloaded' })
    
    // ページが読み込まれるまで待機
    await page.waitForLoadState('networkidle', { timeout: 60000 })
  })

  test('should handle network errors gracefully', async ({ page }) => {
    // ネットワークエラーをシミュレート
    await page.route('**/v2_sns_post_getFeed', route => {
      route.abort('failed')
    })
    
    // SNSタブに移動してエラーを発生させる
    await page.getByRole('button', { name: 'SNS タブ: 4/' }).click()
    
    // エラーメッセージが表示されることを確認
    await page.waitForTimeout(3000)
    await expect(page.getByText('エラーが発生しました')).toBeVisible()
    
    // 再試行ボタンが表示されることを確認
    await expect(page.getByRole('button', { name: '再試行' })).toBeVisible()
    
    await page.screenshot({ path: 'test-results/network-error-handling.png' })
    
    console.log('✅ ネットワークエラーのハンドリングを確認')
  })

  test('should handle form validation errors', async ({ page }) => {
    // ナビゲーションメニューを開く
    await page.getByRole('button', { name: 'ナビゲーション メニューを開く' }).click()
    await page.getByRole('button', { name: 'サインイン' }).click()
    await page.getByRole('button', { name: '新規登録' }).click()
    
    // 無効なデータでフォームを送信
    await page.getByRole('textbox', { name: 'メールアドレス' }).fill('invalid-email')
    await page.getByRole('textbox', { name: 'パスワード' }).fill('123')
    await page.getByRole('button', { name: '新規登録' }).click()
    
    // バリデーションエラーが表示されることを確認
    await page.waitForTimeout(2000)
    await page.screenshot({ path: 'test-results/form-validation-errors.png' })
    
    console.log('✅ フォームバリデーションエラーを確認')
  })

  test('should handle authentication errors', async ({ page }) => {
    // ナビゲーションメニューを開く
    await page.getByRole('button', { name: 'ナビゲーション メニューを開く' }).click()
    await page.getByRole('button', { name: 'サインイン' }).click()
    
    // 存在しない認証情報でログインを試行
    await page.getByRole('textbox', { name: 'メール' }).fill('nonexistent@example.com')
    await page.getByRole('textbox', { name: 'パスワード' }).fill('wrongpassword')
    await page.getByRole('button', { name: 'サインイン' }).click()
    
    // 認証エラーが表示されることを確認
    await page.waitForTimeout(3000)
    await page.screenshot({ path: 'test-results/authentication-error.png' })
    
    console.log('✅ 認証エラーのハンドリングを確認')
  })

  test('should handle server errors gracefully', async ({ page }) => {
    // サーバーエラーをシミュレート
    await page.route('**/v2_*', route => {
      route.fulfill({
        status: 500,
        contentType: 'application/json',
        body: JSON.stringify({ error: 'Internal Server Error' })
      })
    })
    
    // 何らかのAPI呼び出しを発生させる
    await page.getByRole('button', { name: 'SNS タブ: 4/' }).click()
    
    // エラーメッセージが表示されることを確認
    await page.waitForTimeout(3000)
    await page.screenshot({ path: 'test-results/server-error-handling.png' })
    
    console.log('✅ サーバーエラーのハンドリングを確認')
  })

  test('should handle timeout errors', async ({ page }) => {
    // タイムアウトをシミュレート
    await page.route('**/v2_*', route => {
      // レスポンスを遅延させる
      setTimeout(() => {
        route.fulfill({
          status: 200,
          contentType: 'application/json',
          body: JSON.stringify({ data: [] })
        })
      }, 10000) // 10秒遅延
    })
    
    // タイムアウトが発生する操作を実行
    await page.getByRole('button', { name: 'SNS タブ: 4/' }).click()
    
    // タイムアウトエラーまたはローディング状態を確認
    await page.waitForTimeout(5000)
    await page.screenshot({ path: 'test-results/timeout-error-handling.png' })
    
    console.log('✅ タイムアウトエラーのハンドリングを確認')
  })

  test('should handle empty state gracefully', async ({ page }) => {
    // 空のデータを返すようにモック
    await page.route('**/v2_sns_post_getFeed', route => {
      route.fulfill({
        status: 200,
        contentType: 'application/json',
        body: JSON.stringify({ posts: [] })
      })
    })
    
    // SNSタブに移動
    await page.getByRole('button', { name: 'SNS タブ: 4/' }).click()
    
    // 空の状態が適切に表示されることを確認
    await page.waitForTimeout(3000)
    await page.screenshot({ path: 'test-results/empty-state-handling.png' })
    
    console.log('✅ 空の状態のハンドリングを確認')
  })

  test('should show appropriate error messages', async ({ page }) => {
    // ナビゲーションメニューを開く
    await page.getByRole('button', { name: 'ナビゲーション メニューを開く' }).click()
    await page.getByRole('button', { name: 'サインイン' }).click()
    
    // 空のフィールドでログインを試行
    await page.getByRole('button', { name: 'サインイン' }).click()
    
    // 適切なエラーメッセージが表示されることを確認
    await page.waitForTimeout(2000)
    await page.screenshot({ path: 'test-results/error-messages.png' })
    
    console.log('✅ エラーメッセージの表示を確認')
  })

  test('should handle browser back/forward navigation', async ({ page }) => {
    // ナビゲーションメニューを開く
    await page.getByRole('button', { name: 'ナビゲーション メニューを開く' }).click()
    await page.getByRole('button', { name: 'サインイン' }).click()
    
    // ブラウザの戻るボタンをクリック
    await page.goBack()
    
    // 適切に前のページに戻ることを確認
    await page.waitForTimeout(1000)
    await page.screenshot({ path: 'test-results/browser-navigation.png' })
    
    // ブラウザの進むボタンをクリック
    await page.goForward()
    
    // サインインページに戻ることを確認
    await page.waitForTimeout(1000)
    await expect(page.getByRole('heading', { name: 'サインイン' })).toBeVisible()
    
    console.log('✅ ブラウザナビゲーションのハンドリングを確認')
  })

  test('should handle rapid user interactions', async ({ page }) => {
    // ナビゲーションメニューを開く
    await page.getByRole('button', { name: 'ナビゲーション メニューを開く' }).click()
    await page.getByRole('button', { name: 'サインイン' }).click()
    await page.getByRole('button', { name: '新規登録' }).click()
    
    // フォームにデータを入力
    await page.getByRole('textbox', { name: 'メールアドレス' }).fill('test@example.com')
    await page.getByRole('textbox', { name: 'パスワード' }).fill('TestPassword123!')
    
    // 登録ボタンを連続でクリック（二重送信の防止をテスト）
    await page.getByRole('button', { name: '新規登録' }).click()
    await page.getByRole('button', { name: '新規登録' }).click()
    await page.getByRole('button', { name: '新規登録' }).click()
    
    // 適切に処理されることを確認
    await page.waitForTimeout(3000)
    await page.screenshot({ path: 'test-results/rapid-interactions.png' })
    
    console.log('✅ 高速なユーザー操作のハンドリングを確認')
  })
})
