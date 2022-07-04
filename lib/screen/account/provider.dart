import 'package:injectable/injectable.dart';

import '../../router/router.dart';

import 'login/login_route.dart';
import 'verification/verification_route.dart';
import 'password/password_route.dart';
import 'register/register_route.dart';
import 'recover/recover_route.dart';
import 'reset/reset_route.dart';

@injectable
class AccountProvider {
  final LoginRoute _loginRoute;
  final VerificationRoute _verificationRoute;
  final PasswordRoute _passwordRoute;
  final RegisterRoute _registerRoute;
  final RecoverRoute _recoverRoute;
  final ResetRoute _resetRoute;

  AccountProvider(
    @Named('LoginRoute') this._loginRoute,
    @Named('VerificationRoute') this._verificationRoute,
    @Named('PasswordRoute') this._passwordRoute,
    @Named('RegisterRoute') this._registerRoute,
    @Named('RecoverRoute') this._recoverRoute,
    @Named('ResetRoute') this._resetRoute,
  );

  List<KRouter> get routes => <KRouter>[
        _loginRoute,
        _verificationRoute,
        _passwordRoute,
        _registerRoute,
        _recoverRoute,
        _resetRoute,
      ];
}
