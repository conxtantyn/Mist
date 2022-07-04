import 'package:injectable/injectable.dart';

import '../common/common.dart';

@Named('DevConfig')
@Singleton()
class DevelopmentConfiguration extends Config {
  DevelopmentConfiguration()
      : super(
          debug: true,
          debugApiClient: true,
          debugShowCheckedModeBanner: false,
          db: 'db-${Strings.appName}',
          title: Strings.appName,
          apiBaseUrl: 'http://167.71.53.234:8080/api',
          wsUrl: 'ws://167.71.53.234:8080/api/websocket',
          policyUrl: 'http://167.71.53.234:8080/terms-and-conditions',
          appStoreUrl: '',
          playStoreUrl: '',
          googleMapApiKey: 'AIzaSyA6KUkI4tc85eNsfXsWTnG5ErumyzVm6wM',
          proxyBaseUrl: null,
        );
}
