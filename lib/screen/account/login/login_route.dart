import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../common/common.dart';
import '../../../router/router.dart';

import '../../../domain/usecase/authentication/login.dart';

import 'login.dart';

@Named('LoginRoute')
@injectable
class LoginRoute extends KRouter {
  final AuthUsecase _authUsecase;

  LoginRoute(this._authUsecase);

  @override
  String path = Routes.login;

  @override
  Widget? handlerFunc(BuildContext? context, RouteParam params) {
    final animated = params['animated']?.first == 'true';
    return Builder(
      builder: (context) {
        return Login(
          animated: animated,
          authUsecase: _authUsecase,
        );
      },
    );
  }
}
