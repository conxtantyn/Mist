import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import '../common/common.dart';
import '../util/util.dart';

const Duration kButtonAnimationDuration = Duration(milliseconds: 300);

class Button extends ButtonStyleButton {
  final String label;

  final double radius;

  final Color? primary;

  final Color? surface;

  final Color? onPrimary;

  final Color? onSurface;

  final Color? progressColor;

  final bool spanWidth;

  final bool showProgress;

  final bool outlined;

  final bool ghost;

  final Widget? prefix;

  final Widget? suffix;

  Button(
    this.label, {
    Key? key,
    this.radius = Dimens.buttonRadius,
    this.primary,
    this.surface,
    this.onPrimary,
    this.onSurface,
    this.progressColor,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    this.spanWidth = false,
    this.showProgress = false,
    this.outlined = false,
    this.ghost = false,
    this.prefix,
    this.suffix,
    Clip clipBehavior = Clip.none,
  }) : super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          onHover: (state) {},
          onFocusChange: (state) {},
          child: _ButtonWithProgressChild(
            label: label,
            spanWidth: spanWidth,
            showProgress: showProgress,
            outlined: outlined,
            ghost: ghost,
            onPrimary: onPrimary,
            progressColor: progressColor,
            prefix: prefix,
            suffix: suffix,
          ),
        );

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final buttonStyle =
        (outlined) ? OutlinedButton.styleFrom() : TextButton.styleFrom();

    final MaterialStateProperty<Size?>? maxSize = _ButtonMaximumSize(context);

    final MaterialStateProperty<Color?>? backgroundColor =
        (onSurface == null && primary == null)
            ? null
            : _ButtonDefaultBackground(primary, surface);

    final MaterialStateProperty<Color?>? foregroundColor =
        (onSurface == null && primary == null)
            ? null
            : _ButtonDefaultForeground(primary, onSurface);

    final MaterialStateProperty<Color?>? onForegroundColor =
        (onSurface == null && onPrimary == null)
            ? null
            : _ButtonDefaultForeground(onPrimary, onSurface);

    final MaterialStateProperty<Color?>? overlayColor =
        (primary == null) ? null : _ButtonDefaultOverlay(primary);

    final MaterialStateProperty<Color?>? onOverlayColor =
        (onPrimary == null) ? null : _ButtonDefaultOverlay(onPrimary);

    final borderSide = (surface == null && primary == null)
        ? null
        : _ButtonBorderSide(primary, surface);

    final EdgeInsetsGeometry scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsets.symmetric(
        vertical: Dimens.buttonVerticalPadding,
        horizontal: Dimens.buttonHorizontalPadding,
      ),
      const EdgeInsets.symmetric(
        vertical: Dimens.buttonVerticalPadding / 2,
        horizontal: Dimens.buttonHorizontalPadding / 2,
      ),
      const EdgeInsets.symmetric(
        vertical: Dimens.buttonVerticalPadding / 4,
        horizontal: Dimens.buttonHorizontalPadding / 4,
      ),
      MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
    );

    return buttonStyle.copyWith(
      foregroundColor:
          (outlined || ghost) ? foregroundColor : onForegroundColor,
      overlayColor: (outlined || ghost) ? overlayColor : onOverlayColor,
      maximumSize: maxSize,
      backgroundColor: (outlined || ghost)
          ? MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return Colors.transparent;
              },
            )
          : backgroundColor,
      shadowColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          return theme.shadowColor;
        },
      ),
      elevation: MaterialStateProperty.resolveWith<double>(
        (Set<MaterialState> states) {
          return 0;
        },
      ),
      textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
        (Set<MaterialState> states) {
          return theme.textTheme.button;
        },
      ),
      padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry?>(
        (Set<MaterialState> states) {
          return scaledPadding;
        },
      ),
      minimumSize: MaterialStateProperty.resolveWith<Size?>(
        (Set<MaterialState> states) {
          return const Size(64, 36);
        },
      ),
      side: (outlined) ? borderSide : null,
      shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
        (Set<MaterialState> states) {
          return RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ));
        },
      ),
      mouseCursor: MaterialStateProperty.resolveWith<MouseCursor?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled))
            return SystemMouseCursors.forbidden;
          return SystemMouseCursors.click;
        },
      ),
      visualDensity: theme.visualDensity,
      tapTargetSize: theme.materialTapTargetSize,
      animationDuration: kThemeChangeDuration,
      enableFeedback: true,
      alignment: Alignment.center,
      splashFactory: InkRipple.splashFactory,
    );
  }

  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    return OutlinedButtonTheme.of(context).style;
  }
}

