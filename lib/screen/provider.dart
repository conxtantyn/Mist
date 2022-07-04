import 'package:injectable/injectable.dart';

import '../router/router.dart';

import 'splash/splash_route.dart';
import 'welcome/welcome_route.dart';
import 'home/home_route.dart';

import 'country/provider.dart';
import 'account/provider.dart';
import 'user/provider.dart';
import 'trip/provider.dart';

@injectable
class ScreenProvider {
  final SplashRoute _splashRoute;
  final WelcomeRoute _welcomeRoute;
  final HomeRoute _homeRoute;

  final CountryProvider _countryProvider;
  final AccountProvider _accountProvider;
  final UserProvider _userProvider;
  final TripProvider _tripProvider;

  ScreenProvider(
    @Named('SplashRoute') this._splashRoute,
    @Named('WelcomeRoute') this._welcomeRoute,
    @Named('HomeRoute') this._homeRoute,
    this._countryProvider,
    this._accountProvider,
    this._userProvider,
    this._tripProvider,
  );

  List<KRouter> get routes => <KRouter>[
        _splashRoute,
        _welcomeRoute,
        _homeRoute,
        ..._countryProvider.routes,
        ..._accountProvider.routes,
        ..._userProvider.routes,
        ..._tripProvider.routes,
      ];
}
