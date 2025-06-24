import 'package:flutter/material.dart';

import '../../utils/logger.dart';

/// スナックバーを表示する関数
SnackBar snackBar(Color? color, {required String text}) {
  logger.d('snackBar: color=$color, text=$text', time: DateTime.now());
  try {
    return SnackBar(
      /// スナックバーの表示時間を設定
      duration: const Duration(seconds: 3),

      /// スナックバーの水平方向のパディングを設定
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),

      /// スナックバーのマージンを設定
      margin: const EdgeInsetsDirectional.all(16),

      /// スナックバーのコンテンツエリアを設定
      content: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            /// アイコンを表示
            Icon(
              Icons.check,
              color: color ?? Colors.green,
            ),

            /// テキストを表示
            Text(
              text,
              style: TextStyle(color: color ?? Colors.green),
            ),
          ],
        ),
      ),

      /// スナックバーの形状を設定
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),

      /// スナックバーの挙動を設定
      behavior: SnackBarBehavior.floating,

      /// 閉じるアイコンを表示するかどうかを設定
      showCloseIcon: true,

      /// スナックバーが表示されたときに実行されるコールバック関数
      onVisible: () {
        logger.d('snackBar: onVisible', time: DateTime.now());
      },

      /// スナックバーのアクションボタンを設定
      action: SnackBarAction(
        /// アクションボタンのラベルを設定
        label: 'Public',

        /// アクションボタンのテキストの色を設定
        textColor: color ?? Colors.green,

        /// アクションボタンが押されたときに実行されるコールバック関数
        onPressed: () {
          logger.d('snackBar: onPressed', time: DateTime.now());
        },
      ),

      /// スナックバーの影の深さを設定
      elevation: 4,

      /// 閉じるアイコンの色を設定
      closeIconColor: color ?? Colors.green,

      /// スナックバーを閉じる方向を設定
      dismissDirection: DismissDirection.horizontal,
    );
  } on Exception catch (e, st) {
    // エラーが発生した場合、エラーログを出力
    logger.e('snackBar: error=$e, stackTrace=$st', time: DateTime.now());
    // エラーメッセージを表示
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(e.toString()),
    //   ),
    // );
    // エラー画面を表示
    // return const Scaffold(
    //   body: Center(
    //     child: Text('エラーが発生しました'),
    //   ),
    // );
    rethrow;
  }
}
