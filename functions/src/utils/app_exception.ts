/**
 * アプリケーション全体で使用する統一的な例外クラス
 */
export abstract class AppException extends Error {
  /**
   * @param {string} message エラーメッセージ
   * @param {string=} code エラーコード
   * @param {number=} statusCode HTTPステータスコード
   * @param {boolean=} isOperational 運用上のエラーかどうか
   */
  constructor(
    message: string,
    public code?: string,
    public statusCode: number = 500,
    public isOperational: boolean = true,
  ) {
    super(message)
    this.name = this.constructor.name
    Error.captureStackTrace(this, this.constructor)
  }

  /**
   * ユーザーフレンドリーなエラーメッセージを取得
   */
  get userMessage(): string {
    return this.message
  }
}

/**
 * ネットワーク関連のエラー
 */
export class NetworkException extends AppException {
  /**
   * @param {string} message エラーメッセージ
   * @param {string=} code エラーコード
   */
  constructor(message: string, code?: string) {
    super(message, code, 503)
  }
}

/**
 * 認証関連のエラー
 */
export class AuthenticationException extends AppException {
  /**
   * @param {string} message エラーメッセージ
   * @param {string=} code エラーコード
   */
  constructor(message: string, code?: string) {
    super(message, code, 401)
  }
}

/**
 * バリデーション関連のエラー
 */
export class ValidationException extends AppException {
  /**
   * @param {string} message エラーメッセージ
   * @param {string=} field バリデーションエラーが発生したフィールド
   * @param {string=} code エラーコード
   */
  constructor(
    message: string,
    public field?: string,
    code?: string,
  ) {
    super(message, code, 400)
  }
}

/**
 * 権限関連のエラー
 */
export class PermissionException extends AppException {
  /**
   * @param {string} message エラーメッセージ
   * @param {string=} code エラーコード
   */
  constructor(message: string, code?: string) {
    super(message, code, 403)
  }
}

/**
 * データベース関連のエラー
 */
export class DatabaseException extends AppException {
  /**
   * @param {string} message エラーメッセージ
   * @param {string=} code エラーコード
   */
  constructor(message: string, code?: string) {
    super(message, code, 500)
  }
}

/**
 * 決済関連のエラー
 */
export class PaymentException extends AppException {
  /**
   * @param {string} message エラーメッセージ
   * @param {string=} code エラーコード
   */
  constructor(message: string, code?: string) {
    super(message, code, 400)
  }
}

/**
 * リソースが見つからないエラー
 */
export class NotFoundException extends AppException {
  /**
   * @param {string} message エラーメッセージ
   * @param {string=} code エラーコード
   */
  constructor(message: string, code?: string) {
    super(message, code, 404)
  }
}

/**
 * その他の一般的なエラー
 */
export class GeneralException extends AppException {
  /**
   * @param {string} message エラーメッセージ
   * @param {string=} code エラーコード
   */
  constructor(message: string, code?: string) {
    super(message, code, 500)
  }
}

/**
 * Stripe関連のエラー
 */
export class StripeException extends AppException {
  /**
   * @param {string} message エラーメッセージ
   * @param {string=} code エラーコード
   */
  constructor(message: string, code?: string) {
    super(message, code, 400)
  }
}

/**
 * Firebase関連のエラー
 */
export class FirebaseException extends AppException {
  /**
   * @param {string} message エラーメッセージ
   * @param {string=} code エラーコード
   */
  constructor(message: string, code?: string) {
    super(message, code, 500)
  }
}
