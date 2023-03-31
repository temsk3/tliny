import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AccountCompletePage extends StatelessWidget {
  const AccountCompletePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('completed'),
      ),
      body: const Text('complete'),
    );
  }
}
