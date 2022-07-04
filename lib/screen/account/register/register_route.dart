import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../common/common.dart';
import '../../../router/router.dart';
import '../../../domain/usecase/account/user.dart';

import 'register.dart';

@Named('RegisterRoute')
@injectable
class RegisterRoute extends KRouter {
  final CreateUserUsecase _createUserUsecase;

  RegisterRoute(this._createUserUsecase);

  @override
  String path = Routes.register;

  @override
  Widget? handlerFunc(BuildContext? context, RouteParam params) {
    final animated = params['animated']?.first == 'true';
    return Register(
      animated: animated,
      createUserUsecase: _createUserUsecase,
    );
  }
}
