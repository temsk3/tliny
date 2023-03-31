import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)?.settings.arguments;
    final size = MediaQuery.of(context).size;
    final shortestSide = size.shortestSide;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: message != null
                  ? Text(
                      message as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: shortestSide / 19,
                      ),
                    )
                  : Text(
                      'エラー',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: shortestSide / 19,
                      ),
                    ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await Navigator.of(context).pushNamed('/top');
            },
            child: const Text('トップに戻る'),
          )
        ],
      ),
    );
  }
}
