import * as firebaseAdmin from 'firebase-admin'

// import * as functions from "firebase-functions";

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info('Hello logs!', {structuredData: true});
//   response.send('Hello from Firebase!');
// });

// firebaseAdmin.initializeApp(functions.config().firebase);
firebaseAdmin.initializeApp()

// import * as order from "./order";
// import * as purchase from "./purchase";
// import * as stripe from "./stripe";
// import * as user from "./user";

// export { stripe, user, purchase, order };

//
import { exportFunctionsModule } from './utils/deploy'
import * as P from './utils/function_paths'

const domains = [P.v1]

domains.forEach((d) => exportFunctionsModule([d], exports))
