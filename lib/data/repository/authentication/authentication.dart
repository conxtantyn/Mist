import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../domain/domain.dart';
import '../../../exception/exception.dart';

import '../../database/dao/dao.dart';

const int kOtpMinute = 1;

class KAuthenticationRepository extends AuthenticationRepository {
  final Dio _dio;
  final SessionDao _sessionDao;

  KAuthenticationRepository(this._dio, this._sessionDao);

  @override
  Future<bool> authorize(String otp) {
    return _sessionDao.getLastLoginAttempt().then((session) {
      if (session == null) {
        throw NoLoginAttemptException();
      }
      return _dio.post('/auth/authorize', data: {
        'token': otp,
        'phone': session.value,
      }).then((response) => _handleAuthorizationResponse(response));
    });
  }

  Future<bool> _handleAuthorizationResponse(Response<dynamic> response) {
    final token = response.data['id_token'];
    final jwt = JwtDecoder.decode(token);
    final rolls = <String>[
      if (jwt['auth'] is List)
        ...jwt['auth']
      else ...[
        jwt['auth'] as String,
      ]
    ];
    return _sessionDao.setUserSession(token).then((_) {
      return !rolls.contains('ROLE_VERIFIED');
    });
  }

  @override
  Future<bool> login(String password) {
    return _sessionDao.getLastLoginAttempt().then((phone) {
      if (phone == null) {
        throw NoLoginAttemptException();
      }
      return _dio.post('/auth/authenticate', data: {
        'username': phone.value,
        'password': password,
        'rememberMe': true,
      }).then((response) {
        return _handleAuthorizationResponse(response).then((result) {
          if (!result) {
            throw NoLoginAttemptException();
          }
          return result;
        });
      });
    });
  }

  @override
  Future<Attempt> sendOtp(
    String number,
    String lang,
    String device,
    String address,
  ) {
    return _sessionDao.getLastLoginAttempt().then((session) {
      if (session?.extra != null) {
        final now = DateTime.now();
        final date = DateTime.parse(session!.extra!);
        if (session.value == number &&
            now.difference(date).inSeconds <
                (kOtpMinute * Duration.secondsPerMinute)) {
          return lastLogInAttempt();
        }
      }
      return _dio.post('/auth/request-token', data: {
        'phone': number,
        'langKey': lang,
        'address': address,
        'device': device,
      }).then((response) {
        return _sessionDao.setLastLoginAttempt(number).then((session) {
          return lastLogInAttempt();
        });
      });
    });
  }

  @override
  Future<Attempt> lastLogInAttempt() {
    return _sessionDao.getLastLoginAttempt().then((session) {
      if (session == null || session.extra == null) {
        throw NoLoginAttemptException();
      }
      final now = DateTime.now();
      final date = DateTime.parse(session.extra!);
      final diff = now.difference(date).inSeconds;
      return Attempt(
        session.value,
        diff > (kOtpMinute * Duration.secondsPerMinute)
            ? 0
            : ((kOtpMinute * Duration.secondsPerMinute) - diff),
      );
    });
  }

  @override
  Future<void> logout() => _sessionDao.clearUserSession();
}
