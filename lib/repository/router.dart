import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../../router/router_controller.dart';

extension PageNavigator on RouterController {
  Future<dynamic> pushTo(
    String path, {
    bool? replace,
    bool? clearStack,
    TransitionType? transition,
    Duration? transitionDuration,
    RouteTransitionsBuilder? transitionBuilder,
    BuildContext? context,
    List<dynamic>? params,
  }) {
    var realPath = path;
    if (params != null) {
      params.forEach((value) {
        if (value != null) {
          realPath = realPath.replaceFirst(
            RegExp(r'(:[a-zA-Z]\w+)'),
            value.toString(),
          );
        }
      });
    }
    return this.navigateTo(
      realPath,
      replace: replace,
      clearStack: clearStack,
      transition: transition,
      transitionDuration: transitionDuration,
      transitionBuilder: transitionBuilder,
      context: context,
    );
  }
}

class PageRouter {
  final RouterController _controller;

  PageRouter(this._controller);

  Future<dynamic> navigateTo(
    String path, {
    bool? replace,
    bool? clearStack,
    TransitionType? transition,
    Duration? transitionDuration,
    RouteTransitionsBuilder? transitionBuilder,
    BuildContext? context,
    List<dynamic>? params,
  }) {
    var realPath = path;
    if (params != null) {
      params.forEach((value) {
        if (value != null) {
          realPath = realPath.replaceFirst(
            RegExp(r'(:[a-zA-Z]\w+)'),
            value.toString(),
          );
        }
      });
    }
    return _controller.navigateTo(
      realPath,
      replace: replace,
      clearStack: clearStack,
      transition: transition,
      transitionDuration: transitionDuration,
      transitionBuilder: transitionBuilder,
      context: context,
    );
  }
}
