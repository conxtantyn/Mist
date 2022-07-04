import 'package:injectable/injectable.dart';

import '../../../data/database/wrapper.dart';

import 'base.dart';

@Named('TripDao')
@Singleton()
class TripDao extends BaseDao {
  TripDao(DatabaseWrapper wrapper) : super(wrapper);
}
