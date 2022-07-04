import 'package:fluro/fluro.dart';

import 'package:flutter/material.dart';

typedef RouteParam = Map<String, List<String>>;

const Duration kPageTransitionDuration = const Duration(milliseconds: 600);

abstract class KRouter {
  abstract String path;

  bool replace = false;
  bool clearStack = false;

  TransitionType transition = TransitionType.native;

  Duration transitionDuration = kPageTransitionDuration;

  RouteTransitionsBuilder? transitionBuilder;

  Widget? handlerFunc(BuildContext? context, RouteParam params);

  Future<bool> hasPermission(Map<String, List<String>> params) async => true;
}
