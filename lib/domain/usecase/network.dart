import 'package:injectable/injectable.dart';

import '../repository/application.dart';

@injectable
class InitializeNetworkUsecase {
  final ApplicationRepository _repository;

  InitializeNetworkUsecase(this._repository);

  Future<void> initialize() => _repository.initNetwork();
}
