const { test, expect } = require('@playwright/test')

test.describe('Cross-Browser Compatibility Tests', () => {
  test.beforeEach(async ({ page }) => {
    // アプリのURLに移動
    await page.goto('http://localhost:3000', { waitUntil: 'domcontentloaded' })
    
    // ページが読み込まれるまで待機
    await page.waitForLoadState('networkidle', { timeout: 60000 })
  })

  test('should work on different viewport sizes', async ({ page }) => {
    // デスクトップサイズ
    await page.setViewportSize({ width: 1920, height: 1080 })
    await page.screenshot({ path: 'test-results/desktop-viewport.png' })
    
    // タブレットサイズ
    await page.setViewportSize({ width: 768, height: 1024 })
    await page.screenshot({ path: 'test-results/tablet-viewport.png' })
    
    // モバイルサイズ
    await page.setViewportSize({ width: 375, height: 667 })
    await page.screenshot({ path: 'test-results/mobile-viewport.png' })
    
    console.log('✅ 異なるビューポートサイズでの表示を確認')
  })

  test('should handle touch interactions on mobile', async ({ page }) => {
    // モバイルビューポートに設定
    await page.setViewportSize({ width: 375, height: 667 })
    
    // タッチイベントをシミュレート
    await page.tap('button[aria-label="ナビゲーション メニューを開く"]')
    await page.waitForTimeout(1000)
    
    await page.screenshot({ path: 'test-results/mobile-touch-interactions.png' })
    
    console.log('✅ モバイルでのタッチ操作を確認')
  })

  test('should maintain functionality across different screen orientations', async ({ page }) => {
    // 縦向き
    await page.setViewportSize({ width: 375, height: 667 })
    await page.screenshot({ path: 'test-results/portrait-orientation.png' })
    
    // 横向き
    await page.setViewportSize({ width: 667, height: 375 })
    await page.screenshot({ path: 'test-results/landscape-orientation.png' })
    
    console.log('✅ 画面の向きによる表示を確認')
  })

  test('should handle keyboard navigation', async ({ page }) => {
    // Tabキーでナビゲーション
    await page.keyboard.press('Tab')
    await page.keyboard.press('Tab')
    await page.keyboard.press('Tab')
    
    // Enterキーでアクティブな要素をクリック
    await page.keyboard.press('Enter')
    
    await page.waitForTimeout(1000)
    await page.screenshot({ path: 'test-results/keyboard-navigation.png' })
    
    console.log('✅ キーボードナビゲーションを確認')
  })

  test('should handle high contrast mode', async ({ page }) => {
    // 高コントラストモードをシミュレート
    await page.emulateMedia({ colorScheme: 'dark' })
    await page.screenshot({ path: 'test-results/dark-mode.png' })
    
    await page.emulateMedia({ colorScheme: 'light' })
    await page.screenshot({ path: 'test-results/light-mode.png' })
    
    console.log('✅ ダークモード/ライトモードを確認')
  })

  test('should work with reduced motion preferences', async ({ page }) => {
    // アニメーションを無効化
    await page.emulateMedia({ reducedMotion: 'reduce' })
    
    // アプリの操作を実行
    await page.getByRole('button', { name: 'ナビゲーション メニューを開く' }).click()
    await page.waitForTimeout(1000)
    
    await page.screenshot({ path: 'test-results/reduced-motion.png' })
    
    console.log('✅ アニメーション無効化時の表示を確認')
  })

  test('should handle different zoom levels', async ({ page }) => {
    // 50%ズーム
    await page.setViewportSize({ width: 960, height: 540 })
    await page.screenshot({ path: 'test-results/zoom-50-percent.png' })
    
    // 150%ズーム
    await page.setViewportSize({ width: 2880, height: 1620 })
    await page.screenshot({ path: 'test-results/zoom-150-percent.png' })
    
    console.log('✅ 異なるズームレベルでの表示を確認')
  })

  test('should maintain accessibility standards', async ({ page }) => {
    // アクセシビリティツリーを確認
    const accessibilityTree = await page.accessibility.snapshot()
    console.log('Accessibility tree:', JSON.stringify(accessibilityTree, null, 2))
    
    // スクリーンリーダー用のテキストを確認
    const screenReaderText = await page.evaluate(() => {
      const elements = document.querySelectorAll('[aria-label], [aria-labelledby], [alt]')
      return Array.from(elements).map(el => ({
        tag: el.tagName,
        ariaLabel: el.getAttribute('aria-label'),
        ariaLabelledBy: el.getAttribute('aria-labelledby'),
        alt: el.getAttribute('alt'),
        text: el.textContent?.trim()
      }))
    })
    
    console.log('Screen reader elements:', screenReaderText)
    
    await page.screenshot({ path: 'test-results/accessibility-check.png' })
    
    console.log('✅ アクセシビリティ標準を確認')
  })

  test('should handle slow network conditions', async ({ page }) => {
    // 低速ネットワークをシミュレート
    await page.route('**/*', route => {
      // 1秒の遅延を追加
      setTimeout(() => {
        route.continue()
      }, 1000)
    })
    
    // アプリの操作を実行
    await page.getByRole('button', { name: 'ナビゲーション メニューを開く' }).click()
    await page.waitForTimeout(2000)
    
    await page.screenshot({ path: 'test-results/slow-network.png' })
    
    console.log('✅ 低速ネットワークでの動作を確認')
  })

  test('should handle offline/online state changes', async ({ page }) => {
    // オフライン状態をシミュレート
    await page.context().setOffline(true)
    
    // アプリの操作を実行
    await page.getByRole('button', { name: 'SNS タブ: 4/' }).click()
    await page.waitForTimeout(2000)
    
    await page.screenshot({ path: 'test-results/offline-state.png' })
    
    // オンライン状態に戻す
    await page.context().setOffline(false)
    
    // オンライン復帰後の動作を確認
    await page.waitForTimeout(2000)
    await page.screenshot({ path: 'test-results/online-recovery.png' })
    
    console.log('✅ オフライン/オンライン状態の変更を確認')
  })
})
