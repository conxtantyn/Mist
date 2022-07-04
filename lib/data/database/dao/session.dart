import 'package:injectable/injectable.dart';

import '../../../common/common.dart';

import '../../../data/database/wrapper.dart';
import '../../../data/database/database.dart';

import 'base.dart';

@Named('SessionDao')
@Singleton()
class SessionDao extends BaseDao {
  SessionDao(DatabaseWrapper wrapper) : super(wrapper);

  Future<Session?> setLastLoginAttempt(String phone) {
    return db
        .into(db.sessions)
        .insertOnConflictUpdate(Session(
          key: Constants.lastLoginAttempt,
          value: phone,
          extra: DateTime.now().toString(),
        ))
        .then((_) {
      return (db.select(db.sessions)
            ..where(
              (tbl) => tbl.key.equals(Constants.lastLoginAttempt),
            ))
          .getSingleOrNull();
    });
  }

  Future<Session?> getLastLoginAttempt() {
    return (db.select(db.sessions)
          ..where(
            (tbl) => tbl.key.equals(Constants.lastLoginAttempt),
          ))
        .getSingleOrNull();
  }

  Future<Session?> setUserSession(String data) {
    return db
        .into(db.sessions)
        .insertOnConflictUpdate(Session(
          key: Constants.token,
          value: data,
        ))
        .then((_) {
      return (db.select(db.sessions)
            ..where(
              (tbl) => tbl.key.equals(Constants.token),
            ))
          .getSingleOrNull();
    });
  }

  Future<Session?> getUserSession() {
    return (db.select(db.sessions)
          ..where(
            (tbl) => tbl.key.equals(Constants.token),
          ))
        .getSingleOrNull();
  }

  Future<int> clearUserSession() {
    return (db.delete(db.sessions)
          ..where(
            (tbl) => tbl.key.equals(Constants.token),
          ))
        .go();
  }
}
