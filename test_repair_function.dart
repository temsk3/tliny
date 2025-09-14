import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StripeCustomerRepairTest {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 自分のStripe Customerを修復する
  Future<Map<String, dynamic>> repairMyStripeCustomer() async {
    try {
      print('🔧 自分のStripe Customer修復を開始...');

      final callable = _functions.httpsCallable('repairUserStripeCustomer');
      final result = await callable.call(<String, dynamic>{});

      print('✅ 修復結果: ${result.data}');
      return Map<String, dynamic>.from(result.data as Map);
    } catch (e) {
      print('❌ 修復エラー: $e');
      rethrow;
    }
  }

  /// 管理者として他のユーザーのStripe Customerを修復する
  Future<Map<String, dynamic>> repairOtherUserStripeCustomer(
    String targetUid,
  ) async {
    try {
      print('🔧 他のユーザーのStripe Customer修復を開始...');
      print('対象ユーザー: $targetUid');

      final callable = _functions.httpsCallable('repairUserStripeCustomer');
      final result = await callable.call(<String, dynamic>{'uid': targetUid});

      print('✅ 修復結果: ${result.data}');
      return Map<String, dynamic>.from(result.data as Map);
    } catch (e) {
      print('❌ 修復エラー: $e');
      rethrow;
    }
  }

  /// 管理者権限を設定する
  Future<Map<String, dynamic>> setAdminRole(
    String targetUid,
    bool isAdmin,
  ) async {
    try {
      print('👑 管理者権限設定を開始...');
      print('対象ユーザー: $targetUid, 管理者: $isAdmin');

      final callable = _functions.httpsCallable('setAdminRole');
      final result = await callable.call(<String, dynamic>{
        'uid': targetUid,
        'isAdmin': isAdmin,
      });

      print('✅ 管理者権限設定結果: ${result.data}');
      return Map<String, dynamic>.from(result.data as Map);
    } catch (e) {
      print('❌ 管理者権限設定エラー: $e');
      rethrow;
    }
  }

  /// 現在のユーザー情報を表示
  void showCurrentUserInfo() {
    final user = _auth.currentUser;
    if (user != null) {
      print('👤 現在のユーザー情報:');
      print('  UID: ${user.uid}');
      print('  Email: ${user.email}');
      print('  DisplayName: ${user.displayName}');
    } else {
      print('❌ ユーザーがログインしていません');
    }
  }

  /// 問題のあるユーザーを修復するテスト
  Future<void> testRepairBrokenUsers() async {
    print('🚀 問題ユーザー修復テストを開始');
    print('=====================================');

    // 問題のあるユーザーID（ログから特定）
    final brokenUsers = [
      'GCwiGHPGcqPcjvszdn4x79zITDo2', // temsk3@icloud.com
      'YhGZvpsWcMgxgbj746pQIV6FLLI2', // test@gmail.com
    ];

    for (final uid in brokenUsers) {
      print('\n🔧 ユーザー修復: $uid');
      try {
        await repairOtherUserStripeCustomer(uid);
        print('✅ 修復成功: $uid');
      } catch (e) {
        print('❌ 修復失敗: $uid - $e');
      }
    }

    print('=====================================');
    print('✅ 問題ユーザー修復テスト完了');
  }

  /// テスト実行
  Future<void> runTest() async {
    print('🚀 Stripe Customer修復テストを開始');
    print('=====================================');

    // 現在のユーザー情報を表示
    showCurrentUserInfo();
    print('');

    // 自分の修復をテスト
    try {
      await repairMyStripeCustomer();
    } catch (e) {
      print('自分の修復に失敗: $e');
    }

    print('=====================================');
    print('✅ テスト完了');
  }
}

// 使用例
void main() async {
  final test = StripeCustomerRepairTest();

  // 基本的なテスト
  await test.runTest();

  // 問題ユーザーの修復テスト（管理者権限が必要）
  // await test.testRepairBrokenUsers();
}
