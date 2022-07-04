import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../common/common.dart';
import '../../../router/router.dart';

import 'request.dart';

@Named('RequestRoute')
@injectable
class RequestRoute extends KRouter {
  RequestRoute();

  @override
  String path = Routes.request;

  @override
  Widget? handlerFunc(BuildContext? context, RouteParam params) {
    return Request();
  }
}
