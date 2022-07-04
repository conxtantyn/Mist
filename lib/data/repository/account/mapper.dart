import '../../../domain/domain.dart' as e;
import '../../database/database.dart';

extension AccountMapper on Account {
  e.Account mapToEntity() {
    return e.Account(
      id: id,
      login: login,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      email: email,
      activated: activated,
      langKey: langKey,
      authorities: authorities ?? ['ROLE_USER'],
    );
  }
}
