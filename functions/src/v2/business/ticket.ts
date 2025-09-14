import { onCall, onRequest } from '../../utils/base_function'
import { checkAuth } from '../../utils/firebase_utils'
import { logger } from '../../utils/logger'

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

// 手動チケット作成用のHTTPエンドポイント（V1の関数を使用）
export const businessTicketCreateManually = onRequest(
  async (request, response) => {
    try {
      // APIキー認証
      const apiKey = request.headers['x-api-key']
      const expectedApiKey =
        process.env.MANUAL_TICKET_API_KEY || 'test-secret-key-123'

      if (apiKey !== expectedApiKey) {
        response.status(401).json({ error: 'Unauthorized' })
        return
      }

      const { orderId } = request.query

      if (!orderId || typeof orderId !== 'string') {
        response.status(400).json({ error: 'orderId is required' })
        return
      }

      logger.info(`Manual ticket creation requested for order: ${orderId}`)

      try {
        // V1のチケット作成関数を使用
        const { createTicketDocument } = await import(
          '../../v1/payment/webhook'
        )
        logger.info('V1 createTicketDocument function imported successfully')

        await createTicketDocument(orderId)
        logger.info('V1 createTicketDocument function executed successfully')
      } catch (importError) {
        logger.error('Failed to import or execute V1 function:', importError)
        throw importError
      }

      response.status(200).json({
        success: true,
        message: `Tickets created for order: ${orderId}`,
      })
    } catch (error) {
      logger.error('Manual ticket creation failed:', error)
      response.status(500).json({
        error: 'Failed to create tickets',
        details: error instanceof Error ? error.message : 'Unknown error',
      })
    }
  },
)

export {
  businessTicketOnCreate as 'v2_business_ticket_onCreate',
  businessTicketOnUpdate as 'v2_business_ticket_onUpdate',
  businessTicketOnDelete as 'v2_business_ticket_onDelete',
  businessTicketCreateManually as 'v2_business_ticket_createManually',
}
