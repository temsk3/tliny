import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repository/test_repository.dart';
import '../../utils/logger.dart';

part 'test_functions_page.g.dart';

@riverpod
class TestFunctionsNotifier extends _$TestFunctionsNotifier {
  @override
  FutureOr<void> build() {}

  Future<void> testCloudFunction() async {
    state = const AsyncLoading();
    try {
      final testRepo = ref.read(testRepositoryProvider);
      final result = await testRepo.testFunction('Hello from Flutter!');
      logger.i('Test function result: $result');
      state = const AsyncData(null);
    } catch (e, st) {
      logger.e('Test function error', error: e, stackTrace: st);
      state = AsyncError(e, st);
    }
  }
}

class TestFunctionsPage extends HookConsumerWidget {
  const TestFunctionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testState = ref.watch(testFunctionsNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Cloud Functions Test')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                ref
                    .read(testFunctionsNotifierProvider.notifier)
                    .testCloudFunction();
              },
              child: const Text('Test Cloud Function'),
            ),
            const SizedBox(height: 16),
            testState.when(
              data:
                  (_) => const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        '✅ Cloud Function called successfully!',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
              loading:
                  () => const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 16),
                          Text('Calling Cloud Function...'),
                        ],
                      ),
                    ),
                  ),
              error:
                  (error, stack) => Card(
                    color: Colors.red.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '❌ Error calling Cloud Function:',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            error.toString(),
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
