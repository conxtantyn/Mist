import '../../domain/domain.dart';

class KTripRepository extends TripRepository {
  @override
  Future<Trip> get() {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<Trip>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Trip> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<Trip> requestTrip(Place origin, Place destination, DateTime start,
      DateTime end, int seatCount) {
    // TODO: implement requestTrip
    throw UnimplementedError();
  }

  @override
  Future<Trip> update(Trip trip) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
