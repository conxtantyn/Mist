import 'package:drift/drift.dart';

class Locations extends Table {
  IntColumn get id => integer().autoIncrement()();
}
