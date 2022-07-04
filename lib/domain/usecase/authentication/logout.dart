import 'package:injectable/injectable.dart';

import '../../repository/authentication.dart';

@injectable
class LogoutUsecase {
  LogoutUsecase(AuthenticationRepository repository);
}
