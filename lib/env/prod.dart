import 'package:injectable/injectable.dart';

import '../common/common.dart';

@Named('ProdConfig')
@Singleton()
class ProductionConfiguration extends Config {
  ProductionConfiguration()
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
