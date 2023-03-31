import functions from '../../../utils/base_function'
import { exportFunction } from '../../../utils/deploy'
import * as P from '../../../utils/function_paths'
import triggerOnce from '../../../utils/trigger_once'

const _exportFunction = (name: string, f: () => any): void =>
  exportFunction([P.v1, P.firestore, 'user', name], exports, f)

const path = '/v/{version}/users/{userID}'

// _exportFunction('onXxx', () =>
//   functions()
//     .firestore.document(path)
//     .onCreate(
//       // 冪等性の担保(eventIdの重複対策用function)
//       triggerOnce('xxxNotification', async (snapshot, context) => {
//         //
//         // 処理
//         //
//       })
//     )
// )

_exportFunction('onCreate', () =>
  functions()
    .firestore.document(path)
    .onCreate(
      // 冪等性の担保(eventIdの重複対策用function)
      triggerOnce('userCreateNotification', async (snapshot, context) => {
        //
        console.log(snapshot, context)
      })
    )
)

_exportFunction('onUpdate', () =>
  functions()
    .firestore.document(path)
    .onUpdate(
      triggerOnce('usersUpdateNotification', async (snapshot, context) => {
        //
        console.log(snapshot, context)
      })
    )
)
