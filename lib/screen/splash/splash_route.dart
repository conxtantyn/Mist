import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../common/common.dart';
import '../../router/router.dart';

import '../../domain/usecase/startup.dart';

import 'splash.dart';

@Named('SplashRoute')
@injectable
class SplashRoute extends KRouter {
  final StartupUsecase _startupUsecase;

  SplashRoute(this._startupUsecase);

  @override
  String path = Routes.splash;

  @override
  Widget? handlerFunc(BuildContext? context, RouteParam params) {
    return Splash(
      startupUsecase: _startupUsecase,
    );
  }
}
