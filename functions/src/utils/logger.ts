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
