#!/usr/bin/env node

const { execSync } = require('child_process')
const fs = require('fs')
const path = require('path')

console.log('🧪 TLINY 包括的テストスイート実行スクリプト')
console.log('===============================================\n')

// テスト結果ディレクトリを作成
const testResultsDir = 'test-results'
if (!fs.existsSync(testResultsDir)) {
  fs.mkdirSync(testResultsDir, { recursive: true })
}

// テストファイルのリスト
const testFiles = [
  'comprehensive_user_registration.spec.js',
  'authentication_flow.spec.js',
  'error_handling.spec.js',
  'cross_browser.spec.js',
]

// テスト実行関数
function runTest(testFile) {
  console.log(`\n🚀 ${testFile} を実行中...`)
  console.log('----------------------------------------')

  try {
    const startTime = Date.now()
    execSync(
      `npx playwright test test/playwright/${testFile} --reporter=line`,
      {
        stdio: 'inherit',
        cwd: process.cwd(),
      },
    )
    const endTime = Date.now()
    const duration = ((endTime - startTime) / 1000).toFixed(2)

    console.log(`✅ ${testFile} 完了 (${duration}秒)`)
    return { success: true, duration: parseFloat(duration) }
  } catch (error) {
    console.log(`❌ ${testFile} 失敗`)
    return { success: false, error: error.message }
  }
}

// メイン実行関数
async function runAllTests() {
  const results = []
  const totalStartTime = Date.now()

  console.log('📋 実行予定のテストファイル:')
  testFiles.forEach((file, index) => {
    console.log(`  ${index + 1}. ${file}`)
  })

  console.log('\n🎯 テスト実行開始...\n')

  // 各テストファイルを順次実行
  for (const testFile of testFiles) {
    const result = runTest(testFile)
    results.push({
      file: testFile,
      ...result,
    })
  }

  const totalEndTime = Date.now()
  const totalDuration = ((totalEndTime - totalStartTime) / 1000).toFixed(2)

  // 結果サマリーを表示
  console.log('\n📊 テスト実行結果サマリー')
  console.log('===============================================')

  const successful = results.filter((r) => r.success).length
  const failed = results.filter((r) => !r.success).length

  console.log(`総実行時間: ${totalDuration}秒`)
  console.log(`成功: ${successful}/${results.length}`)
  console.log(`失敗: ${failed}/${results.length}`)

  console.log('\n📝 詳細結果:')
  results.forEach((result, index) => {
    const status = result.success ? '✅' : '❌'
    const duration = result.duration ? ` (${result.duration}秒)` : ''
    console.log(`  ${index + 1}. ${status} ${result.file}${duration}`)

    if (!result.success) {
      console.log(`     エラー: ${result.error}`)
    }
  })

  // テスト結果ファイルを生成
  const summary = {
    timestamp: new Date().toISOString(),
    totalDuration: parseFloat(totalDuration),
    totalTests: results.length,
    successful: successful,
    failed: failed,
    results: results,
  }

  const summaryFile = path.join(testResultsDir, 'test-summary.json')
  fs.writeFileSync(summaryFile, JSON.stringify(summary, null, 2))

  console.log(`\n📄 詳細結果は ${summaryFile} に保存されました`)

  // スクリーンショットの確認
  console.log('\n📸 生成されたスクリーンショット:')
  const screenshots = fs
    .readdirSync(testResultsDir)
    .filter((file) => file.endsWith('.png'))
    .sort()

  if (screenshots.length > 0) {
    screenshots.forEach((screenshot) => {
      console.log(`  - ${screenshot}`)
    })
  } else {
    console.log('  スクリーンショットは生成されませんでした')
  }

  // 終了コードを設定
  if (failed > 0) {
    console.log('\n❌ 一部のテストが失敗しました')
    process.exit(1)
  } else {
    console.log('\n🎉 すべてのテストが成功しました！')
    process.exit(0)
  }
}

// スクリプト実行
runAllTests().catch((error) => {
  console.error('💥 テスト実行中にエラーが発生しました:', error)
  process.exit(1)
})
