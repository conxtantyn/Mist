import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injector.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  ignoreUnregisteredTypes: [Environment],
)
Future<void> configureInjection() async => $initGetIt(
      getIt,
      environment: getIt.get<Environment>().name,
    );
