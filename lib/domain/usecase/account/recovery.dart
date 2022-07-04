import 'package:injectable/injectable.dart';

import '../../repository/account.dart';

@injectable
class PasswordRecoveryUsecase {
  final AccountRepository _repository;

  PasswordRecoveryUsecase(this._repository);

  Future<void> recover(String username) {
    return _repository.requestPasswordResetKey(username);
  }
}
