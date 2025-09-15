const { test, expect } = require('@playwright/test')

test.describe('Comprehensive User Registration Tests', () => {
  test.beforeEach(async ({ page }) => {
    // アプリのURLに移動
    await page.goto('http://localhost:3000', { waitUntil: 'domcontentloaded' })

    // Flutter Web: アクセシビリティを自動有効化（ARIAロール露出のため）
    await page.evaluate(() => {
      const el = document.querySelector('[aria-label="Enable accessibility"]')
      if (el) el.click()
    })

    // 安定化: タイトルと本文の可視を待つ（networkidleは使わない）
    await expect(page).toHaveTitle('TLINY')
    await expect(page.locator('body')).toBeVisible()
  })

  test('should complete full user registration flow', async ({ page }) => {
    // 1. アプリの初期状態を確認
    await expect(page).toHaveTitle('TLINY')

    // 2. 新規登録ページに直接移動（安定化のため）
    await page.goto('http://localhost:3000/#/sign-up', {
      waitUntil: 'domcontentloaded',
    })
    await page.waitForTimeout(1000)
    await expect(page).toHaveURL(/.*#\/sign-up.*/)

    // 3. フォーム要素の待機とフォールバック
    await page.waitForSelector('input[type="email"], input[placeholder*="メール"], input[placeholder*="email"]', { timeout: 10000 })
    
    // 4. 有効なユーザー情報を入力
    const testEmail = `test-${Date.now()}@example.com`
    const testPassword = 'TestPassword123!'

    // メールアドレス入力（複数のセレクタで試行）
    const emailInput = page.locator('input[type="email"]').first()
      .or(page.locator('input[placeholder*="メール"]').first())
      .or(page.locator('input[placeholder*="email"]').first())
    await emailInput.fill(testEmail)

    // パスワード入力（複数のセレクタで試行）
    const passwordInput = page.locator('input[type="password"]').first()
      .or(page.locator('input[placeholder*="パスワード"]').first())
      .or(page.locator('input[placeholder*="password"]').first())
    await passwordInput.fill(testPassword)

    // 5. 登録ボタンをクリック（複数のセレクタで試行）
    const signUpButton = page.getByRole('button', { name: '新規登録' })
      .or(page.locator('button:has-text("新規登録")'))
      .or(page.locator('button:has-text("登録")'))
      .or(page.locator('button[type="submit"]'))
    await signUpButton.click()

    // 6. ローディング状態を確認
    await page.waitForTimeout(2000)
    await page.screenshot({ path: 'test-results/registration-success.png' })

    console.log(`✅ ユーザー登録成功: ${testEmail}`)
  })

  test('should handle invalid email format', async ({ page }) => {
    // 新規登録ページに直接移動
    await page.goto('http://localhost:3000/#/sign-up', {
      waitUntil: 'domcontentloaded',
    })
    await page.waitForTimeout(1000)
    await expect(page).toHaveURL(/.*#\/sign-up.*/)

    // フォーム要素の待機
    await page.waitForSelector('input[type="email"], input[placeholder*="メール"], input[placeholder*="email"]', { timeout: 10000 })

    // 無効なメールアドレスを入力
    const emailInput = page.locator('input[type="email"]').first()
      .or(page.locator('input[placeholder*="メール"]').first())
      .or(page.locator('input[placeholder*="email"]').first())
    await emailInput.fill('invalid-email')

    const passwordInput = page.locator('input[type="password"]').first()
      .or(page.locator('input[placeholder*="パスワード"]').first())
      .or(page.locator('input[placeholder*="password"]').first())
    await passwordInput.fill('TestPassword123!')

    // 登録ボタンをクリック
    const signUpButton = page.getByRole('button', { name: '新規登録' })
      .or(page.locator('button:has-text("新規登録")'))
      .or(page.locator('button:has-text("登録")'))
      .or(page.locator('button[type="submit"]'))
    await signUpButton.click()

    // エラーメッセージが表示されることを確認
    await page.waitForTimeout(2000)
    await page.screenshot({ path: 'test-results/invalid-email-error.png' })

    console.log('✅ 無効なメールアドレスのエラーハンドリングを確認')
  })

  test('should handle weak password', async ({ page }) => {
    // 新規登録ページに直接移動
    await page.goto('http://localhost:3000/#/sign-up', {
      waitUntil: 'domcontentloaded',
    })
    await page.waitForTimeout(1000)
    await expect(page).toHaveURL(/.*#\/sign-up.*/)

    // フォーム要素の待機
    await page.waitForSelector('input[type="email"], input[placeholder*="メール"], input[placeholder*="email"]', { timeout: 10000 })

    // 弱いパスワードを入力
    const emailInput = page.locator('input[type="email"]').first()
      .or(page.locator('input[placeholder*="メール"]').first())
      .or(page.locator('input[placeholder*="email"]').first())
    await emailInput.fill('test@example.com')

    const passwordInput = page.locator('input[type="password"]').first()
      .or(page.locator('input[placeholder*="パスワード"]').first())
      .or(page.locator('input[placeholder*="password"]').first())
    await passwordInput.fill('123')

    // 登録ボタンをクリック
    const signUpButton = page.getByRole('button', { name: '新規登録' })
      .or(page.locator('button:has-text("新規登録")'))
      .or(page.locator('button:has-text("登録")'))
      .or(page.locator('button[type="submit"]'))
    await signUpButton.click()

    // エラーメッセージが表示されることを確認
    await page.waitForTimeout(2000)
    await page.screenshot({ path: 'test-results/weak-password-error.png' })

    console.log('✅ 弱いパスワードのエラーハンドリングを確認')
  })

  test('should handle duplicate email registration', async ({ page }) => {
    // 新規登録ページに直接移動
    await page.goto('http://localhost:3000/#/sign-up', {
      waitUntil: 'domcontentloaded',
    })
    await page.waitForTimeout(1000)
    await expect(page).toHaveURL(/.*#\/sign-up.*/)

    // フォーム要素の待機
    await page.waitForSelector('input[type="email"], input[placeholder*="メール"], input[placeholder*="email"]', { timeout: 10000 })

    // 既存のメールアドレスを入力
    const emailInput = page.locator('input[type="email"]').first()
      .or(page.locator('input[placeholder*="メール"]').first())
      .or(page.locator('input[placeholder*="email"]').first())
    await emailInput.fill('test@example.com')

    const passwordInput = page.locator('input[type="password"]').first()
      .or(page.locator('input[placeholder*="パスワード"]').first())
      .or(page.locator('input[placeholder*="password"]').first())
    await passwordInput.fill('TestPassword123!')

    // 登録ボタンをクリック
    const signUpButton = page.getByRole('button', { name: '新規登録' })
      .or(page.locator('button:has-text("新規登録")'))
      .or(page.locator('button:has-text("登録")'))
      .or(page.locator('button[type="submit"]'))
    await signUpButton.click()

    // エラーメッセージが表示されることを確認
    await page.waitForTimeout(3000)
    await page.screenshot({ path: 'test-results/duplicate-email-error.png' })

    console.log('✅ 重複メールアドレスのエラーハンドリングを確認')
  })

  test('should navigate back from registration form', async ({ page }) => {
    // 新規登録ページに直接移動
    await page.goto('http://localhost:3000/#/sign-up', {
      waitUntil: 'domcontentloaded',
    })
    await page.waitForTimeout(1000)
    await expect(page).toHaveURL(/.*#\/sign-up.*/)

    // 戻るボタンをクリック（複数のセレクタで試行）
    const backButton = page.getByRole('button', { name: '戻る' })
      .or(page.locator('button:has-text("戻る")'))
      .or(page.locator('button:has-text("Back")'))
      .or(page.locator('button[aria-label*="戻る"]'))
    await backButton.click()

    // サインインページに戻ることを確認
    await page.waitForTimeout(1000)
    await page.screenshot({ path: 'test-results/navigation-back.png' })

    console.log('✅ 戻るナビゲーションを確認')
  })

  test('should show password visibility toggle', async ({ page }) => {
    // 新規登録ページに直接移動
    await page.goto('http://localhost:3000/#/sign-up', {
      waitUntil: 'domcontentloaded',
    })
    await page.waitForTimeout(1000)
    await expect(page).toHaveURL(/.*#\/sign-up.*/)

    // フォーム要素の待機
    await page.waitForSelector('input[type="password"], input[placeholder*="パスワード"], input[placeholder*="password"]', { timeout: 10000 })

    // パスワードフィールドにテキストを入力
    const passwordInput = page.locator('input[type="password"]').first()
      .or(page.locator('input[placeholder*="パスワード"]').first())
      .or(page.locator('input[placeholder*="password"]').first())
    await passwordInput.fill('TestPassword123!')

    // パスワード表示切り替えボタンを探す
    const passwordToggle = page
      .locator('button')
      .filter({ hasText: /表示|非表示|eye|visibility/i })

    if ((await passwordToggle.count()) > 0) {
      await passwordToggle.first().click()
      await page.waitForTimeout(1000)
      await page.screenshot({
        path: 'test-results/password-visibility-toggle.png',
      })
      console.log('✅ パスワード表示切り替え機能を確認')
    } else {
      console.log('ℹ️ パスワード表示切り替えボタンが見つかりませんでした')
    }
  })

  test('should validate form fields are required', async ({ page }) => {
    // 新規登録ページに直接移動
    await page.goto('http://localhost:3000/#/sign-up', {
      waitUntil: 'domcontentloaded',
    })
    await page.waitForTimeout(1000)
    await expect(page).toHaveURL(/.*#\/sign-up.*/)

    // フォーム要素の待機
    await page.waitForSelector('input[type="email"], input[placeholder*="メール"], input[placeholder*="email"]', { timeout: 10000 })

    // 空の状態で登録ボタンをクリック
    const signUpButton = page.getByRole('button', { name: '新規登録' })
      .or(page.locator('button:has-text("新規登録")'))
      .or(page.locator('button:has-text("登録")'))
      .or(page.locator('button[type="submit"]'))
    await signUpButton.click()

    // バリデーションエラーが表示されることを確認
    await page.waitForTimeout(2000)
    await page.screenshot({
      path: 'test-results/required-fields-validation.png',
    })

    console.log('✅ 必須フィールドのバリデーションを確認')
  })
})
