import { onCall } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import { BaseCrudController } from '../../utils/base_crud_controller'
import {
  createPreOrder,
  cancelOrder,
  sendBackCartItem,
} from './services/order.service'

/**
 * 注文のCRUD操作を行うコントローラー
 */
class OrderController extends BaseCrudController {
  protected collectionName = 'v/1/orders'
  protected entityName = 'order'
}

const controller = new OrderController()

const _exportFunction = (name: string, f: () => any) =>
  exportFunction(['v2', 'business', name], exports, f)

// Create Order
_exportFunction('onCreate', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    // checkAuth(request);
    return await controller.create(request)
  }),
)

// Retrieve Order
_exportFunction('onRetrieve', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    // checkAuth(request);
    return await controller.retrieve(request)
  }),
)

// Update Order
_exportFunction('onUpdate', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    // checkAuth(request);
    return await controller.update(request)
  }),
)

// Delete Order
_exportFunction('onDelete', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    // checkAuth(request);
    return await controller.delete(request)
  }),
)

// Create Pre-Order (from v1)
_exportFunction('onCreatePreOrder', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    // checkAuth(request);
    const userId = request.data.userId
    const eventId = request.data.eventId

    if (!userId || !eventId) {
      throw new Error('User ID and Event ID are required')
    }

    return await createPreOrder(userId, eventId)
  }),
)

// Cancel Order (from v1)
_exportFunction('onCancelOrder', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    // checkAuth(request);
    const orderId = request.data.orderId

    if (!orderId) {
      throw new Error('Order ID is required')
    }

    return await cancelOrder(orderId)
  }),
)

// Send Back Cart Item (from v1)
_exportFunction('onSendBackCartItem', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    // checkAuth(request);
    const userId = request.data.userId
    const orderItems = request.data.orderItems

    if (!userId || !orderItems) {
      throw new Error('User ID and Order Items are required')
    }

    return await sendBackCartItem(userId, orderItems)
  }),
)
