import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/common.dart';
import '../../util/util.dart';

class SliverToolBar extends SliverPersistentHeaderDelegate {
  final String title;

  final Widget? leading;

  SliverToolBar({
    required this.title,
    this.leading,
  }) : super();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final fontSize = context.textTheme.headline5?.fontSize;
    final clampSize = context.textTheme.headline6?.fontSize;

    final value = (shrinkOffset / kToolbarHeight).clamp(0.0, 1.0);
    final maxPadding = kMinInteractiveDimension - Dimens.padding;
    final shrinkText = clampSize! + ((fontSize! - clampSize) * (1 - value));
    final shrinkPadding = Dimens.contentPadding + (value * maxPadding);
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: context
                .read<Skin>()
                .colorScheme
                .secondaryVariant
                .withOpacity(value),
            width: 1.0,
          ),
        ),
      ),
      child: Stack(
        children: [
          AppBar(
            leading: leading,
            elevation: 0.0,
            brightness: Brightness.dark,
            backgroundColor: Theme.of(context).backgroundColor,
            iconTheme: Theme.of(context).iconTheme.copyWith(
                  color: context.read<Skin>().colorScheme.onSurface,
                ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: kToolbarHeight,
              padding: EdgeInsets.symmetric(
                horizontal: shrinkPadding,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: context.textTheme.headline2?.copyWith(
                    fontSize: shrinkText,
                    height: 1.25,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => kToolbarHeight * 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.minExtent != minExtent &&
        oldDelegate.maxExtent != maxExtent;
  }
}
