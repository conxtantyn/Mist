import 'package:injectable/injectable.dart';

import '../repository/application.dart';

@injectable
class DisposeApplicationUsecase {
  final ApplicationRepository _repository;

  DisposeApplicationUsecase(this._repository);

  Future<void> dispose() async {
    return _repository.dispose();
  }
}
