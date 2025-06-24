import 'package:logger/logger.dart';

/// ログ出力用のLoggerインスタンス
final logger = Logger(
  /// ログ出力のフォーマットを設定
  printer: PrettyPrinter(
    /// メソッド呼び出しのスタックトレースを表示する深さ
    methodCount: 2,

    /// エラー発生時のメソッド呼び出しのスタックトレースを表示する深さ
    errorMethodCount: 8,

    /// ログ出力の行の長さ
    lineLength: 120,

    /// ログ出力に色を使用するかどうか
    colors: true,

    /// ログ出力に絵文字を使用するかどうか
    printEmojis: true,

    /// ログ出力にタイムスタンプを表示するかどうか
    printTime: true,
  ),
);
