import 'package:injectable/injectable.dart';

import '../../repository/account.dart';

@injectable
class PasswordResetUsecase {
  final AccountRepository _repository;

  PasswordResetUsecase(this._repository);

  Future<void> reset(String key, String password) {
    return _repository.resetPassword(key, password);
  }
}
