import { onCall } from '../../utils/base_function'
import { getStripe, stripeOptions, stripeErrors } from './utils'
import { checkAuth, getRequestingUserId } from '../../utils/firebase_utils'
import Stripe from 'stripe'

// Create a Person
const personsOnCreate = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const accountId: string = (request.data as any).accountId
  const address = (request.data as any).address
  const addressKana = (request.data as any).address_kana
  const addressKanji = (request.data as any).address_kanji
  const dob = (request.data as any).dob
  const email = (request.data as any).email
  const firstName = (request.data as any).first_name
  const firstNameKana = (request.data as any).first_name_kana
  const firstNameKanji = (request.data as any).first_name_kanji
  const gender = (request.data as any).gender
  const idNumber = (request.data as any).id_number
  const lastName = (request.data as any).last_name
  const lastNameKana = (request.data as any).last_name_kana
  const lastNameKanji = (request.data as any).last_name_kanji
  const maidenName = (request.data as any).maiden_name
  const metadata = (request.data as any).metadata
  const nationality = (request.data as any).nationality
  const phone = (request.data as any).phone
  const politicalExposure = (request.data as any).political_exposure
  const registeredAddress = (request.data as any).registered_address
  const relationship = (request.data as any).relationship
  const ssnLast4 = (request.data as any).ssn_last_4
  const verification = (request.data as any).verification

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
})

// Retrieve a Person
const personsOnRetrieve = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const accountId: string = (request.data as any).accountId
  const personId: string = (request.data as any).personId
  const expand = (request.data as any).expand

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
})

// Update a Person
const personsOnUpdate = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const accountId: string = (request.data as any).accountId
  const personId: string = (request.data as any).personId
  const address = (request.data as any).address
  const addressKana = (request.data as any).address_kana
  const addressKanji = (request.data as any).address_kanji
  const dob = (request.data as any).dob
  const email = (request.data as any).email
  const firstName = (request.data as any).first_name
  const firstNameKana = (request.data as any).first_name_kana
  const firstNameKanji = (request.data as any).first_name_kanji
  const gender = (request.data as any).gender
  const idNumber = (request.data as any).id_number
  const lastName = (request.data as any).last_name
  const lastNameKana = (request.data as any).last_name_kana
  const lastNameKanji = (request.data as any).last_name_kanji
  const maidenName = (request.data as any).maiden_name
  const metadata = (request.data as any).metadata
  const nationality = (request.data as any).nationality
  const phone = (request.data as any).phone
  const politicalExposure = (request.data as any).political_exposure
  const registeredAddress = (request.data as any).registered_address
  const relationship = (request.data as any).relationship
  const ssnLast4 = (request.data as any).ssn_last_4
  const verification = (request.data as any).verification

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
})

// Delete a Person
const personsOnDelete = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const accountId: string = (request.data as any).accountId
  const personId: string = (request.data as any).personId

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
})

// List all Persons
const personsOnList = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const accountId: string = (request.data as any).accountId
  const limit = (request.data as any).limit
  const startingAfter = (request.data as any).starting_after
  const endingBefore = (request.data as any).ending_before

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
})

export {
  personsOnCreate as 'v2_payment_persons_onCreate',
  personsOnRetrieve as 'v2_payment_persons_onRetrieve',
  personsOnUpdate as 'v2_payment_persons_onUpdate',
  personsOnDelete as 'v2_payment_persons_onDelete',
  personsOnList as 'v2_payment_persons_onList',
}
