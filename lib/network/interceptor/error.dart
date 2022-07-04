import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../exception/exception.dart';

@Named('errorInterceptor')
@Singleton()
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      handler.reject(DioError(
        requestOptions: err.response!.requestOptions,
        error: UnAuthorizedUserException(),
      ));
      return;
    }
    super.onError(err, handler);
  }
}
