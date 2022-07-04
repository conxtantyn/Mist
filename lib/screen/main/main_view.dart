import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../theme/theme.dart';
import '../../common/common.dart';
import '../../repository/repository.dart';

import '../../service/service.dart';
import '../../router/router_controller.dart';

import '../base/base.dart';
import '../partials/partials.dart';

import 'main_bloc.dart';
import 'main_state.dart';

class Main extends StatelessWidget {
  final String index;

  final ApplicationService service;

  Main({
    Key? key,
    required this.index,
    required this.service,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themes: <AppTheme>[
        LightTheme(context),
        DarkTheme(context),
      ],
      child: ThemeConsumer(
        child: Builder(builder: (themeContext) {
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<App>(
                create: (context) => App(service.config),
              ),
              RepositoryProvider<PageRouter>(
                create: (context) => PageRouter(service.routerController),
              ),
              RepositoryProvider<AppLocalizations>(
                create: (context) => AppLocalizations.of(themeContext)!,
              ),
              RepositoryProvider<Skin>(
                create: (context) =>
                    ThemeProvider.optionsOf<Skin>(themeContext),
              ),
            ],
            child: BlocProvider(
              create: (_) => MainBloc(service),
              child: _MaterialApp(
                index: index,
                config: service.config,
                controller: service.routerController,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _MaterialApp extends StatelessWidget {
  final String index;

  final Config config;

  final RouterController controller;

  _MaterialApp({
    Key? key,
    required this.index,
    required this.config,
    required this.controller,
  }) : super(key: key);

  Widget _onError(BuildContext context) {
    return MemoWidget(
      title: Strings.appName,
      message: AppLocalizations.of(context)!.indexNotFound,
    );
  }

  @override
  Widget build(BuildContext context) {
    final indexRoute = controller.getHandler(index);
    return _MainView(
      child: MaterialApp(
        title: config.title,
        theme: ThemeProvider.themeOf(context).data,
        navigatorKey: controller.navigatorKey,
        onGenerateRoute: controller.generator,
        debugShowCheckedModeBanner: config.debugShowCheckedModeBanner,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Material(
          child: indexRoute?.handlerFunc(
                context,
                {},
              ) ??
              _onError(context),
        ),
      ),
    );
  }
}

class _MainView extends StatefulWidget {
  final Widget child;

  _MainView({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  __MainViewState createState() => __MainViewState();
}

class __MainViewState extends BaseState<_MainView, MainBloc, MainState> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: _PageScrollBehavior(),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return widget.child;
        },
      ),
    );
  }
}

class _PageScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
