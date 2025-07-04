import { ErrorHandler } from './error_handler'

/**
 * 共通エラーハンドリングデコレーター
 * @param context - エラーコンテキスト（ファイル名や関数名）
 * @return デコレーター関数
 */
export const withErrorHandling = (context: string) => {
  return (
    target: unknown,
    propertyName: string,
    descriptor: PropertyDescriptor,
  ) => {
    const method = descriptor.value

    descriptor.value = async function (...args: unknown[]) {
      try {
        return await method.apply(this, args)
      } catch (error: unknown) {
        ErrorHandler.logError(error, (error as Error).stack, context)
        const appEx = ErrorHandler.convertToAppException(error, context)
        throw ErrorHandler.convertToHttpsError(appEx)
      }
    }
  }
}
