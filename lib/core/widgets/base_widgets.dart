import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_constants.dart';

/// 基盤ウィジェットクラス
class BaseWidgets {
  // Private constructor to prevent instantiation
  BaseWidgets._();
}

/// ローディングウィジェット
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.message,
    this.size = 24.0,
  });

  final String? message;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: AppConstants.defaultPadding),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// エラーウィジェット
class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.showRetryButton = true,
  });

  final String message;
  final VoidCallback? onRetry;
  final bool showRetryButton;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.largePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Text(
              'エラーが発生しました',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.smallPadding),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (showRetryButton && onRetry != null) ...[
              const SizedBox(height: AppConstants.largePadding),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('再試行'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 空状態ウィジェット
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.title,
    this.message,
    this.icon,
    this.action,
  });

  final String title;
  final String? message;
  final IconData? icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.largePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.inbox_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: AppConstants.smallPadding),
              Text(
                message!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: AppConstants.largePadding),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

/// リトライ可能なウィジェット
class RetryableWidget extends ConsumerWidget {
  const RetryableWidget({
    super.key,
    required this.onRetry,
    required this.child,
  });

  final VoidCallback onRetry;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async => onRetry(),
      child: child,
    );
  }
}

/// セーフエリア対応ウィジェット
class SafeAreaWidget extends StatelessWidget {
  const SafeAreaWidget({
    super.key,
    required this.child,
    this.maintainBottomViewPadding = true,
  });

  final Widget child;
  final bool maintainBottomViewPadding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: maintainBottomViewPadding,
      child: child,
    );
  }
}

/// レスポンシブウィジェット
class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return desktop ?? tablet ?? mobile;
        } else if (constraints.maxWidth >= 650) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}

/// アニメーション付きフェードウィジェット
class FadeInWidget extends StatefulWidget {
  const FadeInWidget({
    super.key,
    required this.child,
    this.duration = AppConstants.defaultAnimationDuration,
    this.curve = Curves.easeInOut,
  });

  final Widget child;
  final Duration duration;
  final Curve curve;

  @override
  State<FadeInWidget> createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}

/// スライドインアニメーションウィジェット
class SlideInWidget extends StatefulWidget {
  const SlideInWidget({
    super.key,
    required this.child,
    this.direction = SlideDirection.fromBottom,
    this.duration = AppConstants.defaultAnimationDuration,
    this.curve = Curves.easeOutCubic,
  });

  final Widget child;
  final SlideDirection direction;
  final Duration duration;
  final Curve curve;

  @override
  State<SlideInWidget> createState() => _SlideInWidgetState();
}

class _SlideInWidgetState extends State<SlideInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: _getBeginOffset(),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    _controller.forward();
  }

  Offset _getBeginOffset() {
    switch (widget.direction) {
      case SlideDirection.fromTop:
        return const Offset(0, -1);
      case SlideDirection.fromBottom:
        return const Offset(0, 1);
      case SlideDirection.fromLeft:
        return const Offset(-1, 0);
      case SlideDirection.fromRight:
        return const Offset(1, 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}

/// スライド方向の列挙型
enum SlideDirection {
  fromTop,
  fromBottom,
  fromLeft,
  fromRight,
}

/// カスタムボタンウィジェット
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.isLoading = false,
    this.isOutlined = false,
    this.isTextButton = false,
    this.width,
    this.height,
    this.borderRadius,
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledColor,
  });

  final VoidCallback? onPressed;
  final String text;
  final IconData? icon;
  final bool isLoading;
  final bool isOutlined;
  final bool isTextButton;
  final double? width;
  final double? height;
  final double? borderRadius;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget button;
    if (isTextButton) {
      button = TextButton(
        onPressed: isLoading ? null : onPressed,
        style: TextButton.styleFrom(
          foregroundColor: foregroundColor ?? colorScheme.primary,
          disabledForegroundColor: disabledColor ?? colorScheme.onSurface.withOpacity(0.38),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
            vertical: AppConstants.smallPadding,
          ),
          minimumSize: Size(width ?? 0, height ?? 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? AppConstants.defaultBorderRadius,
            ),
          ),
        ),
        child: _buildButtonContent(context),
      );
    } else if (isOutlined) {
      button = OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor ?? colorScheme.primary,
          disabledForegroundColor: disabledColor ?? colorScheme.onSurface.withOpacity(0.38),
          side: BorderSide(
            color: foregroundColor ?? colorScheme.primary,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
            vertical: AppConstants.smallPadding,
          ),
          minimumSize: Size(width ?? 0, height ?? 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? AppConstants.defaultBorderRadius,
            ),
          ),
        ),
        child: _buildButtonContent(context),
      );
    } else {
      button = ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: foregroundColor ?? colorScheme.onPrimary,
          backgroundColor: backgroundColor ?? colorScheme.primary,
          disabledForegroundColor: disabledColor ?? colorScheme.onSurface.withOpacity(0.38),
          disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.12),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
            vertical: AppConstants.smallPadding,
          ),
          minimumSize: Size(width ?? 0, height ?? 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? AppConstants.defaultBorderRadius,
            ),
          ),
        ),
        child: _buildButtonContent(context),
      );
    }

    return button;
  }

  Widget _buildButtonContent(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: AppConstants.smallPadding),
          Text(
            text,
            style: textStyle ?? Theme.of(context).textTheme.labelLarge,
          ),
        ],
      );
    }

    return Text(
      text,
      style: textStyle ?? Theme.of(context).textTheme.labelLarge,
    );
  }
}

/// カスタムテキストフィールドウィジェット
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.autofillHints,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding,
          vertical: AppConstants.smallPadding,
        ),
      ),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      maxLines: maxLines,
      maxLength: maxLength,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      validator: validator,
      autofillHints: autofillHints,
    );
  }
}