import 'package:injectable/injectable.dart';

import '../common/config.dart';

import '../env/dev.dart';
import '../env/prod.dart';
import '../env/test.dart';

@module
abstract class AppModule {
  @lazySingleton
  Config getConfig(
    Environment env,
    @Named('DevConfig') DevelopmentConfiguration developmentConfig,
    @Named('ProdConfig') ProductionConfiguration productionConfig,
    @Named('TestConfig') TestConfiguration testConfig,
  ) {
    if (env.name == Environment.prod) {
      return productionConfig;
    } else if (env.name == Environment.dev) {
      return developmentConfig;
    }
    return testConfig;
  }
}
