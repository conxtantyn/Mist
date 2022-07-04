import '../entity/entity.dart';
import '../model/model.dart';

typedef PlaceListener = void Function(PlaceResult event);

abstract class GeoRepository {
  Future<bool> serviceEnabled();

  Future<bool> requestService();

  Future<bool> hasPermission();

  Future<DeviceLocation> getAddress();

  void queryMap(String value, PlaceListener listener);

  Future<String> getRouteImage(String origin, String destination);
}
