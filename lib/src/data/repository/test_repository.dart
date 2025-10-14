import 'package:cloud_functions/cloud_functions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';

part 'test_repository.g.dart';

// TestRepositoryProvider
@Riverpod(keepAlive: true)
TestRepository testRepository(Ref ref) {
  return TestRepository(ref.watch(firebaseFunctionsProvider));
}

class TestRepository {
  TestRepository(this._func);
  final FirebaseFunctions _func;

  /// Cloud Functions を呼び出すためのヘルパー関数
  Future<T?> _call<T>(String name, Map<dynamic, dynamic> params) async {
    logger.i('TestRepository._call start - function: $name, params: $params');
    final callable = _func.httpsCallable(name);
    try {
      final result = await callable.call<T>(params);
      logger.i(
        'TestRepository._call success - function: $name, result: $result',
      );
      return result.data;
    } on FirebaseFunctionsException catch (e, st) {
      logger.e(
        'TestRepository._call Error: FirebaseFunctionsException - function: $name, params: $params',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      return Future.error(e, st);
    } on Exception catch (e, st) {
      logger.e(
        'TestRepository._call Error: Exception - function: $name, params: $params',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      return Future.error(e, st);
    }
  }

  /// テスト関数を呼び出す
  Future<Map<String, dynamic>> testFunction(String testData) async {
    logger.d('testFunction: testData=$testData');
    try {
      final params = {'testData': testData};
      logger.i('testFunction params: $params');

      final response = await _call<Map<String, dynamic>>(
        'v2_test_function',
        params,
      );

      logger.i('testFunction response: $response');
      logger.d('testFunction success - testData: $testData');

      return response!;
    } on Exception catch (e, st) {
      logger.e(
        'testFunctionError - testData: $testData',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }
}
