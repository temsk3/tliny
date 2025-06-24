import 'package:flutter/material.dart';

/// メインコンテンツエリアのWidget
class MainBodyWidget extends StatelessWidget {
  const MainBodyWidget({super.key, required this.body, this.width});

  /// メインコンテンツエリアに表示するWidget
  final Widget body;

  /// メインコンテンツエリアの幅
  final double? width;

  @override
  Widget build(BuildContext context) {
    // logger.d('MainBodyWidget: build', time: DateTime.now());
    // try {
    //   // 画面サイズに応じてレイアウトを変更
    //   return Container(
    //     alignment: Alignment.topCenter,
    //     child: SafeArea(
    //       child: SizedBox(
    //         width: width,
    //         child: body,
    //       ),
    //     ),
    //   );
    // } on Exception catch (e, st) {
    //   // エラーが発生した場合、エラーログを出力
    //   logger.e('MainBodyWidget: error=$e, stackTrace=$st',
    //       time: DateTime.now());
    //   // エラーメッセージを表示
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(e.toString()),
    //     ),
    //   );
    //   // エラー画面を表示
    //   return const Scaffold(
    //     body: Center(
    //       child: Text('エラーが発生しました'),
    //     ),
    //   );
    // }
    return LayoutBuilder(
      builder: (context, constraints) {
        // 利用可能な幅を取得
        final availableWidth = constraints.maxWidth;
        // bodyの幅を決定
        final double? bodyWidth;
        if (width != null) {
          // maxWidthが指定されている場合は、その値を使用
          bodyWidth = width;
        } else {
          bodyWidth = availableWidth;
        }
        // 画面サイズに応じてレイアウトを変更
        return Container(
          alignment: Alignment.topCenter,
          child: SafeArea(child: SizedBox(width: bodyWidth, child: body)),
        );
      },
    );
  }
}
