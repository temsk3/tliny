# SNS 統合 EC アプリケーション セキュリティ詳細設計書

ドキュメントバージョン: 1.0  
作成日: 2025 年 1 月 21 日  
更新日: 2025 年 1 月 21 日

## 目次

1. [セキュリティ要件](#1-セキュリティ要件)
2. [認証・認可](#2-認証認可)
3. [データ保護](#3-データ保護)
4. [通信セキュリティ](#4-通信セキュリティ)
5. [入力検証](#5-入力検証)
6. [セキュリティ監視](#6-セキュリティ監視)
7. [インシデント対応](#7-インシデント対応)

---

## 1. セキュリティ要件

### 1.1 セキュリティ目標

- **機密性**: 個人情報・決済情報の適切な保護
- **完全性**: データの改ざん防止
- **可用性**: サービス継続性の確保
- **認証**: 適切なユーザー認証
- **認可**: 適切なアクセス制御

### 1.2 脅威モデル

| 脅威 | 影響度 | 対策 |
|------|--------|------|
| **認証バイパス** | 高 | 多要素認証・セッション管理 |
| **データ漏洩** | 高 | 暗号化・アクセス制御 |
| **決済詐欺** | 高 | Stripe統合・監視 |
| **XSS攻撃** | 中 | 入力検証・出力エスケープ |
| **CSRF攻撃** | 中 | トークン検証 |
| **SQLインジェクション** | 中 | パラメータ化クエリ |

---

## 2. 認証・認可

### 2.1 Firebase Authentication

```dart
// lib/core/auth/firebase_auth_service.dart
@riverpod
class FirebaseAuthService extends _$FirebaseAuthService {
  @override
  Future<User?> build() async {
    return _getCurrentUser();
  }

  Future<User?> _getCurrentUser() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return null;

    // カスタムクレームの検証
    await firebaseUser.reload();
    final customClaims = firebaseUser.customClaims;
    
    return User(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName ?? '',
      accountType: customClaims?['accountType'] ?? 'personal',
      isEmailVerified: firebaseUser.emailVerified,
    );
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String displayName,
    required String accountType,
  }) async {
    // パスワード強度チェック
    _validatePasswordStrength(password);
    
    // メールアドレス形式チェック
    _validateEmailFormat(email);

    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // プロフィール更新
    await credential.user?.updateDisplayName(displayName);

    // カスタムクレーム設定
    await _setCustomClaims(credential.user!.uid, accountType);

    // メール認証送信
    await credential.user?.sendEmailVerification();

    return credential;
  }

  void _validatePasswordStrength(String password) {
    if (password.length < 8) {
      throw AuthException('パスワードは8文字以上である必要があります');
    }
    
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]').hasMatch(password)) {
      throw AuthException('パスワードは大文字・小文字・数字・記号を含む必要があります');
    }
  }

  void _validateEmailFormat(String email) {
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      throw AuthException('有効なメールアドレスを入力してください');
    }
  }

  Future<void> _setCustomClaims(String uid, String accountType) async {
    // Cloud Functions経由でカスタムクレーム設定
    final functions = FirebaseFunctions.instance;
    await functions.httpsCallable('setCustomClaims').call({
      'uid': uid,
      'accountType': accountType,
    });
  }
}
```

### 2.2 セッション管理

```dart
// lib/core/auth/session_manager.dart
@riverpod
class SessionManager extends _$SessionManager {
  Timer? _sessionTimer;
  
  @override
  SessionState build() {
    return SessionState(
      isActive: false,
      lastActivity: null,
      expiresAt: null,
    );
  }

  void startSession() {
    state = SessionState(
      isActive: true,
      lastActivity: DateTime.now(),
      expiresAt: DateTime.now().add(Duration(hours: 24)),
    );

    // セッションタイマーの開始
    _startSessionTimer();
  }

  void _startSessionTimer() {
    _sessionTimer?.cancel();
    _sessionTimer = Timer.periodic(Duration(minutes: 5), (timer) {
      _checkSessionValidity();
    });
  }

  void _checkSessionValidity() {
    if (state.expiresAt?.isBefore(DateTime.now()) ?? false) {
      // セッション期限切れ
      _endSession();
      ref.read(authServiceProvider).signOut();
    } else {
      // アクティビティ更新
      state = state.copyWith(
        lastActivity: DateTime.now(),
      );
    }
  }

  void _endSession() {
    _sessionTimer?.cancel();
    state = SessionState(
      isActive: false,
      lastActivity: null,
      expiresAt: null,
    );
  }

  void updateActivity() {
    if (state.isActive) {
      state = state.copyWith(
        lastActivity: DateTime.now(),
        expiresAt: DateTime.now().add(Duration(hours: 24)),
      );
    }
  }
}

@freezed
class SessionState with _$SessionState {
  const factory SessionState({
    required bool isActive,
    required DateTime? lastActivity,
    required DateTime? expiresAt,
  }) = _SessionState;
}
```

---

## 3. データ保護

### 3.1 暗号化

```dart
// lib/core/security/encryption_service.dart
class EncryptionService {
  static const String _algorithm = 'AES-256-GCM';
  static const int _keyLength = 32;
  static const int _ivLength = 12;
  static const int _tagLength = 16;

  // 機密データの暗号化
  static Future<String> encrypt(String plaintext, String key) async {
    final keyBytes = utf8.encode(key).take(_keyLength).toList();
    final iv = _generateIV();
    
    final cipher = GCMBlockCipher(AESEngine());
    final params = AEADParameters(
      KeyParameter(Uint8List.fromList(keyBytes)),
      _tagLength * 8,
      iv,
    );
    
    cipher.init(true, params);
    
    final plaintextBytes = utf8.encode(plaintext);
    final ciphertext = cipher.process(Uint8List.fromList(plaintextBytes));
    
    // IV + 暗号文 + タグ
    final result = Uint8List.fromList([...iv, ...ciphertext]);
    
    return base64.encode(result);
  }

  // 機密データの復号化
  static Future<String> decrypt(String ciphertext, String key) async {
    final keyBytes = utf8.encode(key).take(_keyLength).toList();
    final data = base64.decode(ciphertext);
    
    final iv = data.take(_ivLength).toList();
    final encryptedData = data.skip(_ivLength).toList();
    
    final cipher = GCMBlockCipher(AESEngine());
    final params = AEADParameters(
      KeyParameter(Uint8List.fromList(keyBytes)),
      _tagLength * 8,
      Uint8List.fromList(iv),
    );
    
    cipher.init(false, params);
    
    final decrypted = cipher.process(Uint8List.fromList(encryptedData));
    
    return utf8.decode(decrypted);
  }

  static Uint8List _generateIV() {
    final random = Random.secure();
    final iv = Uint8List(_ivLength);
    for (int i = 0; i < _ivLength; i++) {
      iv[i] = random.nextInt(256);
    }
    return iv;
  }

  // パスワードハッシュ化
  static Future<String> hashPassword(String password) async {
    final salt = _generateSalt();
    final hash = await _computeHash(password, salt);
    
    // salt + hash の形式で保存
    return base64.encode([...salt, ...hash]);
  }

  static Future<bool> verifyPassword(String password, String hashedPassword) async {
    final data = base64.decode(hashedPassword);
    final salt = data.take(16).toList();
    final hash = data.skip(16).toList();
    
    final computedHash = await _computeHash(password, salt);
    
    return _constantTimeEquals(hash, computedHash);
  }

  static Uint8List _generateSalt() {
    final random = Random.secure();
    final salt = Uint8List(16);
    for (int i = 0; i < 16; i++) {
      salt[i] = random.nextInt(256);
    }
    return salt;
  }

  static Future<Uint8List> _computeHash(String password, List<int> salt) async {
    final codec = utf8;
    final passwordBytes = codec.encode(password);
    final combined = Uint8List.fromList([...passwordBytes, ...salt]);
    
    final digest = await compute(sha256.convert, combined);
    return digest.bytes;
  }

  static bool _constantTimeEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    
    int result = 0;
    for (int i = 0; i < a.length; i++) {
      result |= a[i] ^ b[i];
    }
    
    return result == 0;
  }
}
```

### 3.2 データマスキング

```dart
// lib/core/security/data_masking.dart
class DataMasking {
  // クレジットカード番号のマスキング
  static String maskCreditCard(String cardNumber) {
    if (cardNumber.length < 4) return cardNumber;
    
    final lastFour = cardNumber.substring(cardNumber.length - 4);
    final masked = '*' * (cardNumber.length - 4);
    
    return masked + lastFour;
  }

  // メールアドレスのマスキング
  static String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    
    final localPart = parts[0];
    final domain = parts[1];
    
    if (localPart.length <= 2) return email;
    
    final maskedLocal = localPart[0] + '*' * (localPart.length - 2) + localPart[localPart.length - 1];
    
    return '$maskedLocal@$domain';
  }

  // 電話番号のマスキング
  static String maskPhoneNumber(String phoneNumber) {
    if (phoneNumber.length < 4) return phoneNumber;
    
    final lastFour = phoneNumber.substring(phoneNumber.length - 4);
    final masked = '*' * (phoneNumber.length - 4);
    
    return masked + lastFour;
  }

  // 個人情報のマスキング
  static String maskPersonalInfo(String text, String type) {
    switch (type) {
      case 'name':
        return _maskName(text);
      case 'address':
        return _maskAddress(text);
      default:
        return text;
    }
  }

  static String _maskName(String name) {
    if (name.length <= 1) return name;
    
    return name[0] + '*' * (name.length - 1);
  }

  static String _maskAddress(String address) {
    final parts = address.split(' ');
    if (parts.length <= 1) return address;
    
    final maskedParts = parts.map((part) {
      if (part.length <= 1) return part;
      return part[0] + '*' * (part.length - 1);
    }).toList();
    
    return maskedParts.join(' ');
  }
}
```

---

## 4. 通信セキュリティ

### 4.1 HTTPS強制

```dart
// lib/core/network/secure_http_client.dart
@riverpod
class SecureHttpClient extends _$SecureHttpClient {
  @override
  Dio build() {
    final dio = Dio();
    
    // HTTPS強制
    dio.options.baseUrl = 'https://api.example.com';
    
    // 証明書ピニング
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (cert, host, port) {
          // 本番環境では証明書を検証
          return false;
        };
        return client;
      },
    );
    
    // セキュリティヘッダー
    dio.options.headers['X-Content-Type-Options'] = 'nosniff';
    dio.options.headers['X-Frame-Options'] = 'DENY';
    dio.options.headers['X-XSS-Protection'] = '1; mode=block';
    dio.options.headers['Strict-Transport-Security'] = 'max-age=31536000; includeSubDomains';
    
    return dio;
  }
}
```

### 4.2 API認証

```dart
// lib/core/network/api_auth_interceptor.dart
class ApiAuthInterceptor extends Interceptor {
  final AuthService _authService;
  
  ApiAuthInterceptor(this._authService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // IDトークンの取得
    final idToken = await _authService.getIdToken();
    
    if (idToken != null) {
      options.headers['Authorization'] = 'Bearer $idToken';
    }
    
    // CSRFトークンの追加
    final csrfToken = await _generateCSRFToken();
    options.headers['X-CSRF-Token'] = csrfToken;
    
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // 認証エラーの場合、トークンリフレッシュ
      _handleAuthError();
    }
    
    handler.next(err);
  }

  Future<String> _generateCSRFToken() async {
    final random = Random.secure();
    final token = List<int>.generate(32, (i) => random.nextInt(256));
    return base64.encode(token);
  }

  void _handleAuthError() {
    // トークンリフレッシュまたはログアウト処理
    _authService.refreshToken();
  }
}
```

---

## 5. 入力検証

### 5.1 入力検証器

```dart
// lib/core/validation/input_validator.dart
class InputValidator {
  // XSS対策
  static bool isSafeText(String text) {
    final dangerousPatterns = [
      RegExp(r'<script.*?>.*?</script>', caseSensitive: false),
      RegExp(r'javascript:', caseSensitive: false),
      RegExp(r'on\w+\s*=', caseSensitive: false),
      RegExp(r'<iframe.*?>', caseSensitive: false),
    ];
    
    for (final pattern in dangerousPatterns) {
      if (pattern.hasMatch(text)) {
        return false;
      }
    }
    
    return true;
  }

  // SQLインジェクション対策
  static bool isSafeForDatabase(String text) {
    final dangerousPatterns = [
      RegExp(r'(\b(union|select|insert|update|delete|drop|create|alter)\b)', caseSensitive: false),
      RegExp(r'(\b(or|and)\b\s+\d+\s*=\s*\d+)', caseSensitive: false),
      RegExp(r'(\b(exec|execute)\b)', caseSensitive: false),
    ];
    
    for (final pattern in dangerousPatterns) {
      if (pattern.hasMatch(text)) {
        return false;
      }
    }
    
    return true;
  }

  // ファイルアップロード検証
  static bool isValidFile(File file, {int maxSize = 10 * 1024 * 1024}) {
    final allowedExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.mp4', '.mov'];
    final fileName = file.path.split('/').last.toLowerCase();
    
    // 拡張子チェック
    final hasValidExtension = allowedExtensions.any((ext) => fileName.endsWith(ext));
    if (!hasValidExtension) return false;
    
    // ファイルサイズチェック
    final fileSize = file.lengthSync();
    if (fileSize > maxSize) return false;
    
    return true;
  }

  // メールアドレス検証
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  // パスワード強度検証
  static bool isStrongPassword(String password) {
    if (password.length < 8) return false;
    
    final hasUpperCase = RegExp(r'[A-Z]').hasMatch(password);
    final hasLowerCase = RegExp(r'[a-z]').hasMatch(password);
    final hasDigits = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
    
    return hasUpperCase && hasLowerCase && hasDigits && hasSpecialCharacters;
  }
}
```

### 5.2 出力エスケープ

```dart
// lib/core/security/output_escaper.dart
class OutputEscaper {
  // HTMLエスケープ
  static String escapeHtml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;')
        .replaceAll('/', '&#x2F;');
  }

  // JavaScriptエスケープ
  static String escapeJavaScript(String text) {
    return text
        .replaceAll('\\', '\\\\')
        .replaceAll("'", "\\'")
        .replaceAll('"', '\\"')
        .replaceAll('\n', '\\n')
        .replaceAll('\r', '\\r')
        .replaceAll('\t', '\\t');
  }

  // URLエスケープ
  static String escapeUrl(String text) {
    return Uri.encodeComponent(text);
  }

  // SQLエスケープ（パラメータ化クエリを使用することを推奨）
  static String escapeSql(String text) {
    return text
        .replaceAll("'", "''")
        .replaceAll('\\', '\\\\');
  }
}
```

---

## 6. セキュリティ監視

### 6.1 セキュリティログ

```dart
// lib/core/security/security_logger.dart
@riverpod
class SecurityLogger extends _$SecurityLogger {
  @override
  void build() {}

  // セキュリティイベントの記録
  void logSecurityEvent(SecurityEvent event) {
    // Firebase Analytics への送信
    ref.read(analyticsServiceProvider).logEvent(
      'security_event',
      parameters: {
        'event_type': event.type.toString(),
        'severity': event.severity.toString(),
        'user_id': event.userId ?? 'anonymous',
        'ip_address': event.ipAddress ?? 'unknown',
        'user_agent': event.userAgent ?? 'unknown',
        'timestamp': event.timestamp.toIso8601String(),
        'details': event.details,
      },
    );

    // ローカルログ
    print('Security Event: ${event.type} - ${event.details}');
  }

  // 認証失敗の記録
  void logAuthFailure(String email, String reason, String ipAddress) {
    logSecurityEvent(SecurityEvent(
      type: SecurityEventType.authFailure,
      severity: SecuritySeverity.high,
      userId: null,
      ipAddress: ipAddress,
      userAgent: null,
      timestamp: DateTime.now(),
      details: 'Failed login attempt for $email: $reason',
    ));
  }

  // 不正アクセスの記録
  void logUnauthorizedAccess(String userId, String resource, String ipAddress) {
    logSecurityEvent(SecurityEvent(
      type: SecurityEventType.unauthorizedAccess,
      severity: SecuritySeverity.critical,
      userId: userId,
      ipAddress: ipAddress,
      userAgent: null,
      timestamp: DateTime.now(),
      details: 'Unauthorized access attempt to $resource',
    ));
  }

  // データ漏洩の記録
  void logDataBreach(String userId, String dataType, String details) {
    logSecurityEvent(SecurityEvent(
      type: SecurityEventType.dataBreach,
      severity: SecuritySeverity.critical,
      userId: userId,
      ipAddress: null,
      userAgent: null,
      timestamp: DateTime.now(),
      details: 'Data breach detected for $dataType: $details',
    ));
  }
}

@freezed
class SecurityEvent with _$SecurityEvent {
  const factory SecurityEvent({
    required SecurityEventType type,
    required SecuritySeverity severity,
    required String? userId,
    required String? ipAddress,
    required String? userAgent,
    required DateTime timestamp,
    required String details,
  }) = _SecurityEvent;
}

enum SecurityEventType {
  authFailure,
  unauthorizedAccess,
  dataBreach,
  suspiciousActivity,
  malwareDetection,
}

enum SecuritySeverity {
  low,
  medium,
  high,
  critical,
}
```

### 6.2 異常検知

```dart
// lib/core/security/anomaly_detector.dart
@riverpod
class AnomalyDetector extends _$AnomalyDetector {
  final Map<String, List<DateTime>> _loginAttempts = {};
  final Map<String, List<DateTime>> _apiCalls = {};
  
  @override
  void build() {}

  // 異常なログイン試行の検知
  bool detectLoginAnomaly(String email, String ipAddress) {
    final key = '$email:$ipAddress';
    final now = DateTime.now();
    
    if (!_loginAttempts.containsKey(key)) {
      _loginAttempts[key] = [];
    }
    
    _loginAttempts[key]!.add(now);
    
    // 1時間以内の試行回数をチェック
    final recentAttempts = _loginAttempts[key]!
        .where((time) => now.difference(time).inHours < 1)
        .length;
    
    if (recentAttempts > 5) {
      // 異常検知
      ref.read(securityLoggerProvider).logSecurityEvent(SecurityEvent(
        type: SecurityEventType.suspiciousActivity,
        severity: SecuritySeverity.high,
        userId: null,
        ipAddress: ipAddress,
        userAgent: null,
        timestamp: now,
        details: 'Multiple login attempts detected for $email',
      ));
      
      return true;
    }
    
    return false;
  }

  // 異常なAPI呼び出しの検知
  bool detectApiAnomaly(String userId, String endpoint) {
    final key = '$userId:$endpoint';
    final now = DateTime.now();
    
    if (!_apiCalls.containsKey(key)) {
      _apiCalls[key] = [];
    }
    
    _apiCalls[key]!.add(now);
    
    // 1分以内の呼び出し回数をチェック
    final recentCalls = _apiCalls[key]!
        .where((time) => now.difference(time).inMinutes < 1)
        .length;
    
    if (recentCalls > 100) {
      // 異常検知
      ref.read(securityLoggerProvider).logSecurityEvent(SecurityEvent(
        type: SecurityEventType.suspiciousActivity,
        severity: SecuritySeverity.medium,
        userId: userId,
        ipAddress: null,
        userAgent: null,
        timestamp: now,
        details: 'High frequency API calls detected for $endpoint',
      ));
      
      return true;
    }
    
    return false;
  }
}
```

---

## 7. インシデント対応

### 7.1 インシデント対応計画

```dart
// lib/core/security/incident_response.dart
@riverpod
class IncidentResponse extends _$IncidentResponse {
  @override
  void build() {}

  // セキュリティインシデントの対応
  Future<void> handleSecurityIncident(SecurityEvent event) async {
    switch (event.severity) {
      case SecuritySeverity.low:
        await _handleLowSeverityIncident(event);
        break;
      case SecuritySeverity.medium:
        await _handleMediumSeverityIncident(event);
        break;
      case SecuritySeverity.high:
        await _handleHighSeverityIncident(event);
        break;
      case SecuritySeverity.critical:
        await _handleCriticalIncident(event);
        break;
    }
  }

  Future<void> _handleLowSeverityIncident(SecurityEvent event) async {
    // ログ記録のみ
    print('Low severity incident handled: ${event.details}');
  }

  Future<void> _handleMediumSeverityIncident(SecurityEvent event) async {
    // ユーザーへの警告
    await _sendUserWarning(event);
    
    // 管理者への通知
    await _notifyAdmin(event);
  }

  Future<void> _handleHighSeverityIncident(SecurityEvent event) async {
    // アカウント一時停止
    if (event.userId != null) {
      await _temporarilySuspendAccount(event.userId!);
    }
    
    // 管理者への緊急通知
    await _notifyAdminUrgently(event);
  }

  Future<void> _handleCriticalIncident(SecurityEvent event) async {
    // システム全体の緊急対応
    await _emergencyResponse(event);
    
    // 外部機関への報告
    await _reportToAuthorities(event);
  }

  Future<void> _sendUserWarning(SecurityEvent event) async {
    // ユーザーへの警告メール送信
    final emailService = ref.read(emailServiceProvider);
    await emailService.sendSecurityWarning(
      to: event.userId ?? '',
      subject: 'セキュリティ警告',
      message: '不審なアクティビティが検出されました。',
    );
  }

  Future<void> _temporarilySuspendAccount(String userId) async {
    // アカウントの一時停止
    final authService = ref.read(authServiceProvider);
    await authService.suspendAccount(userId, Duration(hours: 24));
  }

  Future<void> _emergencyResponse(SecurityEvent event) async {
    // 緊急時の対応
    print('EMERGENCY: Critical security incident detected');
    print('Event: ${event.details}');
    print('Time: ${event.timestamp}');
    
    // システムの緊急停止（必要に応じて）
    // await _emergencyShutdown();
  }
}
```

---

## まとめ

このセキュリティ詳細設計書は、SNS統合ECアプリケーションのセキュリティ要件を包括的に定義しています。各セキュリティ対策の実装方針と監視方法を提供しています。

セキュリティは継続的に監視・改善し、ユーザーの信頼性を確保してください。