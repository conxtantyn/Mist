import 'package:injectable/injectable.dart';

import '../common/common.dart';

@Named('TestConfig')
@Singleton()
class TestConfiguration extends Config {
  TestConfiguration()
      : super(
          debug: true,
          debugApiClient: true,
          debugShowCheckedModeBanner: false,
          db: '',
          title: '',
          apiBaseUrl: '',
          wsUrl: '',
          policyUrl: '',
          appStoreUrl: '',
          playStoreUrl: '',
          googleMapApiKey: '',
          proxyBaseUrl: null,
        );
}
