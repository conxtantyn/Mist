import 'package:injectable/injectable.dart';

import '../../repository/authentication.dart';

@injectable
class PasswordLoginUsecase {
  final AuthenticationRepository _repository;

  PasswordLoginUsecase(this._repository);

  Future<bool> authenticate(String password) {
    return _repository.login(password);
  }
}
