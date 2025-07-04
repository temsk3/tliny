import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/logger.dart';
import '../../utils/router_utils.dart';

/// Fluttertoast を表示する関数
Future<void> showFluttertoast(
  String msg, {
  Color? backgroundColor,
  Color? textColor,
  String? webBgColor,
}) async {
  logger.d('showFluttertoast: msg=$msg', time: DateTime.now());
  try {
    await Fluttertoast.showToast(
      msg: msg,
      webShowClose: true,
      webPosition: 'center',
      webBgColor: webBgColor ?? '#eb4034',
      timeInSecForIosWeb: 2,
      backgroundColor: backgroundColor ?? Colors.red,
      textColor: textColor ?? Colors.white,
      toastLength: Toast.LENGTH_LONG,
    );
  } on Exception catch (e, st) {
    logger.e(
      'showFluttertoast: error=$e, stackTrace=$st',
      time: DateTime.now(),
    );
    rethrow;
  }
}

/// テキストダイアログを表示する関数
Future<void> showTextDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String defaultActionText,
}) async {
  logger.d(
    'showTextDialog: title=$title, message=$message, defaultActionText=$defaultActionText',
    time: DateTime.now(),
  );
  try {
    final builder = CustomAlertDialog(
      title: title,
      contentWidget: Text(message),
      defaultActionText: defaultActionText,
      action: () {
        // appRoute.pop();
        RouterUtils.safePop(context);
      },
    );
    bool platform;
    if (kIsWeb) {
      platform = false;
    } else {
      platform = Platform.isIOS;
    }
    if (platform) {
      await showCupertinoDialog(
        context: context,
        builder: (context) => builder,
      );
    } else {
      await showDialog(context: context, builder: (context) => builder);
    }
  } on Exception catch (e, st) {
    logger.e('showTextDialog: error=$e, stackTrace=$st', time: DateTime.now());
    rethrow;
  }
}

/// 確認用ダイアログを表示する関数（bool を返す）
Future<bool?> showConfirmDialog(
  BuildContext context, {
  // StackRouter appRoute,
  required String title,
  required Widget contentWidget,
  required String cancelText,
  required String decisionText,
}) async {
  logger.d(
    'showConfirmDialog: title=$title, cancelText=$cancelText, decisionText=$decisionText',
    time: DateTime.now(),
  );
  try {
    final builder = CustomAlertDialog(
      title: title,
      contentWidget: contentWidget,
      cancelActionText: cancelText,
      cancelAction: () {
        // appRoute.pop(false);
      },
      defaultActionText: decisionText,
      action: () {
        // appRoute.pop(true);
      },
    );
    bool platform;
    if (kIsWeb) {
      platform = false;
    } else {
      platform = Platform.isIOS;
    }
    if (platform) {
      return await showCupertinoDialog<bool>(
        context: context,
        builder: (buildContext) => builder,
      );
    } else {
      return await showDialog<bool>(
        context: context,
        builder: (buildContext) => builder,
      );
    }
  } on Exception catch (e, st) {
    logger.e(
      'showConfirmDialog: error=$e, stackTrace=$st',
      time: DateTime.now(),
    );
    rethrow;
  }
}

/// カスタムダイアログを表示するWidget
class CustomAlertDialog extends HookWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.contentWidget,
    this.cancelActionText,
    this.cancelAction,
    required this.defaultActionText,
    this.action,
  });
  final String title;
  final Widget contentWidget;
  final String? cancelActionText;
  final Function? cancelAction;
  final String defaultActionText;
  final Function? action;

  @override
  Widget build(BuildContext context) {
    // final appRoute = useRouter();
    bool platform;
    if (kIsWeb) {
      platform = false;
    } else {
      platform = Platform.isIOS;
    }
    if (platform) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: contentWidget,
        actions: [
          if (cancelActionText != null)
            TextButton(
              child: Text(cancelActionText!),
              onPressed: () {
                if (cancelAction != null) {
                  cancelAction!();
                }
                Navigator.of(context).pop(false);
              },
            ),
          TextButton(
            child: Text(defaultActionText),
            onPressed: () {
              if (action != null) {
                action!();
              }
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: Text(title),
        content: contentWidget,
        actions: [
          if (cancelActionText != null)
            TextButton(
              child: Text(cancelActionText!),
              onPressed: () {
                if (cancelAction != null) {
                  cancelAction!();
                }
                Navigator.of(context).pop(false);
              },
            ),
          TextButton(
            child: Text(defaultActionText),
            onPressed: () {
              if (action != null) {
                action!();
              }
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    }
  }
}
