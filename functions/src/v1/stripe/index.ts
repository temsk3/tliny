import {exportFunctionsModule} from '../../utils/deploy';
import * as P from '../../utils/function_paths';

const domains = [
  // 'account_links',
  'account',
  'customer',
  // 'extrenal_accounts',
  // 'paymentIntent',
  // 'paymentMethod',
  // 'checkout',
  // 'persons',
  // 'setupIntent',
  'webhook',
];

domains.forEach((d) => exportFunctionsModule([P.v1, P.stripe, d], exports));
