import 'dart:convert';

import 'package:drift/drift.dart';

class ListingConverter extends TypeConverter<List<dynamic>?, String> {
  const ListingConverter();

  @override
  List<dynamic>? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return List<dynamic>.from(json.decode(fromDb));
  }

  @override
  String? mapToSql(List<dynamic>? value) {
    if (value == null) {
      return null;
    }
    return json.encode(value);
  }
}
