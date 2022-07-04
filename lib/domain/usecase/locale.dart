import 'dart:ui';

import 'package:injectable/injectable.dart';

import '../repository/application.dart';

@injectable
class InitializeLocaleUsecase {
  final ApplicationRepository _repository;

  InitializeLocaleUsecase(this._repository);

  Future<Locale> initialize(Locale defaultLocale) async {
    return _repository.initializeLocale(defaultLocale);
  }
}

@injectable
class GetLocaleUsecase {
  final ApplicationRepository _repository;

  GetLocaleUsecase(this._repository);

  Future<Locale> get() => _repository.getLocal();
}
