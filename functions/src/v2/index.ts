// V2 functions - direct exports
// Import all functions from their respective domains and export them directly

// Firestore functions
export {
  v2_firestore_product_onCreate,
  v2_firestore_product_onUpdate,
  v2_firestore_product_onDelete,
} from './firestore/product'

export {
  v2_firestore_price_onCreate,
  v2_firestore_price_onUpdate,
  v2_firestore_price_onDelete,
} from './firestore/price'

export {
  v2_firestore_ticket_onCreate,
  v2_firestore_ticket_onUpdate,
  v2_firestore_ticket_onDelete,
} from './firestore/ticket'

// Firestore user functions (Auth triggers) - 一時的にコメントアウト
// export * from './firestore/user'

// Auth functions
export {
  onUserCreatedTrigger,
  repairUserStripeCustomer,
  setAdminRole,
} from './auth/user'

// Business functions
export { v2_business_account_onCreate } from './business/account'

export {
  v2_business_ticket_onCreate,
  v2_business_ticket_onUpdate,
  v2_business_ticket_onDelete,
  v2_business_ticket_createManually,
} from './business/ticket'

export {
  v2_business_product_onCreate,
  v2_business_product_onUpdate,
  v2_business_product_onDelete,
} from './business/product'

export {
  v2_business_order_onCreate,
  v2_business_order_onUpdate,
  v2_business_order_onDelete,
} from './business/order'

// Payment functions
export {
  v2_payment_account_onCreate,
  v2_payment_account_onRetrieve,
  v2_payment_account_onUpdate,
  v2_payment_account_onDelete,
  v2_payment_account_onList,
  v2_payment_account_onCreateAccountLink,
  v2_payment_account_onUpdateAccountLink,
  v2_payment_account_onCreateLoginLink,
} from './payment/account'

export {
  v2_payment_checkout_onSetup,
  v2_payment_checkout_onSubscription,
  v2_payment_checkout_onListOfLineItems,
  v2_payment_checkout_createPaymentSession,
  v2_payment_checkout_retrieveSession,
  v2_payment_checkout_listLineItems,
  v2_payment_checkout_expireSession,
  v2_payment_checkout_listSessions,
  v2_payment_checkout_listSessionsByOrder,
  v2_payment_checkout_cancelOrder,
} from './payment/checkout'

export {
  v2_payment_customer_getEphemeralKey,
  v2_payment_customer_onCreate,
  v2_payment_customer_onRetrieve,
  v2_payment_customer_onUpdate,
  v2_payment_customer_onDelete,
  v2_payment_customer_onSearch,
} from './payment/customer'

export {
  v2_payment_payment_intent_onCreate,
  v2_payment_payment_intent_onRetrieve,
  v2_payment_payment_intent_onUpdate,
  v2_payment_payment_intent_onConfirm,
  v2_payment_payment_intent_onCancel,
  v2_payment_payment_intent_onCapture,
  v2_payment_payment_intent_onList,
  v2_payment_payment_intent_onCreateAutomatic,
  v2_payment_payment_intent_onCreateManual,
} from './payment/payment_intent'

export {
  v2_payment_setup_intent_onCreate,
  v2_payment_setup_intent_onRetrieve,
  v2_payment_setup_intent_onUpdate,
  v2_payment_setup_intent_onConfirm,
  v2_payment_setup_intent_onCancel,
  v2_payment_setup_intent_onList,
} from './payment/setup_intent'

export { v2_payment_webhook_onStripeWebhook } from './payment/webhook'

export {
  v2_payment_transfer_onCreate,
  v2_payment_transfer_onRetrieve,
  v2_payment_transfer_onUpdate,
  v2_payment_transfer_onList,
  v2_payment_transfer_onReverse,
} from './payment/transfer'

export {
  v2_payment_external_accounts_onCreate,
  v2_payment_external_accounts_onRetrieve,
  v2_payment_external_accounts_onUpdate,
  v2_payment_external_accounts_onDelete,
  v2_payment_external_accounts_onList,
} from './payment/external_accounts'

export {
  v2_payment_payment_method_onCreate,
  v2_payment_payment_method_onAttach,
  v2_payment_payment_method_onRetrieve,
  v2_payment_payment_method_onUpdate,
  v2_payment_payment_method_onDelete,
} from './payment/payment_method'

export {
  v2_payment_refund_onCreate,
  v2_payment_refund_onRetrieve,
  v2_payment_refund_onUpdate,
  v2_payment_refund_onList,
  v2_payment_refund_onCancel,
} from './payment/refund'

export {
  v2_payment_persons_onCreate,
  v2_payment_persons_onRetrieve,
  v2_payment_persons_onUpdate,
  v2_payment_persons_onDelete,
  v2_payment_persons_onList,
} from './payment/persons'

export {
  v2_payment_invoice_settings_onCreate,
  v2_payment_invoice_settings_onRetrieve,
  v2_payment_invoice_settings_onUpdate,
  v2_payment_invoice_settings_onDelete,
} from './payment/invoice_settings'

// Test functions
export {
  v2_test_function,
  v2_test_http_function,
  testRepairBrokenUsers,
} from './test'

// SNS functions
export {
  v2_sns_follow_createFollow,
  v2_sns_follow_deleteFollow,
  v2_sns_follow_getFollowers,
  v2_sns_follow_getFollowing,
} from './sns/follow'

export {
  v2_sns_post_createPost,
  v2_sns_post_getFeed,
  v2_sns_post_likePost,
  v2_sns_post_unlikePost,
} from './sns/post'

export {
  v2_sns_message_sendMessage,
  v2_sns_message_getConversations,
  v2_sns_message_getMessages,
} from './sns/message'

export {
  v2_sns_notification_getNotifications,
  v2_sns_notification_markAsRead,
  v2_sns_notification_markAllAsRead,
} from './sns/notification'

export {
  v2_sns_share_shareContent,
  v2_sns_share_generateShareUrl,
  v2_sns_share_getUserShares,
} from './sns/share'

export {
  v2_sns_profile_getProfile,
  v2_sns_profile_updateProfile,
  v2_sns_profile_getUserPosts,
  v2_sns_profile_checkFollowStatus,
} from './sns/profile'

export {
  v2_sns_search_searchUsers,
  v2_sns_search_searchPosts,
  v2_sns_search_searchAll,
} from './sns/search'

export {
  v2_sns_comment_createComment,
  v2_sns_comment_getComments,
  v2_sns_comment_deleteComment,
} from './sns/comment'
