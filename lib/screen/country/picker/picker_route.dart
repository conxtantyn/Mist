import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../common/common.dart';
import '../../../router/router.dart';

import 'picker.dart';

@Named('PickerRoute')
@injectable
class PickerRoute extends KRouter {
  PickerRoute();

  @override
  String path = Routes.countryPicker;

  @override
  Widget? handlerFunc(BuildContext? context, RouteParam params) {
    return Picker();
  }
}
