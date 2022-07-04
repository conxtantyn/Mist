import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../common/common.dart';
import '../../../router/router.dart';

import '../../../domain/usecase/account/recovery.dart';

import 'recover.dart';

@Named('RecoverRoute')
@injectable
class RecoverRoute extends KRouter {
  final PasswordRecoveryUsecase _recoveryUsecase;

  RecoverRoute(this._recoveryUsecase);

  @override
  String path = Routes.recover;

  @override
  Widget? handlerFunc(BuildContext? context, RouteParam params) {
    return Recover(
      recoveryUsecase: _recoveryUsecase,
    );
  }
}
