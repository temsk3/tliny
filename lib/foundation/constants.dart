import 'package:enum_to_string/enum_to_string.dart';

enum Flavor { dev, prod }

class Constants {
  const Constants._({required this.baseUrl});

  factory Constants.of() {
    switch (flavor) {
      case Flavor.dev:
        return Constants._dev();
      case Flavor.prod:
        return Constants._prod();
    }
  }

  factory Constants._dev() {
    // return const Constants._(baseUrl: 'http://dev');
    return const Constants._(baseUrl: 'localhost');
  }

  factory Constants._prod() {
    return const Constants._(baseUrl: 'http://tliny.spel1.com');
  }

  /// エンドポイント
  final String baseUrl;

  /// 環境 Flavor
  static Flavor get flavor =>
      EnumToString.fromString(
        Flavor.values,
        const String.fromEnvironment('FLAVOR'),
      ) ??
      Flavor.dev;

  /// Device Previewを有効化するかどうか
  static bool get enablePreview => const bool.fromEnvironment('PREVIEW');
}
