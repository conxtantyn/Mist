import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../common/common.dart';
import '../../../router/router.dart';

import '../../../domain/usecase/authentication/verify.dart';
import '../../../domain/usecase/authentication/login.dart';

import 'verification.dart';

@Named('VerificationRoute')
@injectable
class VerificationRoute extends KRouter {
  final AuthUsecase _authUsecase;
  final ProcessOtpUsecase _processOtpUsecase;
  final LastLoginAttemptUsecase _attemptUsecase;

  VerificationRoute(
    this._authUsecase,
    this._processOtpUsecase,
    this._attemptUsecase,
  );

  @override
  String path = Routes.verification;

  @override
  Widget? handlerFunc(BuildContext? context, RouteParam params) {
    return Verification(
      authUsecase: _authUsecase,
      processOtpUsecase: _processOtpUsecase,
      attemptUsecase: _attemptUsecase,
    );
  }
}
