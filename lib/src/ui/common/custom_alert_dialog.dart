import 'dart:io' show Platform;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';

import '../../settings/hooks/use_router.dart';

final logger = Logger();

Future<void> showTextDialog(
  BuildContext context,
  StackRouter appRoute, {
  required String title,
  required String message,
  required String defaultActionText,
}) async {
  final builder = CustomAlertDialog(
    title: title,
    contentWidget: Text(message),
    defaultActionText: defaultActionText,
    action: () {
      appRoute.pop();
    },
  );
  bool platform;
  if (kIsWeb) {
    platform = false;
  } else {
    platform = Platform.isIOS;
  }
  if (platform) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => builder,
    );
  } else {
    return showDialog(
      context: context,
      builder: (context) => builder,
    );
  }
}

/// 確認用ダイアログ（bool を返す）
Future<bool?> showConfirmDialog(
  BuildContext context,
  StackRouter appRoute, {
  required String title,
  required Widget contentWidget,
  required String cancelText,
  required String decisionText,
}) async {
  final builder = CustomAlertDialog(
    title: title,
    contentWidget: contentWidget,
    cancelActionText: cancelText,
    cancelAction: () {
      appRoute.pop(false);
    },
    defaultActionText: decisionText,
    action: () {
      appRoute.pop(true);
    },
  );
  bool platform;
  if (kIsWeb) {
    platform = false;
  } else {
    platform = Platform.isIOS;
  }
  if (platform) {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (context) => builder,
    );
  } else {
    return showDialog<bool>(
      context: context,
      builder: (context) => builder,
    );
  }
}

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
    final appRoute = useRouter();
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
                appRoute.pop(false);
              },
            ),
          TextButton(
            child: Text(defaultActionText),
            onPressed: () {
              if (action != null) {
                action!();
              }
              appRoute.pop(true);
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
                appRoute.pop(false);
              },
            ),
          TextButton(
            child: Text(defaultActionText),
            onPressed: () {
              if (action != null) {
                action!();
              }
              appRoute.pop(true);
            },
          ),
        ],
      );
    }
  }
}
