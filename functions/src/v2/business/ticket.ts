import { onCall } from '../../utils/base_function'
import { checkAuth } from '../../utils/firebase_utils'

// Business Ticket: Create
const businessTicketOnCreate = onCall(async (request) => {
  checkAuth(request)
  return { result: 'Ticket created' }
})

// Business Ticket: Update
const businessTicketOnUpdate = onCall(async (request) => {
  checkAuth(request)
  return { result: 'Ticket updated' }
})

// Business Ticket: Delete
const businessTicketOnDelete = onCall(async (request) => {
  checkAuth(request)
  return { result: 'Ticket deleted' }
})

export {
  businessTicketOnCreate as 'v2_business_ticket_onCreate',
  businessTicketOnUpdate as 'v2_business_ticket_onUpdate',
  businessTicketOnDelete as 'v2_business_ticket_onDelete',
}
