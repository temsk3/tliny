import { onCall } from '../../utils/base_function'
import { checkAuth } from '../../utils/firebase_utils'

// Business Product: Create
const businessProductOnCreate = onCall(async (request) => {
  checkAuth(request)
  return { result: 'Product created' }
})

// Business Product: Update
const businessProductOnUpdate = onCall(async (request) => {
  checkAuth(request)
  return { result: 'Product updated' }
})

// Business Product: Delete
const businessProductOnDelete = onCall(async (request) => {
  checkAuth(request)
  return { result: 'Product deleted' }
})

export {
  businessProductOnCreate as 'v2_business_product_onCreate',
  businessProductOnUpdate as 'v2_business_product_onUpdate',
  businessProductOnDelete as 'v2_business_product_onDelete',
}
