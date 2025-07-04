import { exportFunctionsModule } from '../../utils/deploy'
import * as P from '../../utils/function_paths'

// v2のfirestoreドメインを定義
const domains = ['user', 'ticket', 'product', 'price']

// 各ドメインのモジュールをエクスポート
domains.forEach((d) => exportFunctionsModule([P.v2, P.firestore, d], exports))
