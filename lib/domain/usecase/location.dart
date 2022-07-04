import 'package:injectable/injectable.dart';

import '../../exception/exception.dart';

import '../model/model.dart';
import '../repository/geo.dart';

@injectable
class GetDeviceLocationUsecase {
  final GeoRepository _repository;

  GetDeviceLocationUsecase(this._repository);

  Future<DeviceLocation> getLocation() async {
    if (!(await _repository.serviceEnabled() ||
        await _repository.requestService())) {
      throw LocationServiceDisabledException();
    }
    if (!(await _repository.hasPermission())) {
      throw LocationPermissionDeniedException();
    }
    return _repository.getAddress();
  }
}
