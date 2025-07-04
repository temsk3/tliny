import { onCall } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import { BaseCrudController } from '../../utils/base_crud_controller'

/**
 * 商品のCRUD操作を行うコントローラー
 */
class ProductController extends BaseCrudController {
  protected collectionName = 'v/1/products'
  protected entityName = 'product'
}

const controller = new ProductController()

const _exportFunction = (name: string, f: () => any) =>
  exportFunction(['v2', 'business', name], exports, f)

// Create Product
_exportFunction('onCreate', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    // checkAuth(request);
    return await controller.create(request)
  }),
)

// Retrieve Product
_exportFunction('onRetrieve', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    // checkAuth(request);
    return await controller.retrieve(request)
  }),
)

// Update Product
_exportFunction('onUpdate', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    // checkAuth(request);
    return await controller.update(request)
  }),
)

// Delete Product
_exportFunction('onDelete', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    // checkAuth(request);
    return await controller.delete(request)
  }),
)
