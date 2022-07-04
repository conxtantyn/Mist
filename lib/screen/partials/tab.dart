import 'package:flutter/material.dart';
import 'package:sprung/sprung.dart';

import '../../common/common.dart';
import '../../util/util.dart';

class TabScaffoldState extends InheritedWidget {
  final ValueNotifier<int> activeIndexVN = ValueNotifier(0);

  TabScaffoldState({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  static TabScaffoldState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TabScaffoldState>();
  }

  @override
  bool updateShouldNotify(TabScaffoldState old) {
    return activeIndexVN.value != old.activeIndexVN.value;
  }

  void changeTab(int index) => activeIndexVN.value = index;
}

abstract class TabState extends State<TabScaffold> {
  int get length;

  @override
  void initState() {
    super.initState();
  }

  void moveToLast() => TabScaffoldState.of(context)?.changeTab(length - 1);
}

class TabScaffold extends StatefulWidget {
  const TabScaffold({
    Key? key,
    required this.tabs,
  }) : super(key: key);
  final List<TabScreen> tabs;

  @override
  _TabScaffoldState createState() => _TabScaffoldState();
}

class _TabScaffoldState extends TabState with TickerProviderStateMixin {
  @override
  int get length => widget.tabs.length;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return ValueListenableBuilder<int>(
      valueListenable: TabScaffoldState.of(context)!.activeIndexVN,
      builder: (context, activeIndex, _) {
        return Scaffold(
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(
              bottom: padding.bottom,
            ),
            decoration: BoxDecoration(
              color: context.skin.colorScheme.background,
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: context.skin.colorScheme.secondaryVariant,
                ),
              ),
            ),
            height: kToolbarHeight + padding.bottom + Dimens.padding,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ...List.generate(
                    widget.tabs.length,
                    (index) {
                      return Expanded(
                        child: TabButton(
                          activeIcon: widget.tabs[index].activeIcon,
                          inactiveIcon: widget.tabs[index].icon,
                          isActive: index == activeIndex,
                          title: widget.tabs[index].iconTitle,
                          onPressed: () {
                            TabScaffoldState.of(context)!.changeTab(index);
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          body: AnimatedSwitcher(
            switchInCurve: Curves.fastOutSlowIn,
            switchOutCurve: Curves.fastOutSlowIn.flipped,
            transitionBuilder: (child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            duration: kAnimationDuration,
            reverseDuration: kAnimationDuration,
            child: IndexedStack(
              index: activeIndex,
              children: widget.tabs,
            ),
          ),
        );
      },
    );
  }
}

class TabScreen extends StatelessWidget {
  final Widget icon;
  final Widget activeIcon;

  final String iconTitle;

  final Widget child;

  final int index;

  const TabScreen({
    Key? key,
    required this.icon,
    required this.activeIcon,
    required this.iconTitle,
    required this.child,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: TabScaffoldState.of(context)!.activeIndexVN,
      child: child,
      builder: (context, activeIndex, child) {
        return AnimatedOpacity(
          opacity: activeIndex == index ? 1 : 0,
          duration: kAnimationDuration,
          curve: Sprung.overDamped,
          child: activeIndex == index ? child : Container(),
        );
      },
    );
  }
}

class TabButton extends StatelessWidget {
  final VoidCallback onPressed;

  final bool isActive;

  final Widget activeIcon;

  final Widget inactiveIcon;

  final String title;

  const TabButton({
    Key? key,
    required this.isActive,
    required this.onPressed,
    required this.inactiveIcon,
    required this.activeIcon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: TabScaffoldState.of(context)!.activeIndexVN,
      builder: (context, state, child) {
        return Material(
          color: context.skin.colorScheme.background,
          child: InkWell(
            onTap: onPressed,
            focusColor: context.skin.colorScheme.background,
            hoverColor: context.skin.colorScheme.background,
            highlightColor: context.skin.border.withOpacity(.2),
            splashColor: context.skin.border.withOpacity(.2),
            child: AnimatedSwitcher(
              switchInCurve: Curves.fastLinearToSlowEaseIn,
              switchOutCurve: Curves.fastLinearToSlowEaseIn.flipped,
              reverseDuration: kAnimationDuration,
              duration: kAnimationDuration,
              transitionBuilder: (child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(child: isActive ? activeIcon : inactiveIcon),
                  SizedBox(height: Dimens.iconTextSpacer),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimens.padding,
                      ),
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                        style: context.textTheme.overline?.copyWith(
                          color: isActive
                              ? context.skin.colorScheme.onSurface
                              : context.skin.colorScheme.onSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
