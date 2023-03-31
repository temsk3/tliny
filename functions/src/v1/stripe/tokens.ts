// import * as f from 'firebase-functions'

// import functions from '../../utils/base_function'
// import { exportFunction } from '../../utils/deploy'
// import * as P from '../../utils/function_paths'

// import { stripe, stripePK } from './stripe'
// import stripeErrors from './stripe_error'

// const _exportFunction = (name: string, f: () => any) =>
//   exportFunction([P.v1, P.stripe, 'tokens', name], exports, f)

// // これらはフロント側で実装

// // MARK: Create a card token
// // 使用しない
// _exportFunction('createCardToken', () =>
//   functions().https.onCall(async (data, context) => {
//     // 認証済みユーザーかどうかチェックする
//     if (!context.auth || !context.auth.uid) {
//       throw new f.https.HttpsError(
//         'unauthenticated',
//         'User is not authenticated.'
//       )
//     }
//     const cardNumber = data.newCreditCard
//     const expMonth = data.expMonth
//     const expYear = data.expYear
//     const cvc = data.cvc
//     await stripe.tokens
//       .create({
//         card: {
//           number: cardNumber,
//           exp_month: expMonth,
//           exp_year: expYear,
//           cvc: cvc,
//         },
//       })
//       .then(
//         (result: any) => {
//           const cardToken = result.id
//           return cardToken
//         },
//         (error: any) => {
//           stripeErrors(error)
//         }
//       )
//   })
// )

// // MARK: Create a bank account token
// _exportFunction('createBankAccountToken', () =>
//   functions().https.onCall(async (data, context) => {
//     // 認証済みユーザーかどうかチェックする
//     if (!context.auth || !context.auth.uid) {
//       throw new f.https.HttpsError(
//         'unauthenticated',
//         'User is not authenticated.'
//       )
//     }
//     const country = data.country
//     const accountHolderName = data.accountHolderName
//     const accountHolderType = data.accountHolderType
//     const routingNumber = data.routing_number
//     const accountNumber = data.routing_number
//     await stripePK()
//       .tokens.create({
//         bank_account: {
//           country: country,
//           currency: 'jpy', // 日本円固定
//           account_holder_name: accountHolderName,
//           account_holder_type: accountHolderType,
//           routing_number: routingNumber,
//           account_number: accountNumber,
//         },
//       })
//       .then(
//         (result: any) => {
//           const bankToken = result.id
//           return bankToken
//         },
//         (error: any) => {
//           stripeErrors(error)
//         }
//       )
//   })
// )

// // MARK: Create an account token
// _exportFunction('createAccountToken', () =>
//   functions().https.onCall(async (data, context) => {
//     // 認証済みユーザーかどうかチェックする
//     if (!context.auth || !context.auth.uid) {
//       throw new f.https.HttpsError(
//         'unauthenticated',
//         'User is not authenticated.'
//       )
//     }
//     const businessType = data.businessType // 'individual' or 'company'
//     const country = 'JP' // 2-letter country code
//     if (businessType === 'individual') {
//       const tosShownAndAccepted = data.tosShownAndAccepted
//       await stripePK.tokens
//         .create({
//           account: {
//             business_type: businessType,
//             tos_shown_and_accepted: tosShownAndAccepted,
//           },
//         })
//         .then(
//           (result: any) => {
//             const accountToken = result.id
//             return accountToken
//           },
//           (error: any) => {
//             stripeErrors(error)
//           }
//         )
//     } else if (businessType === 'company') {
//       // 個人事業主
//       const structure = 'sole_proprietorship' // 法人の場合不要
//       const addressKana = {
//         country: country,
//         // 半角
//         postal_code: data.zipKana,
//         state: data.stateKana,
//         city: data.cityKana,
//         town: data.townKana,
//         line1: data.line1Kana,
//         line2: data.line2Kana,
//       }
//       const addressKanji = {
//         country: country,
//         // 全角
//         postal_code: data.zipKanji,
//         state: data.stateKanji,
//         city: data.cityKanji,
//         town: data.townKanji,
//         line1: data.line1Kanji,
//         line2: data.line2Kanji,
//       }
//       const phone = data.phone
//       // 法人
//       const companyName = data.companyName
//       const nameKana = data.nameKana
//       const nameKanji = data.nameKanji
//       const taxId = data.taxId
//       const verification = data.verification
//       const tosShownAndAccepted = data.tosShownAndAccepted
//       await stripePK.tokens
//         .create({
//           account: {
//             business_type: businessType,
//             company: {
//               structure: structure, // 個人事業主の場合のみ
//               name: companyName,
//               name_kana: nameKana,
//               name_kanji: nameKanji,
//               address_kana: addressKana,
//               address_kanji: addressKanji,
//               phone: phone,
//               tax_id: taxId,
//               verification: { document: verification },
//             },
//             tos_shown_and_accepted: tosShownAndAccepted,
//           },
//         })
//         .then(
//           (result: any) => {
//             const accountToken = result.id
//             return accountToken
//           },
//           (error: any) => {
//             stripeErrors(error)
//           }
//         )
//     } else {
//       return null
//     }
//   })
// )

// // MARK: Create a person token
// _exportFunction('createPersonToken', () =>
//   functions().https.onCall(async (data, context) => {
//     // 認証済みユーザーかどうかチェックする
//     if (!context.auth || !context.auth.uid) {
//       throw new f.https.HttpsError(
//         'unauthenticated',
//         'User is not authenticated.'
//       )
//     }
//     // director
//     const firstNameKana = data.firstNameKana
//     const firstNameKanji = data.firstNameKanji
//     const lastNameKana = data.lastNameKana
//     const lastNameKanji = data.lastNameKanji
//     const dob = { day: data.day, month: data.month, year: data.year }
//     const director = data.director // 'true' or 'false'

//     // representative
//     const country = 'JP' // 2-letter country code
//     const addressKana = {
//       country: country,
//       // 半角
//       postal_code: data.zipKana,
//       state: data.stateKana,
//       city: data.cityKana,
//       town: data.townKana,
//       line1: data.line1Kana,
//       line2: data.line2Kana,
//     }
//     const addressKanji = {
//       country: country,
//       // 全角
//       postal_code: data.zipKanji,
//       state: data.stateKanji,
//       city: data.cityKanji,
//       town: data.townKanji,
//       line1: data.line1Kanji,
//       line2: data.line2Kanji,
//     }
//     const email = data.email
//     const phone = data.phone
//     const verification = data.verification
//     const representative = data.representative // 'true' or 'false'
//     //
//     const owner = data.owner // 'true' or 'false'
//     await stripePK.tokens
//       .create({
//         person: {
//           first_name_kana: firstNameKana,
//           first_name_kanji: firstNameKanji,
//           last_name_kana: lastNameKana,
//           last_name_kanji: lastNameKanji,
//           dob: dob,
//           address_kana: addressKana,
//           address_kanji: addressKanji,
//           email: email,
//           phone: phone,
//           verification: { document: verification },
//           relationship: {
//             director: director,
//             owner: owner,
//             representative: representative,
//           },
//         },
//       })
//       .then(
//         (result: any) => {
//           const personToken = result.id
//           return personToken
//         },
//         (error: any) => {
//           stripeErrors(error)
//         }
//       )
//   })
// )
