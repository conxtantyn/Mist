import 'package:injectable/injectable.dart';

import '../../../data/database/wrapper.dart';

import 'base.dart';

@Named('LocationDao')
@Singleton()
class LocationDao extends BaseDao {
  LocationDao(DatabaseWrapper wrapper) : super(wrapper);
}
