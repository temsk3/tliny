import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SuccessPage extends HookConsumerWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text(
          'Success',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
