import 'package:injectable/injectable.dart';

import '../../model/model.dart';
import '../../entity/entity.dart';
import '../../repository/account.dart';

import '../locale.dart';

import 'register.dart';

@injectable
class GetUserUsecase {
  final AccountRepository _repository;

  GetUserUsecase(this._repository);

  Future<Account> getUser() => _repository.get();
}

@injectable
class CreateUserUsecase {
  final RegisterUsecase _registerUsecase;
  final GetLocaleUsecase _getLocaleUsecase;

  CreateUserUsecase(this._registerUsecase, this._getLocaleUsecase);

  Future<void> create(String phone, Map<String, dynamic> form) {
    return _getLocaleUsecase.get().then((local) {
      final account = AccountModel(
        login: form['username'] as String,
        phone: phone,
        firstName: form['firstName'] as String,
        lastName: form['lastName'] as String,
        email: form['email'] as String,
        langKey: local.languageCode,
        password: form['password'] as String,
      );
      return _registerUsecase.register(account);
    });
  }
}
