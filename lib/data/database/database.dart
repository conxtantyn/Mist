import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'table/table.dart';
import 'converter/converter.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Accounts,
  Trips,
  Locations,
  Sessions,
])
class Database extends _$Database {
  Database._(QueryExecutor e) : super(e);

  static Future<Database> initialize(String db) async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, db));

    return Database._(NativeDatabase(file));
  }

  @override
  int get schemaVersion => 1;
}
