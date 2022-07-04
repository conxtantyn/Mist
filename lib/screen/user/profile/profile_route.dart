import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../common/common.dart';
import '../../../router/router.dart';

import 'profile.dart';

@Named('ProfileRoute')
@injectable
class ProfileRoute extends KRouter {
  ProfileRoute();

  @override
  String path = Routes.profile;

  @override
  Widget? handlerFunc(BuildContext? context, RouteParam params) {
    return Profile();
  }
}
