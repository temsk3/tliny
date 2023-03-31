import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class BaseFloatingActionButton extends HookWidget {
  final VoidCallback onPressed;
  final Widget child;
  const BaseFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final waiting = useState(false);
    return FloatingActionButton(
      onPressed: waiting.value
          ? null
          : () async {
              waiting.value = true;
              onPressed();
              waiting.value = false;
            },
      child: child,
    );
  }
}

class BaseIconButton extends HookWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final String? tooltip;
  const BaseIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final waiting = useState(false);
    return IconButton(
      icon: icon,
      tooltip: tooltip,
      onPressed: waiting.value
          ? null
          : () async {
              waiting.value = true;
              onPressed();
              waiting.value = false;
            },
    );
  }
}

class BaseElevatedButton extends HookWidget {
  final VoidCallback? onPressed;
  final Widget child;
  const BaseElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final waiting = useState(false);
    return ElevatedButton(
      onPressed: waiting.value || onPressed == null
          ? null
          : () async {
              waiting.value = true;
              onPressed!();
              waiting.value = false;
            },
      child: child,
    );
  }
}
