// import * as firebaseAdmin from 'firebase-admin'
// // import { db } from '../../utils/firebase_utils'
// import functions from '../../utils/base_function'
// import { exportFunction } from '../../utils/deploy'
// import * as P from '../../utils/function_paths'
// import triggerOnce from '../../utils/trigger_once'
// import paths from './utils/db_paths'

// const path = '/v/{version}/users/{userId}/'
// const _exportFunction = (name: string, f: () => any): void =>
//   exportFunction([P.v1, P.firestore, 'ticket', name], exports, f)

// _exportFunction('onCreate', () =>
//   functions()
//     .firestore.document(
//       paths.usersCollectionPath + '/{userId}' + paths.ticketsCollectionPath
//     )
//     .onCreate(
//       // 冪等性の担保(eventIdの重複対策用function)
//       triggerOnce('ticketCreateNotification', async (snapshot, context) => {
//         // try {
//         console.log(snapshot, context)

//         await firebaseAdmin
//           .firestore()
//           .collection(paths.eventsCollectionPath)
//           .doc(snapshot.data().eventId)
//           .collection(paths.ticketsCollectionPath)
//           .doc(snapshot.id)
//           .create(snapshot.data())
//         // } catch (error: any) {
//         //   console.log('Ticket Create Error')
//         //   throw new Error(error.message)
//         // }
//       })
//     )
// )
// _exportFunction('onUpdate', () =>
//   functions()
//     .firestore.document(path)
//     .onCreate(
//       // 冪等性の担保(eventIdの重複対策用function)
//       triggerOnce('updateNotification', async (snapshot, context) => {
//         //

//         console.log(snapshot, context)
//       })
//     )
// )
