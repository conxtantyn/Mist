import 'dart:ui';

import 'package:injectable/injectable.dart';

import '../model/model.dart';

import 'account/user.dart';

import 'locale.dart';
import 'location.dart';
import 'network.dart';
import 'database.dart';

@injectable
class StartupUsecase {
  final InitializeLocaleUsecase _localeUsecase;
  final GetDeviceLocationUsecase _locationUsecase;
  final InitializeDatabaseUsecase _databaseUsecase;
  final InitializeNetworkUsecase _networkUsecase;
  final GetUserUsecase _getUserUsecase;

  StartupUsecase(
    this._localeUsecase,
    this._locationUsecase,
    this._databaseUsecase,
    this._networkUsecase,
    this._getUserUsecase,
  );

  Future<Startup> startup(Locale locale) {
    return _databaseUsecase.initialize().then((_) {
      return _locationUsecase.getLocation().then((location) {
        return _localeUsecase.initialize(locale).then((locale) async {
          return _networkUsecase.initialize().then((_) {
            final conf = Configuration(locale, location);
            return _getUserUsecase.getUser().then((user) {
              return Startup(user, conf);
            }).catchError((error) {
              return Startup(null, conf);
            });
          });
        });
      });
    });
  }
}
