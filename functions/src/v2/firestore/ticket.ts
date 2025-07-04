import * as functions from 'firebase-functions/v1'
import { exportFunction } from '../../utils/deploy'
import triggerOnce from '../../utils/trigger_once'
import { logger } from '../../utils/logger'

const _exportFunction = (name: string, f: () => any): void =>
  exportFunction(['v2', 'firestore', 'ticket', name], exports, f)

// チケット関連のFirestoreトリガー関数
// 現在はコメントアウトされているため、基本的な構造のみ作成

// チケット作成時のFirestoreトリガー
_exportFunction('onCreate', () =>
  functions
    .runWith({
      memory: '512MB',
    })
    .region('asia-northeast1')
    .firestore.document('v/1/tickets/{ticketId}')
    .onCreate(
      triggerOnce('ticketCreateNotification', async (snapshot, context) => {
        logger.info('Ticket created', {
          ticketId: context.params.ticketId,
          data: snapshot.data(),
        })

        // チケット作成時の処理をここに追加
        // 例: メール通知、プッシュ通知など

        return
      }),
    ),
)

// チケット更新時のFirestoreトリガー
_exportFunction('onUpdate', () =>
  functions
    .runWith({
      memory: '512MB',
    })
    .region('asia-northeast1')
    .firestore.document('v/1/tickets/{ticketId}')
    .onUpdate(
      triggerOnce('ticketUpdateNotification', async (change, context) => {
        const beforeData = change.before.data()
        const afterData = change.after.data()

        logger.info('Ticket updated', {
          ticketId: context.params.ticketId,
          before: beforeData,
          after: afterData,
        })

        // チケット更新時の処理をここに追加
        // 例: ステータス変更時の通知など

        return
      }),
    ),
)

// チケット削除時のFirestoreトリガー
_exportFunction('onDelete', () =>
  functions
    .runWith({
      memory: '512MB',
    })
    .region('asia-northeast1')
    .firestore.document('v/1/tickets/{ticketId}')
    .onDelete(
      triggerOnce('ticketDeleteNotification', async (snapshot, context) => {
        logger.info('Ticket deleted', {
          ticketId: context.params.ticketId,
          data: snapshot.data(),
        })

        // チケット削除時の処理をここに追加
        // 例: 関連データのクリーンアップなど

        return
      }),
    ),
)
