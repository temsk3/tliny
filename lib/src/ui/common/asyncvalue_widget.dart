import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'error_screen.dart';
import 'loading_screen.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({super.key, required this.value, required this.data});
  final AsyncValue<T> value;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => const LoadingScreen(),
      error: (error, stackTrace) => ErrorScreen(e: error, st: stackTrace),
    );
  }
}

class AsyncValueButtonWidget<T> extends StatelessWidget {
  const AsyncValueButtonWidget({
    super.key,
    required this.value,
    required this.data,
  });
  final AsyncValue<T> value;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => const Center(
        child:
            //  LinearProgressIndicator()
            SizedBox(height: 10, width: 10, child: CircularProgressIndicator()),
      ),
      // loading: LinearProgressIndicator.new,
      error: (error, stackTrace) => Center(child: Text(error.toString())),
    );
  }
}
