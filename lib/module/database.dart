import 'package:injectable/injectable.dart';

import '../common/config.dart';
import '../data/database/wrapper.dart';

@module
abstract class DatabaseModule {
  @lazySingleton
  DatabaseWrapper getDatabaseWrapper(Config config) {
    return DatabaseWrapper(config.db);
  }
}
