import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../domain/domain.dart';
import '../../../exception/exception.dart';
import '../../../util/util.dart';

import '../../database/dao/dao.dart';
import '../../database/database.dart' as db;

import 'mapper.dart';

class KAccountRepository extends AccountRepository {
  final Dio _dio;

  final SessionDao _sessionDao;

  KAccountRepository(this._dio, this._sessionDao);

  @override
  Future<void> changePassword(String newPassword, String currentPassword) {
    return _dio.post('/auth/account/change-password', data: {
      'newPassword': newPassword,
      'currentPassword': currentPassword,
    });
  }

  @override
  Future<Account> get() {
    return _sessionDao.getUserSession().then((token) {
      if (token == null) {
        throw UserNotLoggedInException();
      }
      final jwt = JwtDecoder.decode(token.value);
      final rolls = <String>[
        if (jwt['auth'] is List) ...jwt['auth'] else ...[jwt['auth'] as String]
      ];
      final expire = jwt['exp'];
      final expireDate = DateTime.fromMillisecondsSinceEpoch(expire * 1000);
      if (rolls.contains('ROLE_VERIFIED') &&
          expireDate.isBefore(DateTime.now())) {
        throw UserNotLoggedInException();
      }
      return !rolls.contains('ROLE_VERIFIED') ? _get() : _createGuest(rolls);
    });
  }

  Future<Account> _get() {
    return _dio.get('/auth/account').then((result) async {
      final response = Map<String, dynamic>.from(result.data);
      return db.Account(
        id: response['id'] as int,
        login: response['login'] as String,
        firstName: response['firstName'] as String,
        lastName: response['lastName'] as String,
        phone: response['phone'] as String,
        email: response['email'] as String,
        activated: response['activated'] as bool,
        langKey: response['langKey'] as String,
        authorities: List<String>.from(response['authorities']),
      ).mapToEntity();
    });
  }

  Future<Account> _createGuest(List<dynamic> rolls) async {
    return Account(
      id: -1,
      login: getRandomString(10),
      firstName: getRandomString(10),
      lastName: getRandomString(10),
      phone: getRandomNumber(),
      email: '${getRandomString(15)}@domain.com',
      activated: false,
      langKey: getRandomString(2),
      authorities: rolls,
    );
  }

  @override
  Future<void> register(AccountModel model) {
    return _dio.post('/auth/register', data: {
      'login': model.login,
      'firstName': model.firstName,
      'lastName': model.lastName,
      'phone': model.phone,
      'email': model.email,
      'langKey': model.langKey,
      'password': model.password,
      'imageUrl': 'http://placehold.it/50x50',
    }).then((response) {
      return _sessionDao.clearUserSession();
    });
  }

  @override
  Future<void> requestPasswordResetKey(String login) {
    return _dio.post('/auth/account/reset-password/init', data: login);
  }

  @override
  Future<void> resetPassword(String key, String password) {
    return _sessionDao.getLastLoginAttempt().then((session) {
      if (session == null) {
        throw NoLoginAttemptException();
      }
      return _dio.post('/auth/account/reset-password/finish', data: {
        'phone': session.value,
        'key': key,
        'newPassword': password,
      });
    });
  }

  @override
  Future<Account> update(Account account) {
    return _dio.post('/auth/account', data: {
      'login': account.login,
      'firstName': account.firstName,
      'lastName': account.lastName,
      'phone': account.phone,
      'email': account.email,
      'langKey': account.langKey,
      'imageUrl': 'http://placehold.it/50x50',
    }).then((_) => account);
  }

  @override
  Future<void> close() async {}
}
