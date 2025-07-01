import 'package:flutter_test/flutter_test.dart';
import 'package:tliny/src/data/model/exception/app_exception.dart';

void main() {
  group('AppException', () {
    test('NetworkExceptionのメッセージと型', () {
      const e = NetworkException(message: 'ネットワークエラー', code: 'net-001');
      expect(e, isA<AppException>());
      expect(e, isA<NetworkException>());
      expect(e.message, 'ネットワークエラー');
      expect(e.code, 'net-001');
      expect(e.userMessage, 'ネットワークエラー');
    });

    test('AuthenticationExceptionのメッセージ', () {
      const e = AuthenticationException(message: '認証エラー');
      expect(e.message, '認証エラー');
      expect(e.userMessage, '認証エラー');
    });

    test('ValidationExceptionのフィールド', () {
      const e = ValidationException(message: 'バリデーションエラー', field: 'email');
      expect(e.field, 'email');
      expect(e.message, 'バリデーションエラー');
    });

    test('PermissionExceptionの型', () {
      const e = PermissionException(message: '権限エラー');
      expect(e, isA<AppException>());
      expect(e, isA<PermissionException>());
    });

    test('DatabaseExceptionの型', () {
      const e = DatabaseException(message: 'DBエラー');
      expect(e, isA<DatabaseException>());
    });

    test('PaymentExceptionの型', () {
      const e = PaymentException(message: '決済エラー');
      expect(e, isA<PaymentException>());
    });

    test('GeneralExceptionの型', () {
      const e = GeneralException(message: '一般エラー');
      expect(e, isA<GeneralException>());
    });

    test('toStringはuserMessageを返す', () {
      const e = GeneralException(message: '表示用メッセージ');
      expect(e.toString(), '表示用メッセージ');
    });
  });
}
