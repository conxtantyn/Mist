import '../../../data/database/wrapper.dart';
import '../../../data/database/database.dart';

abstract class BaseDao {
  final DatabaseWrapper _wrapper;

  BaseDao(this._wrapper);

  Database get db => _wrapper.database;
}
