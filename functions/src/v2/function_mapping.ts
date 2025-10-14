// v1からv2への関数名マッピング
export const functionMapping = {
  // Checkout
  'v1-payment-stripe-checkout-createPaymentSession':
    'v2-payment-checkout-createPaymentSession',
  'v1-payment-stripe-checkout-retrieveSession':
    'v2-payment-checkout-retrieveSession',
  'v1-payment-stripe-checkout-cancelOrder': 'v2-payment-checkout-cancelOrder',

  // Account
  'v1-payment-stripe-account-controller-createLoginLink':
    'v2-payment-account-onCreateLoginLink',
  'v1-payment-stripe-account-testAccountType': 'v2-payment-account-onRetrieve',
  'v1-business-account-controller-createOrUpdateAccount':
    'v2-payment-account-onCreateAccountLink',

  // Customer
  'v1-payment-stripe-customer-customer-onCreate':
    'v2-payment-customer-onCreate',
  'v1-payment-stripe-customer-customer-onRetrieve':
    'v2-payment-customer-onRetrieve',
  'v1-payment-stripe-customer-customer-onUpdate':
    'v2-payment-customer-onUpdate',
  'v1-payment-stripe-customer-customer-onDelete':
    'v2-payment-customer-onDelete',

  // Payment Intent
  'v1-payment-stripe-paymentIntent-paymentIntent-onCreate':
    'v2-payment-payment-intent-onCreate',
  'v1-payment-stripe-paymentIntent-paymentIntent-onRetrieve':
    'v2-payment-payment-intent-onRetrieve',
  'v1-payment-stripe-paymentIntent-paymentIntent-onUpdate':
    'v2-payment-payment-intent-onUpdate',
  'v1-payment-stripe-paymentIntent-paymentIntent-onCancel':
    'v2-payment-payment-intent-onCapture',

  // Payment Method
  'v1-payment-stripe-paymentMethod-paymentMethod-onCreate':
    'v2-payment-payment-method-onCreate',
  'v1-payment-stripe-paymentMethod-paymentMethod-onRetrieve':
    'v2-payment-payment-method-onRetrieve',
  'v1-payment-stripe-paymentMethod-paymentMethod-onUpdate':
    'v2-payment-payment-method-onUpdate',
  'v1-payment-stripe-paymentMethod-paymentMethod-onDelete':
    'v2-payment-payment-method-onDelete',

  // Setup Intent
  'v1-payment-stripe-setupIntent-setupIntent-onCreate':
    'v2-payment-setup-intent-onCreate',
  'v1-payment-stripe-setupIntent-setupIntent-onRetrieve':
    'v2-payment-setup-intent-onRetrieve',
  'v1-payment-stripe-setupIntent-setupIntent-onCancel':
    'v2-payment-setup-intent-onCancel',

  // External Accounts
  'v1-payment-stripe-externalAccounts-externalAccounts-onCreate':
    'v2-payment-external-accounts-onCreate',
  'v1-payment-stripe-externalAccounts-externalAccounts-onRetrieve':
    'v2-payment-external-accounts-onRetrieve',
  'v1-payment-stripe-externalAccounts-externalAccounts-onUpdate':
    'v2-payment-external-accounts-onUpdate',
  'v1-payment-stripe-externalAccounts-externalAccounts-onDelete':
    'v2-payment-external-accounts-onDelete',

  // Invoice Settings
  'v1-payment-stripe-invoiceSettings-invoiceSetting-onCreate':
    'v2-payment-invoice-settings-onCreate',
  'v1-payment-stripe-invoiceSettings-invoiceSetting-onRetrieve':
    'v2-payment-invoice-settings-onRetrieve',
  'v1-payment-stripe-invoiceSettings-invoiceSetting-onUpdate':
    'v2-payment-invoice-settings-onUpdate',
  'v1-payment-stripe-invoiceSettings-invoiceSetting-onDelete':
    'v2-payment-invoice-settings-onDelete',

  // Business Account
  'v1-business-account-account-onCreate': 'v2-business-account-onCreate',
  'v1-business-account-account-onRetrieve': 'v2-business-account-onRetrieve',
  'v1-business-account-account-onUpdate': 'v2-business-account-onUpdate',
  'v1-business-account-account-onDelete': 'v2-business-account-onDelete',

  // Business Product
  'v1-business-product-product-onCreate': 'v2-business-product-onCreate',
  'v1-business-product-product-onRetrieve': 'v2-business-product-onRetrieve',
  'v1-business-product-product-onUpdate': 'v2-business-product-onUpdate',
  'v1-business-product-product-onDelete': 'v2-business-product-onDelete',

  // Business Order
  'v1-business-order-order-onCreate': 'v2-business-order-onCreate',
  'v1-business-order-order-onRetrieve': 'v2-business-order-onRetrieve',
  'v1-business-order-order-onUpdate': 'v2-business-order-onUpdate',
  'v1-business-order-order-onDelete': 'v2-business-order-onDelete',

  // Business Ticket
  'v1-business-ticket-ticket-onCreate': 'v2-business-ticket-onCreate',
  'v1-business-ticket-ticket-onRetrieve': 'v2-business-ticket-onRetrieve',
  'v1-business-ticket-ticket-onUpdate': 'v2-business-ticket-onUpdate',
  'v1-business-ticket-ticket-onDelete': 'v2-business-ticket-onDelete',

  // Firestore Price
  'v1-firestore-price-onCreate': 'v2-firestore-price-onCreate',
  'v1-firestore-price-onUpdate': 'v2-firestore-price-onUpdate',
  'v1-firestore-price-onDelete': 'v2-firestore-price-onDelete',

  // Firestore User
  'v1-firestore-user-onCreateStripeCustomer':
    'v2-firestore-user-onCreateStripeCustomer',
  'v1-firestore-user-onDeleteStripeCustomer':
    'v2-firestore-user-onDeleteStripeCustomer',

  // Firestore Product
  'v1-firestore-product-onCreate': 'v2-firestore-product-onCreate',
  'v1-firestore-product-onUpdate': 'v2-firestore-product-onUpdate',
  'v1-firestore-product-onDelete': 'v2-firestore-product-onDelete',

  // Firestore Ticket
  'v1-firestore-ticket-onCreate': 'v2-firestore-ticket-onCreate',
  'v1-firestore-ticket-onUpdate': 'v2-firestore-ticket-onUpdate',
  'v1-firestore-ticket-onDelete': 'v2-firestore-ticket-onDelete',

  // Payment Webhook
  'v1-stripe-webhook-handleWebhookEvents':
    'v2-payment-webhook-handleWebhookEvents',

  // Payment Tokens
  'v1-stripe-tokens-createCardToken': 'v2-payment-tokens-createCardToken',
  'v1-stripe-tokens-createBankAccountToken':
    'v2-payment-tokens-createBankAccountToken',
  'v1-stripe-tokens-createAccountToken': 'v2-payment-tokens-createAccountToken',
  'v1-stripe-tokens-createPersonToken': 'v2-payment-tokens-createPersonToken',

  // Payment Persons
  'v1-stripe-persons-persons-onCreate': 'v2-payment-persons-onCreate',
  'v1-stripe-persons-persons-onRetrieve': 'v2-payment-persons-onRetrieve',
  'v1-stripe-persons-persons-onUpdate': 'v2-payment-persons-onUpdate',
  'v1-stripe-persons-persons-onDelete': 'v2-payment-persons-onDelete',

  // Business Clone Customer
  'v1-method-cloneCustomer': 'v2-business-cloneCustomer',

  // Auth User Repair
  'v1-auth-user-repairStripeCustomer': 'repairUserStripeCustomer',
}
