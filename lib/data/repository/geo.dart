import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

import '../../domain/domain.dart';
import '../../exception/exception.dart';

class KGeoRepository extends GeoRepository {
  final loc.Location _location = loc.Location();

  @override
  Future<bool> serviceEnabled() async {
    return _location.serviceEnabled();
  }

  @override
  Future<bool> requestService() async {
    return _location.requestService();
  }

  @override
  Future<bool> hasPermission() async {
    // if permission is denied and new permission
    // request is also denied, return false
    return !(await _isPermissionDenied() &&
        await _isRequestedPermissionDenied());
  }

  Future<bool> _isPermissionDenied() async {
    return await _location.hasPermission() == loc.PermissionStatus.denied;
  }

  Future<bool> _isRequestedPermissionDenied() async {
    return await _location.requestPermission() == loc.PermissionStatus.denied;
  }

  @override
  Future<DeviceLocation> getAddress() {
    return _location.getLocation().then((point) async {
      if (point.latitude == null || point.longitude == null) {
        throw LocationException();
      }
      return placemarkFromCoordinates(point.latitude!, point.longitude!)
          .then((address) => DeviceLocation(point, address.first));
    }).catchError((_) => throw LocationPermissionDeniedException());
  }

  @override
  Future<String> getRouteImage(String origin, String destination) {
    // TODO: implement getRouteImage
    throw UnimplementedError();
  }

  @override
  void queryMap(String value, listener) {
    // TODO: implement queryMap
  }
}
