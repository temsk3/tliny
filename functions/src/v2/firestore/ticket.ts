import { onCall } from '../../utils/base_function'
import { checkAuth } from '../../utils/firebase_utils'

// Firestore Ticket: Create
const firestoreTicketOnCreate = onCall(async (request) => {
  checkAuth(request)
  return { result: 'Firestore ticket created' }
})

// Firestore Ticket: Update
const firestoreTicketOnUpdate = onCall(async (request) => {
  checkAuth(request)
  return { result: 'Firestore ticket updated' }
})

// Firestore Ticket: Delete
const firestoreTicketOnDelete = onCall(async (request) => {
  checkAuth(request)
  return { result: 'Firestore ticket deleted' }
})

export {
  firestoreTicketOnCreate as 'v2_firestore_ticket_onCreate',
  firestoreTicketOnUpdate as 'v2_firestore_ticket_onUpdate',
  firestoreTicketOnDelete as 'v2_firestore_ticket_onDelete',
}
