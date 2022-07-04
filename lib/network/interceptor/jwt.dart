import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../exception/exception.dart';
import '../../data/database/dao/session.dart';

@Named('jwtInterceptor')
@Singleton()
class JWTInterceptor extends Interceptor {
  final SessionDao _sessionDao;

  JWTInterceptor(@Named('SessionDao') this._sessionDao);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final session = await _sessionDao.getUserSession();
    if (session == null &&
        options.path.indexOf('/account') == 0 &&
        options.path.indexOf('/account/reset-password') == -1) {
      handler.reject(DioError(
        requestOptions: options,
        error: UserNotLoggedInException(),
      ));
      return;
    } else if (session != null) {
      options.headers['authorization'] = 'Bearer ${session.value}';
    }
    super.onRequest(options, handler);
  }
}
