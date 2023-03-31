import { exportFunctionsModule } from '../../utils/deploy'
import * as P from '../../utils/function_paths'

const domains = [
  'payment',
  'stripeAccount',
  'product',
  'invoiceSetting',
  'checkout',
]

domains.forEach((d) => exportFunctionsModule([P.v1, P.method, d], exports))
