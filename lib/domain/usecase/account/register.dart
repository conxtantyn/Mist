import 'package:injectable/injectable.dart';

import '../../model/model.dart';
import '../../repository/account.dart';

@injectable
class RegisterUsecase {
  final AccountRepository _repository;

  RegisterUsecase(this._repository);

  Future<void> register(AccountModel model) {
    return _repository.register(model);
  }
}
