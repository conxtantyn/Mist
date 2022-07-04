import 'package:drift/drift.dart';

class Trips extends Table {
  IntColumn get id => integer().autoIncrement()();
}