@immutable
class _ButtonDefaultForeground extends MaterialStateProperty<Color?>
    with Diagnosticable {
  _ButtonDefaultForeground(this.primary, this.onSurface);

  final Color? primary;
  final Color? onSurface;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) return onSurface;
    return primary;
  }
}

@immutable
class _ButtonDefaultOverlay extends MaterialStateProperty<Color?>
    with Diagnosticable {
  _ButtonDefaultOverlay(this.primary);

  final Color? primary;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered))
      return primary?.withOpacity(0.04);
    if (states.contains(MaterialState.focused) ||
        states.contains(MaterialState.pressed))
      return primary?.withOpacity(0.12);
    return null;
  }
}

@immutable
class _ButtonBorderSide extends MaterialStateProperty<BorderSide?>
    with Diagnosticable {
  _ButtonBorderSide(this.primary, this.surface);

  final Color? primary;
  final Color? surface;

  @override
  BorderSide? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return BorderSide(
        color: surface ?? Colors.black.withOpacity(.28),
        width: 1,
      );
    }
    return BorderSide(
      color: primary?.withOpacity(0.4) ?? Colors.black,
      width: 1,
    );
  }
}

@immutable
class _ButtonDefaultBackground extends MaterialStateProperty<Color?>
    with Diagnosticable {
  _ButtonDefaultBackground(this.primary, this.onSurface);

  final Color? primary;
  final Color? onSurface;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) return onSurface;
    return primary;
  }
}

@immutable
class _ButtonMaximumSize extends MaterialStateProperty<Size?>
    with Diagnosticable {
  _ButtonMaximumSize(this.context);

  final BuildContext context;

  @override
  Size? resolve(Set<MaterialState> states) {
    return MediaQuery.of(context).size;
  }
}

class _ButtonWithProgressChild extends StatelessWidget {
  final String label;

  final bool spanWidth;

  final bool showProgress;

  final bool outlined;

  final bool ghost;

  final Color? onPrimary;

  final Color? progressColor;

  final Widget? prefix;

  final Widget? suffix;

  const _ButtonWithProgressChild({
    Key? key,
    required this.label,
    this.spanWidth = false,
    this.showProgress = false,
    this.outlined = false,
    this.ghost = false,
    this.onPrimary,
    this.progressColor,
    this.prefix,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = Text(label);
    final axisSize = (spanWidth) ? MainAxisSize.max : MainAxisSize.min;
    final padding = context.scaledPadding(
      const EdgeInsets.symmetric(
        vertical: Dimens.buttonVerticalPadding,
      ),
      const EdgeInsets.symmetric(
        vertical: Dimens.buttonVerticalPadding / 2,
      ),
      const EdgeInsets.symmetric(
        vertical: Dimens.buttonVerticalPadding / 4,
      ),
    );
    return Row(
      mainAxisSize: axisSize,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        prefix ?? SizedBox(),
        AnimatedSwitcher(
          duration: kButtonAnimationDuration,
          child: (showProgress)
              ? Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Opacity(
                      opacity: 0.0,
                      child: Text(label),
                    ),
                    Container(
                      width: padding.vertical / 2,
                      height: padding.vertical / 2,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color: (outlined || ghost)
                            ? text.style?.color
                            : progressColor ??
                                Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                )
              : text,
        ),
        suffix ?? SizedBox(),
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;

  final double radius;

  final bool spanWidth;

  final bool showProgress;

  final bool outlined;

  final bool ghost;

  final Widget? prefix;

  final Widget? suffix;

  final VoidCallback? onPressed;

  PrimaryButton(
    this.label, {
    Key? key,
    this.radius = Dimens.buttonRadius * 4,
    this.spanWidth = false,
    this.showProgress = false,
    this.outlined = false,
    this.ghost = false,
    this.prefix,
    this.suffix,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Skin skin = ThemeProvider.optionsOf<Skin>(context);
    return Button(
      label,
      radius: radius,
      primary: skin.colorScheme.primary,
      surface: skin.disabled,
      onPrimary: skin.colorScheme.onPrimary,
      onSurface: skin.onDisabled,
      spanWidth: spanWidth,
      showProgress: showProgress,
      outlined: outlined,
      ghost: ghost,
      prefix: prefix,
      suffix: suffix,
      onPressed: onPressed,
    );
  }
}
