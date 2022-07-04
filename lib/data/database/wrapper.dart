import 'database.dart';

class DatabaseWrapper {
  final String _db;

  Database? _database;

  DatabaseWrapper(this._db);

  Future<Database> initialize() async {
    if (_database != null) {
      return Future.value(_database);
    }
    _database = await Database.initialize(_db);
    return database;
  }

  Future<void> close() {
    if (_database != null) {
      return _database!.close();
    }
    return Future.value();
  }

  Database get database => _database!;
}
