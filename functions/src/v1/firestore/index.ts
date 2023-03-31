import { exportFunctionsModule } from '../../utils/deploy'
import * as P from '../../utils/function_paths'

const domains = ['user', 'ticket']

domains.forEach((d) => exportFunctionsModule([P.v1, P.firestore, d], exports))
