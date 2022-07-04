import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../common/common.dart';
import '../../../router/router.dart';

import '../../../domain/usecase/account/password_reset.dart';

import 'reset.dart';

@Named('ResetRoute')
@injectable
class ResetRoute extends KRouter {
  final PasswordResetUsecase _resetUsecase;

  ResetRoute(this._resetUsecase);

  @override
  String path = Routes.reset;

  @override
  Widget? handlerFunc(BuildContext? context, RouteParam params) {
    return Reset(
      resetUsecase: _resetUsecase,
    );
  }
}
