import * as functions from 'firebase-functions'

// Firebase Functions Logger のラッパー
export const logger = {
  info: (message: string, data?: any) => {
    functions.logger.info(message, data)
  },
  warn: (message: string, data?: any) => {
    functions.logger.warn(message, data)
  },
  error: (message: string, data?: any) => {
    functions.logger.error(message, data)
  },
  debug: (message: string, data?: any) => {
    functions.logger.debug(message, data)
  },
}

/**
 * v2配下のメソッド用統一ログユーティリティ
 */
export class V2Logger {
  /**
   * メソッド開始ログ
   * @param methodName - メソッド名
   * @param params - パラメータ（オプション）
   */
  static start(methodName: string, params?: Record<string, any>): void {
    logger.info(`[V2] ${methodName} - START`, {
      methodName,
      params,
      timestamp: new Date().toISOString(),
    })
  }

  /**
   * メソッド成功ログ
   * @param methodName - メソッド名
   * @param result - 結果（オプション）
   */
  static success(methodName: string, result?: any): void {
    logger.info(`[V2] ${methodName} - SUCCESS`, {
      methodName,
      result,
      timestamp: new Date().toISOString(),
    })
  }

  /**
   * メソッド終了ログ
   * @param methodName - メソッド名
   * @param duration - 実行時間（ミリ秒）
   */
  static end(methodName: string, duration?: number): void {
    logger.info(`[V2] ${methodName} - END`, {
      methodName,
      duration,
      timestamp: new Date().toISOString(),
    })
  }

  /**
   * メソッドエラーログ
   * @param methodName - メソッド名
   * @param error - エラーオブジェクト
   * @param params - パラメータ（オプション）
   */
  static error(
    methodName: string,
    error: any,
    params?: Record<string, any>,
  ): void {
    logger.error(`[V2] ${methodName} - ERROR`, {
      methodName,
      error: error.message,
      stack: error.stack,
      params,
      timestamp: new Date().toISOString(),
    })
  }

  /**
   * メソッド警告ログ
   * @param methodName - メソッド名
   * @param message - 警告メッセージ
   * @param params - パラメータ（オプション）
   */
  static warn(
    methodName: string,
    message: string,
    params?: Record<string, any>,
  ): void {
    logger.warn(`[V2] ${methodName} - WARN`, {
      methodName,
      message,
      params,
      timestamp: new Date().toISOString(),
    })
  }

  /**
   * メソッド実行時間計測用デコレータ風関数
   * @param methodName - メソッド名
   * @param fn - 実行する関数
   * @param params - パラメータ（オプション）
   */
  static async measure<T>(
    methodName: string,
    fn: () => Promise<T>,
    params?: Record<string, any>,
  ): Promise<T> {
    const startTime = Date.now()

    try {
      this.start(methodName, params)
      const result = await fn()
      const duration = Date.now() - startTime

      this.success(methodName, result)
      this.end(methodName, duration)

      return result
    } catch (error: any) {
      const duration = Date.now() - startTime
      this.error(methodName, error, params)
      this.end(methodName, duration)
      throw error
    }
  }
}
