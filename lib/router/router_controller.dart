import 'package:flutter/cupertino.dart';

import 'package:fluro/fluro.dart';

import 'package:flutter/material.dart';

import 'router.dart';

class RouterController {
  final List<KRouter> routes;

  final FluroRouter _router = FluroRouter();

  final Map<String, KRouter> _routeMapper = Map();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  RouterController(this.routes) {
    routes.forEach((route) {
      _routeMapper[route.path] = route;
      _router.define(
        route.path,
        handler: Handler(handlerFunc: route.handlerFunc),
        transitionType: route.transition,
      );
    });
  }

  Route<dynamic>? generator(RouteSettings routeSettings) =>
      _router.generator(routeSettings);

  void pop(BuildContext context) => _router.pop(context);

  KRouter? getHandler(String path) => routes.firstWhere((r) => r.path == path);

  Future<dynamic> navigateTo(
    String path, {
    bool? replace,
    bool? clearStack,
    TransitionType? transition,
    Duration? transitionDuration,
    RouteTransitionsBuilder? transitionBuilder,
    BuildContext? context,
  }) async {
    final match = _router.match(path);
    if (match != null) {
      final route = routes.firstWhere((r) => r.path == match.route.route);
      final hasPermission = await route.hasPermission(match.parameters);
      if (hasPermission) {
        if (context != null) {
          return _router.navigateTo(
            context,
            path,
            replace: replace ?? route.replace,
            clearStack: clearStack ?? route.clearStack,
            transition: transition ?? route.transition,
            transitionDuration: transitionDuration ?? route.transitionDuration,
            transitionBuilder: transitionBuilder ?? route.transitionBuilder,
          );
        } else if (clearStack ?? route.clearStack) {
          return navigatorKey.currentState
              ?.pushNamedAndRemoveUntil(path, (check) => false);
        } else if (replace ?? route.replace) {
          return navigatorKey.currentState?.pushReplacementNamed(path);
        } else {
          return navigatorKey.currentState?.pushNamed(path);
        }
      }
    }
  }
}
