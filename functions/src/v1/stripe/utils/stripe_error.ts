const stripeErrors = (error: any): void => {
  switch (error.type) {
    case 'StripeCardError':
      // A declined card error
      // err.message; // => e.g. "Your card's expiration year is invalid."
      // console.log(`A payment error occurred: ${error.message}`);
      console.log(`支払いエラー: ${error.message}`);
      if (error.payment_intent.charges.data[0].outcome.type === 'blocked') {
        console.log('Payment blocked for suspected fraud.');
      } else if (error.code === 'card_declined') {
        console.log('Payment declined by the issuer.');
      } else if (error.code === 'expired_card') {
        console.log('Card expired.');
      } else {
        console.log('Other card error.');
      }
      break;
    case 'StripeInvalidRequestError':
      // Invalid parameters were supplied to Stripe's API
      console.log('An invalid request occurred.');
      console.log(`無効なリクエストエラー: ${error.message}`);
      if (error.param) {
        console.log(`The parameter ${error.param} is invalid or missing.`);
      }
      break;
    case 'StripeConnectionError':
      // Some kind of error occurred during the HTTPS communication
      console.log(`接続エラー: ${error.message}`);
      break;
    case 'StripeAPIError':
      // An error occurred internally with Stripe's API
      console.log(`API エラー: ${error.message}`);
      break;
    case 'StripeAuthenticationError':
      // You probably used an incorrect API key
      console.log(`認証エラー: ${error.message}`);
      break;
    case 'StripeIdempotencyError':
      // Too many requests made to the API too quickly
      console.log(`べき等エラー: ${error.message}`);
      break;
    case 'StripePermissionError':
      // Too many requests made to the API too quickly
      console.log(`権限エラー: ${error.message}`);
      break;
    case 'StripeRateLimitError':
      // Too many requests made to the API too quickly
      console.log(`レート制限エラー: ${error.message}`);
      break;
    case 'StripeSignatureVerificationError':
      // Too many requests made to the API too quickly
      console.log(`署名確認エラー: ${error.message}`);
      break;
    default:
      // Handle any other types of unexpected errors
      console.log(`An unexpected errors: ${error.message}`);
      break;
  }
};

export default stripeErrors;
