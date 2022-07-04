import 'package:injectable/injectable.dart';

import '../../router/router.dart';

import 'profile/profile_route.dart';

@injectable
class UserProvider {
  final ProfileRoute _profileRoute;

  UserProvider(
    @Named('ProfileRoute') this._profileRoute,
  );

  List<KRouter> get routes => <KRouter>[
        _profileRoute,
      ];
}
