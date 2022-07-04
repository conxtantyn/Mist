import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../common/common.dart';
import '../../../router/router.dart';

import 'detail.dart';

@Named('DetailRoute')
@injectable
class DetailRoute extends KRouter {
  DetailRoute();

  @override
  String path = Routes.tripDetail;

  @override
  Widget? handlerFunc(BuildContext? context, RouteParam params) {
    return Detail();
  }
}
