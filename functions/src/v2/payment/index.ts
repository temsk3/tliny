import { exportFunctionsModule } from '../../utils/deploy'
import * as P from '../../utils/function_paths'
const domains = [
  'account',
  'checkout',
  'customer',
  'payment_intent',
  'payment_method',
  'setup_intent',
  'external_accounts',
  'invoice_settings',
  'webhook',
  'persons',
]
// payment直下のファイルを直接エクスポート
domains.forEach((d) => exportFunctionsModule([P.v2, P.payment, d], exports))
