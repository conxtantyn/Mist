import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final Alignment alignment;

  final double overflow;

  final Widget? header;
  final Widget? body;
  final Widget? footer;

  final Widget Function(Widget)? builder;

  const Section({
    Key? key,
    this.alignment = Alignment.center,
    this.overflow = 0.0,
    this.header,
    this.body,
    this.footer,
    this.builder,
  }) : super(key: key);

  Widget _defaultBuilder(Widget child) => SingleChildScrollView(child: child);

  @override
  Widget build(BuildContext context) {
    final sectionBuilder = builder ?? _defaultBuilder;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return sectionBuilder(
          Container(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: constraints.maxHeight + overflow,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (alignment.y != -1) ...[
                  header ?? Container(),
                ],
                Column(
                  children: [
                    if (alignment.y == -1) ...[
                      header ?? Container(),
                    ],
                    ...[body ?? Container()],
                    if (alignment.y == 1) ...[
                      footer ?? Container(),
                    ],
                  ],
                ),
                if (alignment.y != 1) ...[
                  footer ?? Container(),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
