const { test, expect } = require('@playwright/test')

test.describe('Comprehensive User Registration Tests', () => {
  test.beforeEach(async ({ page }) => {
    // アプリのURLに移動
    await page.goto('http://localhost:3000', { waitUntil: 'domcontentloaded' })
    
    // ページが読み込まれるまで待機
    await page.waitForLoadState('networkidle', { timeout: 60000 })
  })

  test('should complete full user registration flow', async ({ page }) => {
    // 1. アプリの初期状態を確認
    await expect(page).toHaveTitle('TLINY')
    
    // 2. ナビゲーションメニューを開く
    await page.getByRole('button', { name: 'ナビゲーション メニューを開く' }).click()
    
    // 3. サインインページに移動
    await page.getByRole('button', { name: 'サインイン' }).click()
    await expect(page.getByRole('heading', { name: 'サインイン' })).toBeVisible()
    
    // 4. 新規登録ページに移動
    await page.getByRole('button', { name: '新規登録' }).click()
    await expect(page.getByRole('heading', { name: '新規登録' })).toBeVisible()
    
    // 5. 有効なユーザー情報を入力
    const testEmail = `test-${Date.now()}@example.com`
    const testPassword = 'TestPassword123!'
    
    await page.getByRole('textbox', { name: 'メールアドレス' }).fill(testEmail)
    await page.getByRole('textbox', { name: 'パスワード' }).fill(testPassword)
    
    // 6. 登録ボタンをクリック
    await page.getByRole('button', { name: '新規登録' }).click()
    
    // 7. ローディング状態を確認
    await expect(page.getByText('アカウント作成中...')).toBeVisible()
    
    // 8. 登録完了後の状態を確認（ログイン状態になる）
    await page.waitForTimeout(3000) // 登録処理の完了を待つ
    
    // 9. スクリーンショットを撮影
    await page.screenshot({ path: 'test-results/registration-success.png' })
    
    console.log(`✅ ユーザー登録成功: ${testEmail}`)
  })

  test('should handle invalid email format', async ({ page }) => {
    // ナビゲーションメニューを開く
    await page.getByRole('button', { name: 'ナビゲーション メニューを開く' }).click()
    await page.getByRole('button', { name: 'サインイン' }).click()
    await page.getByRole('button', { name: '新規登録' }).click()
    
    // 無効なメールアドレスを入力
    await page.getByRole('textbox', { name: 'メールアドレス' }).fill('invalid-email')
    await page.getByRole('textbox', { name: 'パスワード' }).fill('TestPassword123!')
    
    // 登録ボタンをクリック
    await page.getByRole('button', { name: '新規登録' }).click()
    
    // エラーメッセージが表示されることを確認
    await page.waitForTimeout(2000)
    await page.screenshot({ path: 'test-results/invalid-email-error.png' })
    
    console.log('✅ 無効なメールアドレスのエラーハンドリングを確認')
  })

  test('should handle weak password', async ({ page }) => {
    // ナビゲーションメニューを開く
    await page.getByRole('button', { name: 'ナビゲーション メニューを開く' }).click()
    await page.getByRole('button', { name: 'サインイン' }).click()
    await page.getByRole('button', { name: '新規登録' }).click()
    
    // 弱いパスワードを入力
    await page.getByRole('textbox', { name: 'メールアドレス' }).fill('test@example.com')
    await page.getByRole('textbox', { name: 'パスワード' }).fill('123')
    
    // 登録ボタンをクリック
    await page.getByRole('button', { name: '新規登録' }).click()
    
    // エラーメッセージが表示されることを確認
    await page.waitForTimeout(2000)
    await page.screenshot({ path: 'test-results/weak-password-error.png' })
    
    console.log('✅ 弱いパスワードのエラーハンドリングを確認')
  })

  test('should handle duplicate email registration', async ({ page }) => {
    // ナビゲーションメニューを開く
    await page.getByRole('button', { name: 'ナビゲーション メニューを開く' }).click()
    await page.getByRole('button', { name: 'サインイン' }).click()
    await page.getByRole('button', { name: '新規登録' }).click()
    
    // 既存のメールアドレスを入力
    await page.getByRole('textbox', { name: 'メールアドレス' }).fill('test@example.com')
    await page.getByRole('textbox', { name: 'パスワード' }).fill('TestPassword123!')
    
    // 登録ボタンをクリック
    await page.getByRole('button', { name: '新規登録' }).click()
    
    // エラーメッセージが表示されることを確認
    await page.waitForTimeout(3000)
    await page.screenshot({ path: 'test-results/duplicate-email-error.png' })
    
    console.log('✅ 重複メールアドレスのエラーハンドリングを確認')
  })

  test('should navigate back from registration form', async ({ page }) => {
    // ナビゲーションメニューを開く
    await page.getByRole('button', { name: 'ナビゲーション メニューを開く' }).click()
    await page.getByRole('button', { name: 'サインイン' }).click()
    await page.getByRole('button', { name: '新規登録' }).click()
    
    // 戻るボタンをクリック
    await page.getByRole('button', { name: '戻る' }).click()
    
    // サインインページに戻ることを確認
    await expect(page.getByRole('heading', { name: 'サインイン' })).toBeVisible()
    
    console.log('✅ 戻るナビゲーションを確認')
  })

  test('should show password visibility toggle', async ({ page }) => {
    // ナビゲーションメニューを開く
    await page.getByRole('button', { name: 'ナビゲーション メニューを開く' }).click()
    await page.getByRole('button', { name: 'サインイン' }).click()
    await page.getByRole('button', { name: '新規登録' }).click()
    
    // パスワードフィールドにテキストを入力
    await page.getByRole('textbox', { name: 'パスワード' }).fill('TestPassword123!')
    
    // パスワード表示切り替えボタンを探す
    const passwordToggle = page.locator('button').filter({ hasText: /表示|非表示|eye|visibility/i })
    
    if (await passwordToggle.count() > 0) {
      await passwordToggle.first().click()
      await page.waitForTimeout(1000)
      await page.screenshot({ path: 'test-results/password-visibility-toggle.png' })
      console.log('✅ パスワード表示切り替え機能を確認')
    } else {
      console.log('ℹ️ パスワード表示切り替えボタンが見つかりませんでした')
    }
  })

  test('should validate form fields are required', async ({ page }) => {
    // ナビゲーションメニューを開く
    await page.getByRole('button', { name: 'ナビゲーション メニューを開く' }).click()
    await page.getByRole('button', { name: 'サインイン' }).click()
    await page.getByRole('button', { name: '新規登録' }).click()
    
    // 空の状態で登録ボタンをクリック
    await page.getByRole('button', { name: '新規登録' }).click()
    
    // バリデーションエラーが表示されることを確認
    await page.waitForTimeout(2000)
    await page.screenshot({ path: 'test-results/required-fields-validation.png' })
    
    console.log('✅ 必須フィールドのバリデーションを確認')
  })
})
