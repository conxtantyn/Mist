import 'package:injectable/injectable.dart';

import '../repository/application.dart';

@injectable
class InitializeDatabaseUsecase {
  final ApplicationRepository _repository;

  InitializeDatabaseUsecase(this._repository);

  Future<void> initialize() => _repository.initDatabase();
}
