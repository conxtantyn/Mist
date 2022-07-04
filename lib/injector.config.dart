// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'common/config.dart' as _i20;
import 'data/database/dao/account.dart' as _i26;
import 'data/database/dao/location.dart' as _i23;
import 'data/database/dao/session.dart' as _i24;
import 'data/database/dao/trip.dart' as _i25;
import 'data/database/wrapper.dart' as _i22;
import 'domain/repository/account.dart' as _i27;
import 'domain/repository/application.dart' as _i41;
import 'domain/repository/authentication.dart' as _i28;
import 'domain/repository/geo.dart' as _i7;
import 'domain/repository/trip.dart' as _i17;
import 'domain/usecase/account/password_reset.dart' as _i35;
import 'domain/usecase/account/recovery.dart' as _i34;
import 'domain/usecase/account/register.dart' as _i38;
import 'domain/usecase/account/user.dart' as _i29;
import 'domain/usecase/authentication/login.dart' as _i31;
import 'domain/usecase/authentication/logout.dart' as _i32;
import 'domain/usecase/authentication/password.dart' as _i33;
import 'domain/usecase/authentication/verify.dart' as _i40;
import 'domain/usecase/database.dart' as _i44;
import 'domain/usecase/dispose.dart' as _i42;
import 'domain/usecase/locale.dart' as _i43;
import 'domain/usecase/location.dart' as _i8;
import 'domain/usecase/network.dart' as _i45;
import 'domain/usecase/startup.dart' as _i47;
import 'env/dev.dart' as _i4;
import 'env/prod.dart' as _i11;
import 'env/test.dart' as _i15;
import 'module/app.dart' as _i57;
import 'module/database.dart' as _i58;
import 'module/network.dart' as _i55;
import 'module/repository.dart' as _i56;
import 'module/screen.dart' as _i59;
import 'network/interceptor/error.dart' as _i6;
import 'network/interceptor/jwt.dart' as _i30;
import 'router/router_controller.dart' as _i53;
import 'screen/account/login/login_route.dart' as _i46;
import 'screen/account/password/password_route.dart' as _i36;
import 'screen/account/provider.dart' as _i51;
import 'screen/account/recover/recover_route.dart' as _i37;
import 'screen/account/register/register_route.dart' as _i49;
import 'screen/account/reset/reset_route.dart' as _i39;
import 'screen/account/verification/verification_route.dart' as _i48;
import 'screen/country/picker/picker_route.dart' as _i10;
import 'screen/country/provider.dart' as _i21;
import 'screen/home/home_route.dart' as _i9;
import 'screen/provider.dart' as _i52;
import 'screen/splash/splash_route.dart' as _i50;
import 'screen/trip/detail/detail_route.dart' as _i3;
import 'screen/trip/provider.dart' as _i16;
import 'screen/trip/request/request_route.dart' as _i13;
import 'screen/trip/requests/requests_route.dart' as _i14;
import 'screen/user/profile/profile_route.dart' as _i12;
import 'screen/user/provider.dart' as _i18;
import 'screen/welcome/welcome_route.dart' as _i19;
import 'service/app.dart' as _i54; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final networkModule = _$NetworkModule();
  final repositoryModule = _$RepositoryModule();
  final appModule = _$AppModule();
  final databaseModule = _$DatabaseModule();
  final screenModule = _$ScreenModule();
  gh.factory<_i3.DetailRoute>(() => _i3.DetailRoute(),
      instanceName: 'DetailRoute');
  gh.singleton<_i4.DevelopmentConfiguration>(_i4.DevelopmentConfiguration(),
      instanceName: 'DevConfig');
  gh.lazySingleton<_i5.Dio>(() => networkModule.dio);
  gh.singleton<_i6.ErrorInterceptor>(_i6.ErrorInterceptor(),
      instanceName: 'errorInterceptor');
  gh.factory<_i7.GeoRepository>(() => repositoryModule.getGeoRepository());
  gh.factory<_i8.GetDeviceLocationUsecase>(
      () => _i8.GetDeviceLocationUsecase(get<_i7.GeoRepository>()));
  gh.factory<_i9.HomeRoute>(() => _i9.HomeRoute(), instanceName: 'HomeRoute');
  gh.factory<_i10.PickerRoute>(() => _i10.PickerRoute(),
      instanceName: 'PickerRoute');
  gh.singleton<_i11.ProductionConfiguration>(_i11.ProductionConfiguration(),
      instanceName: 'ProdConfig');
  gh.factory<_i12.ProfileRoute>(() => _i12.ProfileRoute(),
      instanceName: 'ProfileRoute');
  gh.factory<_i13.RequestRoute>(() => _i13.RequestRoute(),
      instanceName: 'RequestRoute');
  gh.factory<_i14.RequestsRoute>(() => _i14.RequestsRoute(),
      instanceName: 'RequestsRoute');
  gh.singleton<_i15.TestConfiguration>(_i15.TestConfiguration(),
      instanceName: 'TestConfig');
  gh.factory<_i16.TripProvider>(() => _i16.TripProvider(
      get<_i3.DetailRoute>(instanceName: 'DetailRoute'),
      get<_i13.RequestRoute>(instanceName: 'RequestRoute'),
      get<_i14.RequestsRoute>(instanceName: 'RequestsRoute')));
  gh.factory<_i17.TripRepository>(() => repositoryModule.getTripRepository());
  gh.factory<_i18.UserProvider>(() =>
      _i18.UserProvider(get<_i12.ProfileRoute>(instanceName: 'ProfileRoute')));
  gh.factory<_i19.WelcomeRoute>(() => _i19.WelcomeRoute(),
      instanceName: 'WelcomeRoute');
  gh.lazySingleton<_i20.Config>(() => appModule.getConfig(
      get<_i2.Environment>(),
      get<_i4.DevelopmentConfiguration>(instanceName: 'DevConfig'),
      get<_i11.ProductionConfiguration>(instanceName: 'ProdConfig'),
      get<_i15.TestConfiguration>(instanceName: 'TestConfig')));
  gh.factory<_i21.CountryProvider>(() =>
      _i21.CountryProvider(get<_i10.PickerRoute>(instanceName: 'PickerRoute')));
  gh.lazySingleton<_i22.DatabaseWrapper>(
      () => databaseModule.getDatabaseWrapper(get<_i20.Config>()));
  gh.singleton<_i23.LocationDao>(_i23.LocationDao(get<_i22.DatabaseWrapper>()),
      instanceName: 'LocationDao');
  gh.singleton<_i24.SessionDao>(_i24.SessionDao(get<_i22.DatabaseWrapper>()),
      instanceName: 'SessionDao');
  gh.singleton<_i25.TripDao>(_i25.TripDao(get<_i22.DatabaseWrapper>()),
      instanceName: 'TripDao');
  gh.singleton<_i26.AccountDao>(_i26.AccountDao(get<_i22.DatabaseWrapper>()),
      instanceName: 'AccountDao');
  gh.factory<_i27.AccountRepository>(() =>
      repositoryModule.getAccountRepository(
          get<_i5.Dio>(), get<_i24.SessionDao>(instanceName: 'SessionDao')));
  gh.factory<_i28.AuthenticationRepository>(() =>
      repositoryModule.getAuthenticationRepository(
          get<_i5.Dio>(), get<_i24.SessionDao>(instanceName: 'SessionDao')));
  gh.factory<_i29.GetUserUsecase>(
      () => _i29.GetUserUsecase(get<_i27.AccountRepository>()));
  gh.singleton<_i30.JWTInterceptor>(
      _i30.JWTInterceptor(get<_i24.SessionDao>(instanceName: 'SessionDao')),
      instanceName: 'jwtInterceptor');
  gh.factory<_i31.LastLoginAttemptUsecase>(
      () => _i31.LastLoginAttemptUsecase(get<_i28.AuthenticationRepository>()));
  gh.factory<_i31.LoginUsecase>(
      () => _i31.LoginUsecase(get<_i28.AuthenticationRepository>()));
  gh.factory<_i32.LogoutUsecase>(
      () => _i32.LogoutUsecase(get<_i28.AuthenticationRepository>()));
  gh.factory<_i33.PasswordLoginUsecase>(
      () => _i33.PasswordLoginUsecase(get<_i28.AuthenticationRepository>()));
  gh.factory<_i34.PasswordRecoveryUsecase>(
      () => _i34.PasswordRecoveryUsecase(get<_i27.AccountRepository>()));
  gh.factory<_i35.PasswordResetUsecase>(
      () => _i35.PasswordResetUsecase(get<_i27.AccountRepository>()));
  gh.factory<_i36.PasswordRoute>(
      () => _i36.PasswordRoute(get<_i33.PasswordLoginUsecase>()),
      instanceName: 'PasswordRoute');
  gh.factory<_i37.RecoverRoute>(
      () => _i37.RecoverRoute(get<_i34.PasswordRecoveryUsecase>()),
      instanceName: 'RecoverRoute');
  gh.factory<_i38.RegisterUsecase>(
      () => _i38.RegisterUsecase(get<_i27.AccountRepository>()));
  gh.factory<_i39.ResetRoute>(
      () => _i39.ResetRoute(get<_i35.PasswordResetUsecase>()),
      instanceName: 'ResetRoute');
  gh.factory<_i40.VerifyOtpUsecase>(
      () => _i40.VerifyOtpUsecase(get<_i28.AuthenticationRepository>()));
  gh.lazySingleton<_i41.ApplicationRepository>(() =>
      repositoryModule.getApplicationRepository(
          get<_i20.Config>(),
          get<_i5.Dio>(),
          get<_i22.DatabaseWrapper>(),
          get<_i30.JWTInterceptor>(instanceName: 'jwtInterceptor'),
          get<_i6.ErrorInterceptor>(instanceName: 'errorInterceptor')));
  gh.factory<_i31.AuthUsecase>(() => _i31.AuthUsecase(
      get<_i31.LoginUsecase>(), get<_i8.GetDeviceLocationUsecase>()));
  gh.factory<_i42.DisposeApplicationUsecase>(
      () => _i42.DisposeApplicationUsecase(get<_i41.ApplicationRepository>()));
  gh.factory<_i43.GetLocaleUsecase>(
      () => _i43.GetLocaleUsecase(get<_i41.ApplicationRepository>()));
  gh.factory<_i44.InitializeDatabaseUsecase>(
      () => _i44.InitializeDatabaseUsecase(get<_i41.ApplicationRepository>()));
  gh.factory<_i43.InitializeLocaleUsecase>(
      () => _i43.InitializeLocaleUsecase(get<_i41.ApplicationRepository>()));
  gh.factory<_i45.InitializeNetworkUsecase>(
      () => _i45.InitializeNetworkUsecase(get<_i41.ApplicationRepository>()));
  gh.factory<_i46.LoginRoute>(() => _i46.LoginRoute(get<_i31.AuthUsecase>()),
      instanceName: 'LoginRoute');
  gh.factory<_i40.ProcessOtpUsecase>(() => _i40.ProcessOtpUsecase(
      get<_i40.VerifyOtpUsecase>(), get<_i29.GetUserUsecase>()));
  gh.factory<_i47.StartupUsecase>(() => _i47.StartupUsecase(
      get<_i43.InitializeLocaleUsecase>(),
      get<_i8.GetDeviceLocationUsecase>(),
      get<_i44.InitializeDatabaseUsecase>(),
      get<_i45.InitializeNetworkUsecase>(),
      get<_i29.GetUserUsecase>()));
  gh.factory<_i48.VerificationRoute>(
      () => _i48.VerificationRoute(get<_i31.AuthUsecase>(),
          get<_i40.ProcessOtpUsecase>(), get<_i31.LastLoginAttemptUsecase>()),
      instanceName: 'VerificationRoute');
  gh.factory<_i29.CreateUserUsecase>(() => _i29.CreateUserUsecase(
      get<_i38.RegisterUsecase>(), get<_i43.GetLocaleUsecase>()));
  gh.factory<_i49.RegisterRoute>(
      () => _i49.RegisterRoute(get<_i29.CreateUserUsecase>()),
      instanceName: 'RegisterRoute');
  gh.factory<_i50.SplashRoute>(
      () => _i50.SplashRoute(get<_i47.StartupUsecase>()),
      instanceName: 'SplashRoute');
  gh.factory<_i51.AccountProvider>(() => _i51.AccountProvider(
      get<_i46.LoginRoute>(instanceName: 'LoginRoute'),
      get<_i48.VerificationRoute>(instanceName: 'VerificationRoute'),
      get<_i36.PasswordRoute>(instanceName: 'PasswordRoute'),
      get<_i49.RegisterRoute>(instanceName: 'RegisterRoute'),
      get<_i37.RecoverRoute>(instanceName: 'RecoverRoute'),
      get<_i39.ResetRoute>(instanceName: 'ResetRoute')));
  gh.factory<_i52.ScreenProvider>(() => _i52.ScreenProvider(
      get<_i50.SplashRoute>(instanceName: 'SplashRoute'),
      get<_i19.WelcomeRoute>(instanceName: 'WelcomeRoute'),
      get<_i9.HomeRoute>(instanceName: 'HomeRoute'),
      get<_i21.CountryProvider>(),
      get<_i51.AccountProvider>(),
      get<_i18.UserProvider>(),
      get<_i16.TripProvider>()));
  gh.factory<_i53.RouterController>(
      () => screenModule.getRouterController(get<_i52.ScreenProvider>()));
  gh.factory<_i54.ApplicationService>(() => _i54.ApplicationService(
      get<_i20.Config>(),
      get<_i53.RouterController>(),
      get<_i42.DisposeApplicationUsecase>()));
  return get;
}

class _$NetworkModule extends _i55.NetworkModule {}

class _$RepositoryModule extends _i56.RepositoryModule {}

class _$AppModule extends _i57.AppModule {}

class _$DatabaseModule extends _i58.DatabaseModule {}

class _$ScreenModule extends _i59.ScreenModule {}
