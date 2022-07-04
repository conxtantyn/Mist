import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../common/common.dart';
import '../../router/router.dart';

import 'welcome.dart';

@Named('WelcomeRoute')
@injectable
class WelcomeRoute extends KRouter {
  WelcomeRoute();

  @override
  String path = Routes.welcome;

  @override
  Widget? handlerFunc(BuildContext? context, RouteParam params) {
    return Welcome();
  }
}
