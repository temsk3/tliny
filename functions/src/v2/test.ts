import { onCall } from '../utils/base_function'
import { onRequest } from 'firebase-functions/v2/https'

// テスト用の簡単な関数
const testFunction = onCall(async (request) => {
  console.log('Test function called with data:', request.data)
  return {
    message: 'Test function executed successfully',
    timestamp: new Date().toISOString(),
    data: request.data,
  }
})

// 認証不要のHTTP関数（テスト用）
const testHttpFunction = onRequest(async (request, response) => {
  console.log('Test HTTP function called')

  // CORS設定
  response.set('Access-Control-Allow-Origin', '*')
  response.set('Access-Control-Allow-Methods', 'GET, POST')
  response.set('Access-Control-Allow-Headers', 'Content-Type')

  if (request.method === 'OPTIONS') {
    response.status(204).send('')
    return
  }

  response.json({
    message: 'Test HTTP function executed successfully',
    timestamp: new Date().toISOString(),
    method: request.method,
    data: request.body,
  })
})

export {
  testFunction as 'v2_test_function',
  testHttpFunction as 'v2_test_http_function',
}
