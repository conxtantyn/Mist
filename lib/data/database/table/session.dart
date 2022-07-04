import 'package:drift/drift.dart';

class Sessions extends Table {
  @override
  Set<Column> get primaryKey => {key};

  TextColumn get key => text().withLength(min: 6, max: 255)();

  TextColumn get value => text()();

  TextColumn get extra => text().nullable()();
}
