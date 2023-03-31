import 'package:stripe_sdk/stripe_sdk_ui.dart';

abstract class StripeRepository {
  // void stripeInstance();
  // void stripeApiInstance();
  void customerSession();
  // Tokenの発行
  // Future<String> createBankAccountToken({
  //   required String accountHolderName,
  //   required String accountHolderType,
  //   required String routingNumber,
  //   required String accountNumber,
  // });
  // Future<String> createAccountToken({required String xxx});
  // Future<String> createPersonToken({
  //   required String firstNameKana,
  //   required String firstNameKanji,
  //   required String lastNameKana,
  //   required String lastNameKanji,
  //   required String dob,
  //   required String addressKana,
  //   required String addressKanji,
  //   required String email,
  //   required String phone,
  //   required String verification,
  //   required String director,
  //   required String owner,
  //   required String representative,
  // });

  ////////////////////////////////////////////////////////////////
  // Customer
  // Customerの登録
  Future<String> createCustomer(String email);
  // Customerの呼び出し
  Future<Map<String, dynamic>> retrieveCustomer({required String customerId});
  // Customerの更新
  Future<Map<String, dynamic>> updateCustomer({
    required String customerId,
    required Map<String, dynamic> params,
  });
  // Customerの削除
  Future<void> deleteCustomer({required String customerId});
  //
  Future<String> getEphemeralKey();

  ////////////////////////////////////////////////////////////////
  // Account
  // Accountの登録
  Future<String> createAccount(String email);
  // Accountの呼び出し
  Future<String> retrieveAccount(String accountId);
  // Accountの更新
  Future<String> updateAccount({
    required String accountId,
    required Map<String, dynamic> params,
  });
  // Accountの削除
  Future<void> deleteAccount(String accountId);

  // AccountLinkの取得
  Future<String> getAccountLink(String accountId);

  ////////////////////////////////////////////////////////////////
  // 支払方法の登録
  // SetupIntents
  Future<IntentClientSecret> createSetupIntent();
  Future<IntentClientSecret> createSetupIntentWithPaymentMethod(
    paymentMethod,
    String? returnUrl,
  );
  Future<Map> retrieveSetupIntent(String clientSecret);
  Future<String> updateSetupIntent({
    required String clientSecret,
    required Map params,
  });
  Future<Map> confirmSetupIntent(String clientSecret);
  //
  // paymentMethod
  Future<Map> createPaymentMethod(Map params);
  Future<Map> createPaymentMethodFromCard(StripeCard card);
  Future<String> attachPaymentMethod(String paymentMethodId);
//
// checkout
  Future<Map> paymentCheckoutSession(
    String organizerId,
    String orderId,
    List lineItems,
  );
  Future<String> setupCheckoutSession();
  Future<Map<String, dynamic>> retrieveCheckoutSession(String sessionId);

  // 支払内容を登録する
  // paymentIntents
  // Future<IntentClientSecret> createCheckoutPaymentIntent();
  Future<IntentClientSecret> createPaymentIntent({Map? params});
  Future<IntentClientSecret> createAutomaticPaymentIntent({
    int? amount,
    String? returnUrl,
  });
  Future<Map?> createManualPaymentIntent(
    int amount,
    String paymentMethod,
    // String email,
    String returnUrl,
  );
  Future<Map> confirmPayment(
    String paymentId,
    String paymentMethodId,
  );
  //
  // 支払ステータスの確認
  Future<Map> retrievePaymentIntent({required String clientSecret});
  //
  Future<Map> confirmPaymentIntent({
    required String clientSecret,
    String? paymentMethodId,
  });

  //
  Future<Map> invoiceSetting(StripeCard card);
}
