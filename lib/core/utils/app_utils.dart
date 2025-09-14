import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../constants/app_constants.dart';

/// アプリケーションユーティリティクラス
class AppUtils {
  // Private constructor to prevent instantiation
  AppUtils._();

  static const _uuid = Uuid();

  // =============================================================================
  // String Utilities
  // =============================================================================

  /// 文字列の空チェック
  static bool isEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  /// 文字列の非空チェック
  static bool isNotEmpty(String? value) {
    return !isEmpty(value);
  }

  /// 文字列の長さ制限
  static String truncate(String text, int maxLength, {String suffix = '...'}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}$suffix';
  }

  /// 文字列のキャピタライズ
  static String capitalize(String text) {
    if (isEmpty(text)) return text;
    return '${text[0].toUpperCase()}${text.substring(1).toLowerCase()}';
  }

  /// 文字列のタイトルケース変換
  static String toTitleCase(String text) {
    if (isEmpty(text)) return text;
    return text.split(' ').map((word) => capitalize(word)).join(' ');
  }

  /// 文字列のスネークケース変換
  static String toSnakeCase(String text) {
    return text
        .replaceAllMapped(
          RegExp(r'[A-Z]'),
          (Match match) => '_${match.group(0)!.toLowerCase()}',
        )
        .replaceAll(RegExp(r'[^a-z0-9_]'), '')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
  }

  /// 文字列のキャメルケース変換
  static String toCamelCase(String text) {
    final words = text.split(RegExp(r'[_\s-]'));
    if (words.isEmpty) return text;
    
    final firstWord = words[0].toLowerCase();
    final remainingWords = words.skip(1).map((word) => capitalize(word));
    
    return '$firstWord${remainingWords.join()}';
  }

  /// 文字列のパスカルケース変換
  static String toPascalCase(String text) {
    final words = text.split(RegExp(r'[_\s-]'));
    return words.map((word) => capitalize(word)).join();
  }

  // =============================================================================
  // Number Utilities
  // =============================================================================

  /// 数値のフォーマット（日本円）
  static String formatCurrency(int amount, {String currency = 'JPY'}) {
    final formatter = NumberFormat.currency(
      locale: 'ja_JP',
      symbol: currency == 'JPY' ? '¥' : currency,
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  /// 数値のフォーマット（パーセンテージ）
  static String formatPercentage(double value, {int decimalPlaces = 1}) {
    final formatter = NumberFormat.decimalPercentPattern(
      locale: 'ja_JP',
      decimalDigits: decimalPlaces,
    );
    return formatter.format(value);
  }

  /// 数値のフォーマット（小数点）
  static String formatDecimal(double value, {int decimalPlaces = 2}) {
    final formatter = NumberFormat.decimalPattern('ja_JP');
    formatter.minimumFractionDigits = decimalPlaces;
    formatter.maximumFractionDigits = decimalPlaces;
    return formatter.format(value);
  }

  /// 数値の範囲制限
  static int clamp(int value, int min, int max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  /// 数値の範囲チェック
  static bool isInRange(int value, int min, int max) {
    return value >= min && value <= max;
  }

  // =============================================================================
  // Date & Time Utilities
  // =============================================================================

  /// 日付のフォーマット
  static String formatDate(DateTime date, {String pattern = 'yyyy/MM/dd'}) {
    final formatter = DateFormat(pattern, 'ja_JP');
    return formatter.format(date);
  }

  /// 日時のフォーマット
  static String formatDateTime(DateTime date, {String pattern = 'yyyy/MM/dd HH:mm'}) {
    final formatter = DateFormat(pattern, 'ja_JP');
    return formatter.format(date);
  }

  /// 相対時間の表示
  static String getRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}日前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}時間前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分前';
    } else {
      return '今';
    }
  }

  /// 日付の妥当性チェック
  static bool isValidDate(String dateString, {String pattern = 'yyyy/MM/dd'}) {
    try {
      DateFormat(pattern).parseStrict(dateString);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 年齢の計算
  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || 
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  // =============================================================================
  // Validation Utilities
  // =============================================================================

  /// メールアドレスの妥当性チェック
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  /// パスワードの強度チェック
  static PasswordStrength checkPasswordStrength(String password) {
    int score = 0;
    
    if (password.length >= 8) score++;
    if (password.contains(RegExp(r'[a-z]'))) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score++;
    
    switch (score) {
      case 0:
      case 1:
        return PasswordStrength.weak;
      case 2:
      case 3:
        return PasswordStrength.medium;
      case 4:
      case 5:
        return PasswordStrength.strong;
      default:
        return PasswordStrength.weak;
    }
  }

  /// 電話番号の妥当性チェック（日本）
  static bool isValidPhoneNumber(String phoneNumber) {
    final phoneRegex = RegExp(r'^(\+81|0)[0-9]{9,10}$');
    return phoneRegex.hasMatch(phoneNumber.replaceAll(RegExp(r'[-\s]'), ''));
  }

  /// 郵便番号の妥当性チェック（日本）
  static bool isValidPostalCode(String postalCode) {
    final postalRegex = RegExp(r'^\d{3}-?\d{4}$');
    return postalRegex.hasMatch(postalCode);
  }

  /// URLの妥当性チェック
  static bool isValidUrl(String url) {
    try {
      Uri.parse(url);
      return true;
    } catch (e) {
      return false;
    }
  }

  // =============================================================================
  // File & Media Utilities
  // =============================================================================

  /// ファイルサイズのフォーマット
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// ファイル拡張子の取得
  static String getFileExtension(String fileName) {
    final parts = fileName.split('.');
    if (parts.length > 1) {
      return parts.last.toLowerCase();
    }
    return '';
  }

  /// 画像ファイルかどうかのチェック
  static bool isImageFile(String fileName) {
    final extension = getFileExtension(fileName);
    return ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'].contains(extension);
  }

  /// 動画ファイルかどうかのチェック
  static bool isVideoFile(String fileName) {
    final extension = getFileExtension(fileName);
    return ['mp4', 'avi', 'mov', 'wmv', 'flv', 'webm'].contains(extension);
  }

  // =============================================================================
  // ID & UUID Utilities
  // =============================================================================

  /// UUIDの生成
  static String generateUuid() {
    return _uuid.v4();
  }

  /// 短いIDの生成
  static String generateShortId({int length = 8}) {
    return _uuid.v4().replaceAll('-', '').substring(0, length);
  }

  /// IDの妥当性チェック
  static bool isValidId(String id) {
    return id.isNotEmpty && id.length >= 3;
  }

  // =============================================================================
  // Color Utilities
  // =============================================================================

  /// 色の明度を取得
  static double getLuminance(Color color) {
    return color.computeLuminance();
  }

  /// 色が明るいかどうかを判定
  static bool isLightColor(Color color) {
    return getLuminance(color) > 0.5;
  }

  /// 色が暗いかどうかを判定
  static bool isDarkColor(Color color) {
    return getLuminance(color) <= 0.5;
  }

  /// 文字色を自動選択（背景色に基づく）
  static Color getContrastColor(Color backgroundColor) {
    return isLightColor(backgroundColor) ? Colors.black : Colors.white;
  }

  /// 色の透明度を変更
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  // =============================================================================
  // Device & Platform Utilities
  // =============================================================================

  /// デバイスがモバイルかどうかを判定
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  /// デバイスがタブレットかどうかを判定
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1200;
  }

  /// デバイスがデスクトップかどうかを判定
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  /// 画面の向きを取得
  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  /// 縦向きかどうかを判定
  static bool isPortrait(BuildContext context) {
    return getOrientation(context) == Orientation.portrait;
  }

  /// 横向きかどうかを判定
  static bool isLandscape(BuildContext context) {
    return getOrientation(context) == Orientation.landscape;
  }

  // =============================================================================
  // Network & Connectivity Utilities
  // =============================================================================

  /// ネットワーク接続状態の確認（簡易版）
  static Future<bool> isNetworkAvailable() async {
    try {
      // 実際の実装では connectivity_plus パッケージを使用
      return true;
    } catch (e) {
      return false;
    }
  }

  /// URLの正規化
  static String normalizeUrl(String url) {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      return 'https://$url';
    }
    return url;
  }

  // =============================================================================
  // Security Utilities
  // =============================================================================

  /// 文字列のマスキング
  static String maskString(String text, {int visibleStart = 0, int visibleEnd = 0}) {
    if (text.length <= visibleStart + visibleEnd) return text;
    
    final start = text.substring(0, visibleStart);
    final end = text.substring(text.length - visibleEnd);
    final masked = '*' * (text.length - visibleStart - visibleEnd);
    
    return '$start$masked$end';
  }

  /// クレジットカード番号のマスキング
  static String maskCreditCard(String cardNumber) {
    if (cardNumber.length < 4) return cardNumber;
    return maskString(cardNumber, visibleEnd: 4);
  }

  /// メールアドレスのマスキング
  static String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    
    final username = parts[0];
    final domain = parts[1];
    
    if (username.length <= 2) return email;
    
    final maskedUsername = maskString(username, visibleStart: 1, visibleEnd: 1);
    return '$maskedUsername@$domain';
  }

  // =============================================================================
  // Performance Utilities
  // =============================================================================

  /// デバウンス関数
  static Function debounce(Function func, Duration wait) {
    Timer? timer;
    return (...args) {
      timer?.cancel();
      timer = Timer(wait, () => func(...args));
    };
  }

  /// スロットリング関数
  static Function throttle(Function func, Duration wait) {
    DateTime? lastCall;
    return (...args) {
      final now = DateTime.now();
      if (lastCall == null || now.difference(lastCall!) >= wait) {
        lastCall = now;
        func(...args);
      }
    };
  }
}

/// パスワード強度の列挙型
enum PasswordStrength {
  weak,
  medium,
  strong,
}

/// パスワード強度の日本語表示
extension PasswordStrengthExtension on PasswordStrength {
  String get displayName {
    switch (this) {
      case PasswordStrength.weak:
        return '弱い';
      case PasswordStrength.medium:
        return '普通';
      case PasswordStrength.strong:
        return '強い';
    }
  }

  Color get color {
    switch (this) {
      case PasswordStrength.weak:
        return Colors.red;
      case PasswordStrength.medium:
        return Colors.orange;
      case PasswordStrength.strong:
        return Colors.green;
    }
  }
}