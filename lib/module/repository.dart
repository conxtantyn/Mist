import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../common/config.dart';
import '../data/data.dart';

import '../domain/repository/account.dart';
import '../domain/repository/authentication.dart';
import '../domain/repository/trip.dart';
import '../domain/repository/geo.dart';
import '../domain/repository/application.dart';

import '../data/database/wrapper.dart' as db;
import '../data/database/dao/session.dart';

import '../network/interceptor/jwt.dart';
import '../network/interceptor/error.dart';

@module
abstract class RepositoryModule {
  @lazySingleton
  ApplicationRepository getApplicationRepository(
    Config config,
    Dio dio,
    db.DatabaseWrapper _databaseWrapper,
    @Named('jwtInterceptor') JWTInterceptor jwtInterceptor,
    @Named('errorInterceptor') ErrorInterceptor errorInterceptor,
  ) {
    return KApplicationRepository(
      config,
      dio,
      _databaseWrapper,
      jwtInterceptor,
      errorInterceptor,
    );
  }

  AccountRepository getAccountRepository(
    Dio dio,
    @Named('SessionDao') SessionDao sessionDao,
  ) =>
      KAccountRepository(dio, sessionDao);

  TripRepository getTripRepository() => KTripRepository();

  GeoRepository getGeoRepository() => KGeoRepository();

  AuthenticationRepository getAuthenticationRepository(
    Dio dio,
    @Named('SessionDao') SessionDao sessionDao,
  ) =>
      KAuthenticationRepository(dio, sessionDao);
}
