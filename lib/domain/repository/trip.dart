import '../model/model.dart';
import '../entity/entity.dart';

abstract class TripRepository {
  Future<Trip> get();

  Future<Trip> getById(int id);

  Future<List<Trip>> getAll();

  Future<Trip> update(Trip trip);

  Future<Trip> requestTrip(
    Place origin,
    Place destination,
    DateTime start,
    DateTime end,
    int seatCount,
  );
}
