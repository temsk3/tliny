import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    required this.e,
    this.st,
  });
  final Object e;
  final StackTrace? st;

  @override
  Widget build(BuildContext context) {
    logger.e('Error', [e, st]);
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text(e.toString()),
    //         const SizedBox(height: 5),
    //         Text(st.toString()),
    //       ],
    //     ),
    //   ),
    // );
    return AlertDialog(
      title: Text(e.toString()),
      content: Text(st.toString()),
    );
  }
}
