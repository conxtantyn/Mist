import 'package:injectable/injectable.dart';

import '../../router/router.dart';

import 'picker/picker_route.dart';

@injectable
class CountryProvider {
  final PickerRoute _pickerRoute;

  CountryProvider(
    @Named('PickerRoute') this._pickerRoute,
  );

  List<KRouter> get routes => <KRouter>[
        _pickerRoute,
      ];
}
