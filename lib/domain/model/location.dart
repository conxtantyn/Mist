import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';

class DeviceLocation {
  final LocationData coordinates;

  final Placemark address;

  DeviceLocation(this.coordinates, this.address);
}
