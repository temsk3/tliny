import { exportFunctionsModule } from '../utils/deploy'
import * as P from '../utils/function_paths'

// v2のドメインを定義
const domains = [P.business, P.payment, P.firestore]

// 各ドメインのモジュールをエクスポート
domains.forEach((d) => exportFunctionsModule([P.v2, d], exports))
