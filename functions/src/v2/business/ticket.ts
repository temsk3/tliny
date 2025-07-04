import { onCall } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import { BaseCrudController } from '../../utils/base_crud_controller'
import { createTicketDocument } from './services/ticket.service'

/**
 * チケットのCRUD操作を行うコントローラー
 */
class TicketController extends BaseCrudController {
  protected collectionName = 'v/1/tickets'
  protected entityName = 'ticket'
}

const controller = new TicketController()

const _exportFunction = (name: string, f: () => any) =>
  exportFunction(['v2', 'business', name], exports, f)

// Create Ticket
_exportFunction('onCreate', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    // checkAuth(request);
    return await controller.create(request)
  }),
)

// Retrieve Ticket
_exportFunction('onRetrieve', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    // checkAuth(request);
    return await controller.retrieve(request)
  }),
)

// Update Ticket
_exportFunction('onUpdate', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    // checkAuth(request);
    return await controller.update(request)
  }),
)

// Delete Ticket
_exportFunction('onDelete', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    // checkAuth(request);
    return await controller.delete(request)
  }),
)

// Create Ticket Document (from order)
_exportFunction('onCreateFromOrder', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    // checkAuth(request);
    const orderId = request.data.orderId
    if (!orderId) {
      throw new Error('Order ID is required')
    }
    return await createTicketDocument(orderId)
  }),
)
