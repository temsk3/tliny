import Stripe from 'stripe'
import { exportFunction } from '../../utils/deploy'
import { getStripe, stripeOptions, stripeErrors } from './utils'
import { onCall } from '../../utils/base_function'
import { checkAuth, getRequestingUserId } from '../../utils/firebase_utils'

const _exportFunction = (name: string, f: () => any): void =>
  exportFunction(['v2', 'payment', 'persons', name], exports, f)

_exportFunction('onCreate', () =>
  onCall(async (request) => {
    const uid = getRequestingUserId(request)
    const accountId: string = request.data.accountId
    const address = request.data.address
    const addressKana = request.data.address_kana
    const addressKanji = request.data.address_kanji
    const dob = request.data.dob
    const email = request.data.email
    const firstName = request.data.first_name
    const firstNameKana = request.data.first_name_kana
    const firstNameKanji = request.data.first_name_kanji
    const gender = request.data.gender
    const idNumber = request.data.id_number
    const lastName = request.data.last_name
    const lastNameKana = request.data.last_name_kana
    const lastNameKanji = request.data.last_name_kanji
    const maidenName = request.data.maiden_name
    const metadata = request.data.metadata
    const nationality = request.data.nationality
    const phone = request.data.phone
    const politicalExposure = request.data.political_exposure
    const registeredAddress = request.data.registered_address
    const relationship = request.data.relationship
    const ssnLast4 = request.data.ssn_last_4
    const verification = request.data.verification

    const params: Stripe.AccountCreatePersonParams = {
      address: address,
      address_kana: addressKana,
      address_kanji: addressKanji,
      dob: dob,
      email: email,
      first_name: firstName,
      first_name_kana: firstNameKana,
      first_name_kanji: firstNameKanji,
      gender: gender,
      id_number: idNumber,
      last_name: lastName,
      last_name_kana: lastNameKana,
      last_name_kanji: lastNameKanji,
      maiden_name: maidenName,
      metadata: metadata,
      nationality: nationality,
      phone: phone,
      political_exposure: politicalExposure,
      registered_address: registeredAddress,
      relationship: relationship,
      ssn_last_4: ssnLast4,
      verification: verification,
    }

    stripeOptions.idempotencyKey = `create_person_${uid}_${accountId}`

    return await getStripe()
      .accounts.createPerson(accountId, params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.Person>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)

_exportFunction('onRetrieve', () =>
  onCall(async (request) => {
    checkAuth(request)
    const uid = getRequestingUserId(request)
    const accountId: string = request.data.accountId
    const personId: string = request.data.personId
    const expand = request.data.expand

    const params: Stripe.AccountRetrievePersonParams = {
      expand: expand,
    }

    stripeOptions.idempotencyKey = `retrieve_person_${uid}_${accountId}_${personId}`

    return await getStripe()
      .accounts.retrievePerson(accountId, personId, params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.Person>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)

_exportFunction('onUpdate', () =>
  onCall(async (request) => {
    checkAuth(request)
    const uid = getRequestingUserId(request)
    const accountId: string = request.data.accountId
    const personId: string = request.data.personId
    const address = request.data.address
    const addressKana = request.data.address_kana
    const addressKanji = request.data.address_kanji
    const dob = request.data.dob
    const email = request.data.email
    const firstName = request.data.first_name
    const firstNameKana = request.data.first_name_kana
    const firstNameKanji = request.data.first_name_kanji
    const gender = request.data.gender
    const idNumber = request.data.id_number
    const lastName = request.data.last_name
    const lastNameKana = request.data.last_name_kana
    const lastNameKanji = request.data.last_name_kanji
    const maidenName = request.data.maiden_name
    const metadata = request.data.metadata
    const nationality = request.data.nationality
    const phone = request.data.phone
    const politicalExposure = request.data.political_exposure
    const registeredAddress = request.data.registered_address
    const relationship = request.data.relationship
    const ssnLast4 = request.data.ssn_last_4
    const verification = request.data.verification

    const params: Stripe.AccountUpdatePersonParams = {
      address: address,
      address_kana: addressKana,
      address_kanji: addressKanji,
      dob: dob,
      email: email,
      first_name: firstName,
      first_name_kana: firstNameKana,
      first_name_kanji: firstNameKanji,
      gender: gender,
      id_number: idNumber,
      last_name: lastName,
      last_name_kana: lastNameKana,
      last_name_kanji: lastNameKanji,
      maiden_name: maidenName,
      metadata: metadata,
      nationality: nationality,
      phone: phone,
      political_exposure: politicalExposure,
      registered_address: registeredAddress,
      relationship: relationship,
      ssn_last_4: ssnLast4,
      verification: verification,
    }

    stripeOptions.idempotencyKey = `update_person_${uid}_${accountId}_${personId}`

    return await getStripe()
      .accounts.updatePerson(accountId, personId, params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.Person>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)

_exportFunction('onDelete', () =>
  onCall(async (request) => {
    checkAuth(request)
    const uid = getRequestingUserId(request)
    const accountId: string = request.data.accountId
    const personId: string = request.data.personId

    stripeOptions.idempotencyKey = `delete_person_${uid}_${accountId}_${personId}`

    return await getStripe()
      .accounts.deletePerson(accountId, personId, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.DeletedPerson>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)

_exportFunction('onList', () =>
  onCall(async (request) => {
    checkAuth(request)
    const uid = getRequestingUserId(request)
    const accountId: string = request.data.accountId
    const limit = request.data.limit
    const startingAfter = request.data.starting_after
    const endingBefore = request.data.ending_before

    const params: Stripe.AccountListPersonsParams = {
      limit: limit,
      starting_after: startingAfter,
      ending_before: endingBefore,
    }

    stripeOptions.idempotencyKey = `list_persons_${uid}_${accountId}`

    return await getStripe()
      .accounts.listPersons(accountId, params, stripeOptions)
      .then(
        (result: Stripe.ApiList<Stripe.Person>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)
