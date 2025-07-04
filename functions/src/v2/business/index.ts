import { exportFunctionsModule } from '../../utils/deploy'
import { getCartItemsDebug } from './services/order.service'
import * as P from '../../utils/function_paths'

const domains = ['account', 'order', 'product', 'ticket']
// payment直下のファイルを直接エクスポート
domains.forEach((d) => exportFunctionsModule([P.v2, P.business, d], exports))

// デバッグ用関数をエクスポート
export { getCartItemsDebug }
