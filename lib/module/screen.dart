import 'package:injectable/injectable.dart';

import '../router/router_controller.dart';
import '../screen/provider.dart';

@module
abstract class ScreenModule {
  RouterController getRouterController(ScreenProvider provider) =>
      RouterController(provider.routes);
}
