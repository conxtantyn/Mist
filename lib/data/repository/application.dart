import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';

import '../../common/common.dart';
import '../../domain/domain.dart';
import '../../data/data.dart';
import '../../network/network.dart';
import '../../exception/exception.dart';

class KApplicationRepository extends ApplicationRepository {
  final Config _config;

  final Dio _dio;

  final DatabaseWrapper _databaseWrapper;

  final JWTInterceptor _jwtInterceptor;
  final ErrorInterceptor _errorInterceptor;

  KApplicationRepository(
    this._config,
    this._dio,
    this._databaseWrapper,
    this._jwtInterceptor,
    this._errorInterceptor,
  );

  @override
  Future<Locale> getLocal() async {
    final db = _databaseWrapper.database;
    return (db.select(db.sessions)
          ..where(
            (tbl) => tbl.key.equals(Constants.locale),
          ))
        .getSingleOrNull()
        .then((session) {
      if (session == null) {
        throw InvalidLocale();
      }
      final localeMap = json.decode(session.value);
      return Locale(localeMap['languageCode'], localeMap['countryCode']);
    });
  }

  @override
  Future<Locale> initializeLocale(Locale defaultLocale) {
    final db = _databaseWrapper.database;
    return FlutterSimCountryCode.simCountryCode.then((code) async {
      final locale = Locale(defaultLocale.languageCode, code);
      await db.into(db.sessions).insertOnConflictUpdate(Session(
            key: Constants.locale,
            value: json.encode({
              'languageCode': locale.languageCode,
              'countryCode': locale.countryCode,
            }),
          ));
      return locale;
    });
  }

  @override
  Future<dynamic> initDatabase() async {
    return _databaseWrapper.initialize();
  }

  @override
  Future<void> initNetwork() async {
    _dio.options.baseUrl = _config.apiBaseUrl;

    _dio.options.connectTimeout = Duration(minutes: 3).inMilliseconds;
    _dio.options.receiveTimeout = Duration(minutes: 3).inMilliseconds;

    _dio.interceptors.add(_jwtInterceptor);
    _dio.interceptors.add(_errorInterceptor);

    if (_config.debug) {
      _dio.interceptors.add(
        LogInterceptor(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
      );
    }
  }

  @override
  Future<void> dispose() {
    return _databaseWrapper.close();
  }
}
