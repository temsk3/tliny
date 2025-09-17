import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const Result._();

  const factory Result.success({required T data}) = Success<T>;

  const factory Result.failure({
    required Exception error,
    required StackTrace stackTrace,
  }) = Failure<T>;
  // 同期のビジネスロジック用
  static Result<T> guard<T>(T Function() body) {
    try {
      return Result.success(data: body());
    } on Exception catch (e, st) {
      return Result.failure(error: e, stackTrace: st);
    }
  }

  // ネットワーク通信など、非同期で呼び出すロジック用
  static Future<Result<T>> guardFuture<T>(Future<T> Function() future) async {
    try {
      return Result.success(data: await future());
    } on Exception catch (e, st) {
      return Result.failure(error: e, stackTrace: st);
    }
  }

  bool get isSuccess =>
      when(success: (data) => true, failure: (e, st) => false);

  bool get isFailure => !isSuccess;

  T get dataOrThrow {
    return when(
      success: (data) => data,
      failure: (e, st) {
        if (kDebugMode) {
          print('$e\n$st');
        }
        return throw e;
      }, // => throw e,
    );
  }
}

extension ResultObjectExt<T> on T {
  Result<T> get asSuccess => Result.success(data: this);

  Result<T> asFailure({required Exception e, required StackTrace st}) =>
      Result.failure(error: e, stackTrace: st);
}
