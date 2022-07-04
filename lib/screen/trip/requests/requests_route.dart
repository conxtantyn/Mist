import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../common/common.dart';
import '../../../router/router.dart';

import 'requests.dart';

@Named('RequestsRoute')
@injectable
class RequestsRoute extends KRouter {
  RequestsRoute();

  @override
  String path = Routes.requests;

  @override
  Widget? handlerFunc(BuildContext? context, RouteParam params) {
    return Requests();
  }
}
