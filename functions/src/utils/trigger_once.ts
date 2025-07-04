import * as firebaseAdmin from 'firebase-admin'

// 冪等性の担保
const triggerOnce =
  <T>(
    suffix: string,
    handler: (data: T, context: any) => PromiseLike<any> | any,
  ): ((data: T, context: any) => PromiseLike<any> | any) =>
  async (data, context) => {
    if (await hasAlreadyTriggered(context.eventId, suffix)) {
      return undefined
    }
    const result = handler(data, context)
    hasAlreadyCompleted(context.eventId, suffix)
    return result
  }

export default triggerOnce

// 冪等性の担保(eventIdの重複対策用function)
const leaseTime = 60 * 1000 // 60s
const hasAlreadyTriggered = (
  eventID: string,
  suffix: string,
): Promise<boolean> => {
  const id = [eventID, suffix].join('-')
  // console.log(`EventID: ${id}`)
  return firebaseAdmin.firestore().runTransaction(async (t) => {
    const ref = firebaseAdmin.firestore().collection('triggerEvents').doc(id)
    return await t.get(ref).then((doc) => {
      if (doc.exists) {
        if (doc.get('result')) {
          console.log(`EventID: ${id} has already triggered.`)
          return true
        }
        if (new Date() < doc.get('leaseTime')) {
          console.log(`EventID: ${id} Lease already taken, try later.`)
          return Promise.reject(new Error('Lease already taken, try later.'))
        }
      }
      t.set(ref, {
        createTime: new Date(new Date().getTime()),
        leaseTime: new Date(new Date().getTime() + leaseTime),
      })
      return false
    })
  })
}

// 冪等性の担保(正常処理記録用function)
const hasAlreadyCompleted = (eventID: string, suffix: string) => {
  const id = [eventID, suffix].join('-')
  const ref = firebaseAdmin.firestore().collection('triggerEvents').doc(id)
  return ref.set({ result: true }, { merge: true })
}
