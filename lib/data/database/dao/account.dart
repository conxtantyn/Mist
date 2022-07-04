import 'package:injectable/injectable.dart';

import '../../../data/database/wrapper.dart';

import 'base.dart';

@Named('AccountDao')
@Singleton()
class AccountDao extends BaseDao {
  AccountDao(DatabaseWrapper wrapper) : super(wrapper);
}
