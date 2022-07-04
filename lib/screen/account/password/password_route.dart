import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../common/common.dart';
import '../../../router/router.dart';

import '../../../domain/usecase/authentication/password.dart';

import 'password.dart';

@Named('PasswordRoute')
@injectable
class PasswordRoute extends KRouter {
  final PasswordLoginUsecase _loginUsecase;

  PasswordRoute(this._loginUsecase);

  @override
  String path = Routes.password;

  @override
  Widget? handlerFunc(BuildContext? context, RouteParam params) {
    return Password(
      loginUsecase: _loginUsecase,
    );
  }
}
