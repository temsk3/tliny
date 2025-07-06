import { onCall } from '../../utils/base_function'
import { checkAuth } from '../../utils/firebase_utils'

// Business Order: Create
const businessOrderOnCreate = onCall(async (request) => {
  checkAuth(request)
  return { result: 'Order created' }
})

// Business Order: Update
const businessOrderOnUpdate = onCall(async (request) => {
  checkAuth(request)
  return { result: 'Order updated' }
})

// Business Order: Delete
const businessOrderOnDelete = onCall(async (request) => {
  checkAuth(request)
  return { result: 'Order deleted' }
})

export {
  businessOrderOnCreate as 'v2_business_order_onCreate',
  businessOrderOnUpdate as 'v2_business_order_onUpdate',
  businessOrderOnDelete as 'v2_business_order_onDelete',
}
