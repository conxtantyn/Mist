import 'package:drift/drift.dart';

import '../converter/listing.dart';

class Accounts extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get login => text()();

  TextColumn get phone => text()();

  TextColumn get firstName => text()();

  TextColumn get lastName => text()();

  TextColumn get email => text()();

  BoolColumn get activated => boolean()();

  TextColumn get langKey => text()();

  TextColumn get authorities => text().map(const ListingConverter())();
}
