import 'package:injectable/injectable.dart';

import '../common/config.dart';
import '../domain/usecase/dispose.dart';
import '../router/router_controller.dart';

@injectable
class ApplicationService {
  final Config config;

  final RouterController routerController;

  final DisposeApplicationUsecase _disposeApplicationUsecase;

  ApplicationService(
    this.config,
    this.routerController,
    this._disposeApplicationUsecase,
  );

  Future<void> dispose() {
    return _disposeApplicationUsecase.dispose();
  }
}
