import 'package:flutter/material.dart';

import '../../widget/widget.dart';

class StreamWidget extends StatelessWidget {
  final bool loading;

  final bool hasError;

  final Color? backgroundColor;

  final Duration duration;

  final WidgetBuilder contentBuilder;

  final WidgetBuilder progressBuilder;

  final WidgetBuilder? errorBuilder;

  StreamWidget({
    Key? key,
    this.loading = false,
    this.hasError = false,
    this.backgroundColor,
    this.duration = kButtonAnimationDuration,
    required this.contentBuilder,
    required this.progressBuilder,
    this.errorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Theme.of(context).backgroundColor,
      child: AnimatedSwitcher(
        duration: duration,
        child: (hasError && errorBuilder != null)
            ? errorBuilder!(context)
            : (loading)
                ? progressBuilder(context)
                : contentBuilder(context),
      ),
    );
  }
}
