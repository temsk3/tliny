import { exportFunctionsModule } from '../../utils/deploy'
import * as P from '../../utils/function_paths'

const domains = [
  'stripeAccount',
  // 'product',
  // 'payment',
  // 'invoiceSetting',
  'checkout',
  // 'ticket',
]

domains.forEach((d) => exportFunctionsModule([P.v1, P.method, d], exports))
