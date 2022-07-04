import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'injector.dart';

import 'common/common.dart';
import 'screen/screen.dart';
import 'service/service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerSingleton<Environment>(Environment(Environment.dev));

  await configureInjection();

  runApp(
    Main(
      index: Routes.splash,
      service: getIt.get<ApplicationService>(),
    ),
  );
}
