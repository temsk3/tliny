import { exportFunctionsModule } from '../utils/deploy'
import * as P from '../utils/function_paths'

const domains = [P.stripe, P.firestore, P.method]

domains.forEach((d) => exportFunctionsModule([P.v1, d], exports))
