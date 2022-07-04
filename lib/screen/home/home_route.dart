import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../common/common.dart';
import '../../router/router.dart';

import 'home.dart';

@Named('HomeRoute')
@injectable
class HomeRoute extends KRouter {
  HomeRoute();

  @override
  String path = Routes.home;

  @override
  Widget? handlerFunc(BuildContext? context, RouteParam params) {
    return Home();
  }
}
