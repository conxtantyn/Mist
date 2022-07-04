import '../entity/entity.dart';
import '../model/model.dart';

abstract class AccountRepository {
  Future<Account> get();

  Future<Account> update(Account account);

  Future<void> register(AccountModel model);

  Future<void> requestPasswordResetKey(String login);

  Future<void> resetPassword(String key, String password);

  Future<void> changePassword(String newPassword, String currentPassword);
}
