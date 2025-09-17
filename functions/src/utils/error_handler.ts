import { logger } from 'firebase-functions'
import { HttpsError } from 'firebase-functions/v2/https'
import {
  AppException,
  GeneralException,
  StripeException,
  FirebaseException,
  ValidationException,
  AuthenticationException,
  PermissionException,
  NotFoundException,
  DatabaseException,
  PaymentException,
} from './app_exception'

/**
 * 統一されたエラーハンドリング機能を提供するユーティリティクラス
 */
export class ErrorHandler {
  /**
   * エラーメッセージを取得（AppExceptionの場合はuserMessageを優先）
   * @param error エラーオブジェクト
   * @return エラーメッセージ
   */
  static getErrorMessage(error: unknown): string {
    if (error instanceof AppException) {
      return error.userMessage
    }

    // エラー文字列の解析
    const errorString = typeof error === 'string' ? error : String(error)

    // 在庫不足エラー
    if (errorString.includes('less stock than the quantity')) {
      return '商品の在庫が不足しています。数量を調整してから再度お試しください。'
    }

    // ネットワークエラー
    if (errorString.includes('network') || errorString.includes('connection')) {
      return 'ネットワークエラーが発生しました。インターネット接続を確認してから再度お試しください。'
    }

    // 認証エラー
    if (errorString.includes('auth') || errorString.includes('unauthorized')) {
      return '認証エラーが発生しました。再度ログインしてください。'
    }

    // 決済エラー
    if (errorString.includes('payment') || errorString.includes('stripe')) {
      return '決済処理でエラーが発生しました。しばらく時間をおいてから再度お試しください。'
    }

    // サーバーエラー
    if (errorString.includes('server') || errorString.includes('500')) {
      return 'サーバーエラーが発生しました。しばらく時間をおいてから再度お試しください。'
    }

    // タイムアウトエラー
    if (errorString.includes('timeout') || errorString.includes('ETIMEDOUT')) {
      return 'リクエストがタイムアウトしました。しばらく時間をおいてから再度お試しください。'
    }

    // デフォルトエラーメッセージ
    return '予期しないエラーが発生しました。しばらく時間をおいてから再度お試しください。'
  }

  /**
   * エラーをログに出力
   * @param error エラーオブジェクト
   * @param stackTrace スタックトレース
   * @param context コンテキスト情報
   */
  static logError(
    error: unknown,
    stackTrace?: unknown,
    context?: string,
  ): void {
    const errorMessage =
      error instanceof AppException ? error.message : String(error)
    const contextInfo = context ? ` [${context}]` : ''

    logger.error(`Error${contextInfo}: ${errorMessage}`, {
      error: error,
      stackTrace: stackTrace,
      timestamp: new Date().toISOString(),
    })
  }

  /**
   * エラーをAppExceptionに変換
   * @param error エラーオブジェクト
   * @param context コンテキスト情報
   * @return AppException
   */
  static convertToAppException(
    error: unknown,
    _context?: string,
  ): AppException {
    // 既にAppExceptionの場合はそのまま返す
    if (error instanceof AppException) {
      return error
    }

    const errorString = typeof error === 'string' ? error : String(error)

    // Stripeエラー
    if (errorString.includes('stripe') || errorString.includes('Stripe')) {
      return new StripeException(
        this.getErrorMessage(error),
        (error as { code?: string }).code || 'STRIPE_ERROR',
      )
    }

    // Firebaseエラー
    if (errorString.includes('firebase') || errorString.includes('Firebase')) {
      return new FirebaseException(
        this.getErrorMessage(error),
        (error as { code?: string }).code || 'FIREBASE_ERROR',
      )
    }

    // 認証エラー
    if (errorString.includes('auth') || errorString.includes('unauthorized')) {
      return new AuthenticationException(
        this.getErrorMessage(error),
        (error as { code?: string }).code || 'AUTH_ERROR',
      )
    }

    // 権限エラー
    if (
      errorString.includes('permission') ||
      errorString.includes('forbidden')
    ) {
      return new PermissionException(
        this.getErrorMessage(error),
        (error as { code?: string }).code || 'PERMISSION_ERROR',
      )
    }

    // データベースエラー
    if (errorString.includes('database') || errorString.includes('firestore')) {
      return new DatabaseException(
        this.getErrorMessage(error),
        (error as { code?: string }).code || 'DATABASE_ERROR',
      )
    }

    // 決済エラー
    if (errorString.includes('payment')) {
      return new PaymentException(
        this.getErrorMessage(error),
        (error as { code?: string }).code || 'PAYMENT_ERROR',
      )
    }

    // 見つからないエラー
    if (errorString.includes('not found') || errorString.includes('404')) {
      return new NotFoundException(
        this.getErrorMessage(error),
        (error as { code?: string }).code || 'NOT_FOUND_ERROR',
      )
    }

    // バリデーションエラー
    if (errorString.includes('validation') || errorString.includes('invalid')) {
      return new ValidationException(
        this.getErrorMessage(error),
        undefined,
        (error as { code?: string }).code || 'VALIDATION_ERROR',
      )
    }

    // デフォルトはGeneralException
    return new GeneralException(
      this.getErrorMessage(error),
      (error as { code?: string }).code || 'GENERAL_ERROR',
    )
  }

  /**
   * AppExceptionをHttpsErrorに変換
   */
  static convertToHttpsError(appException: AppException): HttpsError {
    return new HttpsError(
      this.getHttpsErrorCode(appException),
      appException.userMessage,
      {
        code: appException.code,
        originalMessage: appException.message,
      },
    )
  }

  /**
   * AppExceptionのステータスコードをHttpsErrorのコードに変換
   */
  private static getHttpsErrorCode(
    appException: AppException,
  ):
    | 'invalid-argument'
    | 'unauthenticated'
    | 'permission-denied'
    | 'not-found'
    | 'already-exists'
    | 'resource-exhausted'
    | 'cancelled'
    | 'internal'
    | 'unimplemented'
    | 'unavailable'
    | 'deadline-exceeded' {
    switch (appException.statusCode) {
      case 400:
        return 'invalid-argument'
      case 401:
        return 'unauthenticated'
      case 403:
        return 'permission-denied'
      case 404:
        return 'not-found'
      case 409:
        return 'already-exists'
      case 429:
        return 'resource-exhausted'
      case 499:
        return 'cancelled'
      case 500:
        return 'internal'
      case 501:
        return 'unimplemented'
      case 503:
        return 'unavailable'
      case 504:
        return 'deadline-exceeded'
      default:
        return 'internal'
    }
  }

  /**
   * エラーハンドリング付きで非同期処理を実行
   */
  static async executeWithErrorHandling<T>(
    operation: () => Promise<T>,
    context?: string,
  ): Promise<T> {
    try {
      return await operation()
    } catch (error: any) {
      // エラーをログに出力
      this.logError(error, error.stack, context)

      // AppExceptionに変換
      const appException = this.convertToAppException(error, context)

      // HttpsErrorに変換してスロー
      throw this.convertToHttpsError(appException)
    }
  }
}

/**
 * エラーハンドリング用のデコレーター
 */
export function withErrorHandling(context?: string) {
  return function (
    target: any,
    propertyName: string,
    descriptor: PropertyDescriptor,
  ) {
    const method = descriptor.value

    descriptor.value = async function (...args: any[]) {
      try {
        return await method.apply(this, args)
      } catch (error: any) {
        ErrorHandler.logError(error, error.stack, context || propertyName)
        const appException = ErrorHandler.convertToAppException(
          error,
          context || propertyName,
        )
        throw ErrorHandler.convertToHttpsError(appException)
      }
    }
  }
}
